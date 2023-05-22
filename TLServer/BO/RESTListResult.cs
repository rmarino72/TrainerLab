using System.Collections.Generic;
using RMLibs.basic;

namespace TLServer.BO;

public class RestListResult : BasicObject
{
    public bool Outcome { set; get; }
    public int Code { set; get; }
    public List<BasicObject> Data { set; get; }
    public string Message { set; get; }
}