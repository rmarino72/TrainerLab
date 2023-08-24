using System;
using Dapper;
using TLServer.DAO;

namespace TLServer.BO;

[Table("fullmedicalanthropometryview")]
public class FullMedicalAnthropometryView: MedicalAnthropometry
{
    public string FirstName { set; get; }
    public string LastName { set; get; }
    public DateTime BirthDate { set; get; }
    public float Height { set; get; }
    public string Sex { set; get; }
}