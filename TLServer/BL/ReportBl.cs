using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
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
}