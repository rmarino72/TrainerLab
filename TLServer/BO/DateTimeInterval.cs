using System;
using RMLibs.basic;

namespace TLServer.BO;

public class DateTimeInterval : BasicObject
{
    public DateTime Start { set; get; }
    public DateTime End { set; get; }
}