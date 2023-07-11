using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using RMLibs.Utilities;
using Spire.Doc;
using Spire.Doc.Documents;
using Spire.Doc.Fields;
using TLServer.BO;
using OfficeOpenXml;
using Spire.Xls;
using FileFormat = Spire.Doc.FileFormat;


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
        try
        {
            ExcelPackage excelPackage = new ExcelPackage(new FileInfo(Path.Combine(Config.BaseDir, Config.TemplatesPath, "PlicoTemplate.xlsx")));
            var ws = excelPackage.Workbook.Worksheets[1];
            //excelApp = new Application();
            //baseWorkbook = excelApp.Workbooks.Open(Path.Combine(Config.BaseDir, Config.TemplatesPath, "PlicoTemplate.xlsx"), 2, false);
            DeleteOldFiles();
            var plicometry = BODB.GetPlicometryById(id);
            var userData = BODB.GetUserDataByEmail(plicometry.Email);
            var tmp = (DateTime.Now - userData.BirthDate);
            var age = (new DateTime(tmp.Ticks)).Year;
            
            //var baseSheet = (Worksheet)baseWorkbook.Worksheets.Item[1];

            ws.Cells[10, 1].Value = userData.FirstName + " " + userData.LastName;
            ws.Cells[16, 2].Value = plicometry.Pectoral;
            ws.Cells[17, 2].Value = plicometry.Axillary;
            ws.Cells[18, 2].Value = plicometry.Suprailiac;
            ws.Cells[19, 2].Value = plicometry.Abdominal;
            ws.Cells[20, 2].Value = plicometry.Thigh;
            ws.Cells[21, 2].Value = plicometry.Subscapular;
            ws.Cells[22, 2].Value = plicometry.Triceps;

            double? plicoSum = plicometry.Pectoral + plicometry.Axillary +
                              plicometry.Suprailiac + plicometry.Abdominal +
                              plicometry.Thigh + plicometry.Subscapular + plicometry.Triceps;
            
            if (plicoSum != null)
            {
                var percentages =(Percentages) UserBL.Instance.GetPercentages(userData.Email, (double)plicoSum).Data;
                ws.Cells[30, 2].Value = Math.Round((100 - percentages.FatPercentage),2);
                ws.Cells[31, 2].Value = Math.Round(percentages.FatPercentage, 2);
            }

            var fileName = SecurityUtils.GetNewGuid();
            /*baseWorkbook.ExportAsFixedFormat(XlFixedFormatType.xlTypePDF, Path.Combine(Config.BaseDir, Config.TmpPath, fileName));
            excelApp.DisplayAlerts = false;
            baseWorkbook.Close();
            excelApp.Quit();*/
            excelPackage.SaveAs(new FileInfo(Path.Combine(Config.BaseDir, Config.TmpPath, fileName + ".xlsx")));
            excelPackage.Dispose();

            Workbook workbook = new Workbook();
            workbook.LoadFromFile(Path.Combine(Config.BaseDir, Config.TmpPath, fileName + ".xlsx"));
            workbook.SaveToFile(Path.Combine(Config.BaseDir, Config.TmpPath, fileName + ".pdf"), Spire.Xls.FileFormat.PDF);
            workbook.Dispose();
            File.Delete(Path.Combine(Config.BaseDir, Config.TmpPath, fileName + ".xlsx"));
            return MakeRestObjectResponse(null, message: fileName + ".pdf");
        }
        catch (Exception ex)
        {
            
            Error(ex);
            return HandleObjectException(ex);
        }
    }
}