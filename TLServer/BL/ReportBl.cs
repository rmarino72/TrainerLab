using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using Microsoft.Office.Interop.Excel;
using RMLibs.Utilities;
using Spire.Doc;
using Spire.Doc.Documents;
using Spire.Doc.Fields;
using TLServer.BO;

namespace TLServer.BL;

public class ReportBl:GenericBl
{
    
    private void DeleteOldFiles()
    {
        try
        {
            var files = Directory.GetFiles(Config.BaseDir + Config.TmpPath, "*.pdf");
            foreach (var file in files)
                if (File.GetCreationTime(file).AddMinutes(10) < DateTime.Now)
                    File.Delete(file);
        }
        catch (Exception e)
        {
            Error(e);
            throw;
        }
    }
    public RestObjectResult PrintPlan(int id)
    {
        try
        {
            DeleteOldFiles();
            var trainingPlan = BODB.GetFullTrainingPlanById(id);
            var doc = new Document(Config.BaseDir + Config.TemplatesPath + "TrainingPlan.docx");
            var last = trainingPlan.Last();
            var numOfDays = last.Day;
            Section lastSection = null;
            foreach (Section section in doc.Sections)
            {
                foreach (Paragraph paragraph in section.Body.Paragraphs)
                {
                    paragraph.Text = paragraph.Text.Replace("{{FirstName}}", last.FirstName);
                    paragraph.Text = paragraph.Text.Replace("{{LastName}}", last.LastName);
                    paragraph.Text = paragraph.Text.Replace("{{Name}}", last.Name);
                    paragraph.Text = paragraph.Text.Replace("{{Date}}", DateTimeUtils.DateTimeToDateExplicitStringIta(last.Date));
                    paragraph.Text = paragraph.Text.Replace("{{Note}}", last.Description);
                }

                lastSection = section;
            }
            
            for(int i=1; i<=numOfDays; i++)
            {
                Paragraph dayParagraph = lastSection.AddParagraph();
                
                TextRange textRange = dayParagraph.AppendText("Giorno " + i);
                textRange.CharacterFormat.Bold = true;
                textRange.CharacterFormat.FontSize = 16;

                List<FullTrainingPlanView> dailyList = trainingPlan.Where(x => x.Day == i).ToList();
                foreach (var exercise in dailyList)
                {
                    var p = lastSection.AddParagraph();
                    var tr = p.AppendText(exercise.ExerciseName);
                    tr.CharacterFormat.Bold = true;

                    p = lastSection.AddParagraph();
                    p.AppendText("Serie: " + exercise.Sequences + " - Ripetizioni: " + exercise.Repetitions +
                                 " - Tempo: " + exercise.Time);
                    p = lastSection.AddParagraph();
                    p.AppendText("Note sull'esercizio: " + exercise.Notes);
                    p = lastSection.AddParagraph();
                    p.AppendText(" ");
                }
            }
            
            var newName = SecurityUtils.GetNewGuid() + ".pdf";
            doc.SaveToFile(Config.BaseDir + Config.TmpPath + newName, FileFormat.PDF);
            return MakeRestObjectResponse(null, message:newName);
        }
        catch (Exception ex)
        {
            Error(ex);
            return HandleObjectException(ex);
        }
        
    }

    public RestObjectResult PrintPlicometry(int id)
    {
        var excelApp = new Application();
        var baseWorkbook = excelApp.Workbooks.Open(Path.Combine(Config.BaseDir, Config.TemplatesPath, "PlicoTemplate.xlsx"), 2, false);
        try
        {
            var plicometry = BODB.GetPlicometryById(id);
            var userData = BODB.GetUserDataByEmail(plicometry.Email);
            var tmp = (DateTime.Now - userData.BirthDate);
            var age = (new DateTime(tmp.Ticks)).Year;
            
            var baseSheet = (Worksheet)baseWorkbook.Worksheets.Item[1];

            baseSheet.Cells[10, 1] = userData.FirstName + " " + userData.LastName;
            baseSheet.Cells[16, 2] = plicometry.Pectoral;
            baseSheet.Cells[17, 2] = plicometry.Axillary;
            baseSheet.Cells[18, 2] = plicometry.Suprailiac;
            baseSheet.Cells[19, 2] = plicometry.Abdominal;
            baseSheet.Cells[20, 2] = plicometry.Thigh;
            baseSheet.Cells[21, 2] = plicometry.Subscapular;
            baseSheet.Cells[22, 2] = plicometry.Triceps;

            double? plicoSum = plicometry.Pectoral + plicometry.Axillary +
                              plicometry.Suprailiac + plicometry.Abdominal +
                              plicometry.Thigh + plicometry.Subscapular + plicometry.Triceps;
            
            if (plicoSum != null)
            {
                var percentages =userData.Sex =="M"? 
                    GymnFormulas.FatPercentage(GymnFormulas.BodyDensityMan((double)plicoSum, age)):
                    GymnFormulas.FatPercentage(GymnFormulas.BodyDensityWoman((double)plicoSum, age));
                baseSheet.Cells[30, 2] = Math.Round((100 - percentages),2);
                baseSheet.Cells[31, 2] = Math.Round(percentages);
            }

            var fileName = SecurityUtils.GetNewGuid() + ".pdf";
            baseWorkbook.ExportAsFixedFormat(XlFixedFormatType.xlTypePDF, Path.Combine(Config.BaseDir, Config.TmpPath, fileName));
            excelApp.DisplayAlerts = false;
            baseWorkbook.Close();
            excelApp.Quit();
            return MakeRestObjectResponse(null, message: fileName);
        }
        catch (Exception ex)
        {
            baseWorkbook.Close();
            excelApp.Quit();
            Error(ex);
            return HandleObjectException(ex);
        }
    }
}