using Dapper;
using RMLibs.basic;

namespace TLServer.DAO;

[Table("trainingplandetail")]
public class TrainingPlanDetail: BasicObject
{
    [Key]
    public int Id { set; get; }
    public int? TrainingPlanId { set; get; }
    public int Day { set; get; }
    public int SeqNumber { set; get; }
    public int ExerciseId { set; get; }
    public string Time { set; get; }
    public string Sequences { set; get; }
    public string Repetitions { set; get; }
    public string Notes { set; get; }
}