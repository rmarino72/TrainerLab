using System.IO;
using RMLibs.Logging;

namespace TLServer.Logging;

public class TlLogger : Logger
{
    #region Singleton

    private static TlLogger _instance;
    private static readonly object Padlock = new();

    public static TlLogger Instance
    {
        get
        {
            lock (Padlock)
            {
                return _instance ??= new TlLogger();
            }
        }
    }

    private TlLogger() : base(Config.LogName)
    {
        LogPath = Path.Combine(Config.BaseDir, Config.LogPath);
        if (Config.Verbose) Level = VERBOSE;
        else if (Config.Debug) Level = DEBUG;
        else Level = INFO;
    }

    #endregion
}