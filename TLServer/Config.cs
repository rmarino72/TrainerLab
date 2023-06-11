namespace TLServer;

public static class Config
{
    public static bool Local { set; get; }
    public static string Version { set; get; }
    public static string Name { set; get; }
    public static string DisplayName { set; get; }
    public static int Session { set; get; }

    public static string BaseDir { set; get; }

    public static string DbHost { set; get; }
    public static int DbPort { set; get; }
    public static string DbName { set; get; }
    public static string DbUser { set; get; }
    public static string DbPassword { set; get; }

    public static string LogName { set; get; }
    public static string LogPath { set; get; }
    public static bool Debug { set; get; }
    public static bool Verbose { set; get; }

    public static string ImagesPath { set; get; }
    public static string TemplatesPath { set; get; }
    public static string TmpPath { set; get; }

    /*Config table*/
    public static int DismissTolerance { set; get; }
}