using System;
using Dapper;
using RMLibs.basic;

namespace TLServer.DAO;

[Table("medicalanthropometry")]
public class MedicalAnthropometry : BasicObject
{
    [Key] public int Id { set; get; }

    public string Name { set; get; }
    public DateTime DateTime { set; get; }
    public float? Height { set; get; }
    public float? Weight { set; get; }
    public float? ShoulderCirc { set; get; }
    public float? ChestCirc { set; get; }
    public float? BellyCirc { set; get; }
    public float? HipsCirc { set; get; }
    public float? ArmLeftCirc { set; get; }
    public float? ArmRightCirc { set; get; }
    public float? ThighLeftCirc { set; get; }
    public string Mail { set; get; }
    public float? ThighRightCirc { set; get; }
    public float? CalfLeftCirc { set; get; }
    public float? CalfRightCirc { set; get; }
    public float? Bmi { set; get; }
    public float? Pectoral { set; get; }
    public float? Axillary { set; get; }
    public float? Suprailiac { set; get; }
    public float? Abdominal { set; get; }
    public float? Thigh { set; get; }
    public float? Subscapular { set; get; }
    public float? Triceps { set; get; }
    public string Notes { set; get; }
    public DateTime LastUpdateDateTime { set; get; }
}