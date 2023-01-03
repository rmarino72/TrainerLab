using RMLibs.Logging;

namespace TLServer.Logging
{
	public class TLLogger: Logger
	{
        #region Singleton

        private static TLLogger instance = null;
        private static readonly object padlock = new object();

        public static TLLogger Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new TLLogger();
                    }
                    return instance;
                }
            }
        }

        private TLLogger() : base(Config.LogName)
        {            
            LogPath = Config.LogPath;
            if (Config.Verbose) Level = Logger.VERBOSE;
            else if (Config.Debug) Level = Logger.DEBUG;
            else Level = Logger.INFO;
        }


        #endregion
    }
}

