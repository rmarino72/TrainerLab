using RMLibs.Logging;
using System.IO;

namespace TLServer.Logging
{
	public class TlLogger: Logger
	{
        #region Singleton

        private static TlLogger _instance;
        private static readonly object Padlock = new object();

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
            LogPath = Path.Combine(Config.BaseDir,  Config.LogPath);
            if (Config.Verbose) Level = Logger.VERBOSE;
            else if (Config.Debug) Level = Logger.DEBUG;
            else Level = Logger.INFO;
        }


        #endregion
    }
}

