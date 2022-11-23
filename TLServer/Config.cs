using System;
using System.Configuration;
namespace TLServer
{
	public class Config
	{
        public static string BaseDir { set; get; }

        public static string DBHost { set; get; }
        public static int DBPort { set; get; }
        public static string DBName { set; get; }
        public static string DBUser { set; get; }
        public static string DBPassword { set; get; }

        public static string LogName { set; get; }
        public static string LogPath { set; get; }
        public static bool Debug { set; get; }
        public static bool Verbose { set; get; }
    }
}

