using RMLibs.basic;

namespace TLServer.BO;

public class ChangePassData : BasicObject
{
    public string Email { set; get; }
    public string OldPassword { set; get; }
    public string NewPassword { set; get; }
    public string ConfirmPassword { set; get; }
}