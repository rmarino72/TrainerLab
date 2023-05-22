using System;

namespace RMLibs.Utilities;

public class SecurityUtils
{
    public static string GetNewGuid()
    {
        return Guid.NewGuid().ToString();
    }
}