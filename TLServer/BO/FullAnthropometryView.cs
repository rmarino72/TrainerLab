using System;
using TLServer.DAO;

namespace TLServer.BO;

public class FullAnthropometryView : Anthropometry
{
    public string FirstName { set; get; }
    public string LastName { set; get; }
    public DateTime BirthDate { set; get; }
    public string Sex { set; get; }
    public float? Height { set; get; }
}