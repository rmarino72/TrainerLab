using System;
using Dapper;
using RMLibs.basic;

namespace TLServer.DAO;

[Table("plicometry")]
public class Plicometry : BasicObject
{
    [Key] public int Id { set; get; }

    public string Email { set; get; }
    public DateTime Date { set; get; }
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