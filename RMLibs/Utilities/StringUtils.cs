using System;
using System.Text;

namespace RMLibs.Utilities;

public static class StringUtils
{
    public static string EncodeBase64(string value)
    {
        var plainTextBytes = Encoding.UTF8.GetBytes(value);
        return Convert.ToBase64String(plainTextBytes);
    }

    public static string DecodeBase64(string value)
    {
        var base64EncodedBytes = Convert.FromBase64String(value);
        return Encoding.UTF8.GetString(base64EncodedBytes);
    }

    public static bool IsInteger(string value)
    {
        var isNumeric = int.TryParse(value, out _);
        return isNumeric;
    }

    public static string[] Split(string s, string separator)
    {
        return s.Split(new[] { separator }, StringSplitOptions.None);
    }
}