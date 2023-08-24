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

    public RestObjectResult PrintAnthropometry(int id)
    {
        try
        {
            var anthropometryData = BODB.GetMedicalAnthropometryById(id);
            var userData = BODB.GetUserDataByEmail(anthropometryData.Mail);
            var tmp = (DateTime.Now - userData.BirthDate);
            var age = (new DateTime(tmp.Ticks)).Year;
            
            ExcelPackage excelPackage = new ExcelPackage(new FileInfo(Path.Combine(Config.BaseDir, Config.TemplatesPath, "AnthropometryTemplate.xlsx")));
            var ws = excelPackage.Workbook.Worksheets[1];

            ws.Cells[9, 8].Value = anthropometryData.DateTime.ToString("dd/MM/yyyy");
            ws.Cells[9, 3].Value = anthropometryData.Name;
            ws.Cells[11, 1].Value = userData.FirstName + " " + userData.LastName;
            ws.Cells[13, 3].Value = userData.BirthDate.ToString("dd/MM/yyyy");
            ws.Cells[14, 3].Value = age;
            ws.Cells[15, 3].Value = userData.Sex;
            ws.Cells[16, 3].Value = userData.Email;
            
            ws.Cells[20, 2].Value = anthropometryData.Height;
            ws.Cells[20, 4].Value = anthropometryData.Weight;

            ws.Cells[23, 2].Value = anthropometryData.ShoulderCirc;
            ws.Cells[23, 4].Value = anthropometryData.ChestCirc;
            ws.Cells[23, 6].Value = anthropometryData.BellyCirc;
            ws.Cells[23, 8].Value = anthropometryData.HipsCirc;
            
            ws.Cells[24, 2].Value = anthropometryData.ArmLeftCirc;
            ws.Cells[24, 4].Value = anthropometryData.ArmRightCirc;
            ws.Cells[24, 6].Value = anthropometryData.ThighLeftCirc;
            ws.Cells[24, 8].Value = anthropometryData.ThighRightCirc;
            
            ws.Cells[25, 2].Value = anthropometryData.CalfLeftCirc;
            ws.Cells[25, 4].Value = anthropometryData.CalfRightCirc;
            
            ws.Cells[59, 1].Value = anthropometryData.Notes;
            
            double? plicoSum = anthropometryData.Pectoral + anthropometryData.Axillary +
                               anthropometryData.Suprailiac + anthropometryData.Abdominal +
                               anthropometryData.Thigh + anthropometryData.Subscapular + anthropometryData.Triceps;
            ws.Cells[30, 2].Value = anthropometryData.Pectoral;
            ws.Cells[31, 2].Value = anthropometryData.Axillary;
            ws.Cells[32, 2].Value = anthropometryData.Suprailiac;
            ws.Cells[33, 2].Value = anthropometryData.Abdominal;
            ws.Cells[34, 2].Value = anthropometryData.Thigh;
            ws.Cells[35, 2].Value = anthropometryData.Subscapular;
            ws.Cells[36, 2].Value = anthropometryData.Triceps;
            if (plicoSum != null)
            {
                var percentages =(Percentages) UserBL.Instance.GetPercentages(userData.Email, (double)plicoSum).Data;
                ws.Cells[45, 2].Value = Math.Round((100 - percentages.FatPercentage),2);
                ws.Cells[46, 2].Value = Math.Round(percentages.FatPercentage, 2);
            }
            
            var fileName = SecurityUtils.GetNewGuid();

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

    public RestObjectResult PrintPlicometry(int id)
    {
        try
        {
            ExcelPackage excelPackage = new ExcelPackage(new FileInfo(Path.Combine(Config.BaseDir, Config.TemplatesPath, "PlicoTemplate.xlsx")));
            var ws = excelPackage.Workbook.Worksheets[1];

            DeleteOldFiles();
            var plicometry = BODB.GetPlicometryById(id);
            var userData = BODB.GetUserDataByEmail(plicometry.Email);
            var tmp = (DateTime.Now - userData.BirthDate);
            var age = (new DateTime(tmp.Ticks)).Year;
            

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