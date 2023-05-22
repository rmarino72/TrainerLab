using System;
using System.Globalization;

namespace RMLibs.Utilities;

public static class DateTimeUtils
{
    public static string DateTimeToMySqlString(DateTime dateTime)
    {
        return dateTime.ToString("yyyy-MM-dd HH:mm:ss");
    }

    public static string DateTimeToDateExplicitStringIta(DateTime dateTime)
    {
        var cultureInfo = CultureInfo.CreateSpecificCulture("it-IT");
        return dateTime.ToString("dd MMMM yyyy", cultureInfo);
    }

    public static string DateTimeToDateTimeExplicitStringIta(DateTime dateTime)
    {
        var cultureInfo = CultureInfo.CreateSpecificCulture("it-IT");
        return dateTime.ToString("dd MMMM yyyy HH:mm", cultureInfo);
    }
}