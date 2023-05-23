using System;
using Dapper;
using RMLibs.basic;

namespace TLServer.DAO;

[Table("anthropometry")]
public class Anthropometry : BasicObject
{
    [Key] public int Id { set; get; }

    public string Email { set; get; }
    public DateTime Date { set; get; }
    public float? Weight { set; get; }
    public float? ShoulderCirc { set; get; }
    public float? BellyCirc { set; get; }
    public float? ChestCirc { set; get; }
    public float? HipsCirc { set; get; }
    public float? ArmLeftCirc { set; get; }
    public float? ArmRightCirc { set; get; }
    public float? ThighLeftCirc { set; get; }
    public float? ThighRightCirc { set; get; }
    public float? CalfLeftCirc { set; get; }
    public float? CalfRightCirc { set; get; }
    public float? BMI { set; get; }
    public string Notes { set; get; }
    public DateTime LastUpdateDateTime { set; get; }
}