using System;
using System.Globalization;

namespace RMLibs.Utilities
{
	public class DateTimeUtils
	{
        public static string DateTimeToMySqlString(DateTime dateTime)
        {
            return dateTime.ToString("yyyy-MM-dd HH:mm:ss");
        }

        public static string DateTimeToDateExplicitStringITA(DateTime dateTime)
        {
            CultureInfo cultureInfo = CultureInfo.CreateSpecificCulture("it-IT");
            return dateTime.ToString("dd MMMM yyyy", cultureInfo);
        }

        public static string DateTimeToDateTimeExplicitStringITA(DateTime dateTime)
        {
            CultureInfo cultureInfo = CultureInfo.CreateSpecificCulture("it-IT");
            return dateTime.ToString("dd MMMM yyyy HH:mm", cultureInfo);
        }
    }
}

