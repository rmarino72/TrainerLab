using System;
using Dapper;
using RMLibs.basic;

namespace TLServer.DAO;

[Table("trainingplan")]
public class TrainingPlan: BasicObject
{
    [Key]
    public int Id { set; get; }
    public string Name { set; get; }
    public string Description { set; get; }
    public DateTime Date { set; get; }
    public int User { set; get; }
}
