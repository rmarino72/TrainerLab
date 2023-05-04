using System;
using Dapper;
using RMLibs.basic;

namespace TLServer.BO;

[Table("fulltrainingplanview")]
public class FullTrainingPlanView: BasicObject
{
    [Key]
    public int Id { set; get; }
    public string FirstName { set; get; }
    public string LastName { set; get; }
    public string Email { set; get; }
    public string Name { set; get; }
    public DateTime Date { set; get; }
    public string Description { set; get; }
    public int Day { set; get; }
    public int ExerciseId { set; get; }
    public string ExerciseName { set; get; }
    public string Repetitions { set; get; }
    public string Sequences { set; get; }
    public string Time { set; get; }
    public string Notes { set; get; }
    public string MuscularGroup { set; get; }
    public string MuscularGroupName { set; get; }
    public string ExerciseDescription { set; get; }
    public string Image { set; get; }

}