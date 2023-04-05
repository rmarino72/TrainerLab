using TLServer.Logging;

namespace TLServer.DBManager
{
	public class BoDbInstance: TlDbManager
	{
        #region Singleton

        private static BoDbInstance instance = null;
        private static readonly object padlock = new object();

        public static BoDbInstance Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new BoDbInstance();
                    }
                    return instance;
                }
            }
        }

        private BoDbInstance() : base(TlLogger.Instance)
        {
            DbHost = Config.DbHost;
            TcpPort = Config.DbPort;
            DbUser = Config.DbUser;
            DbPassword = Config.DbPassword;
            DbName = Config.DbName;
            OpenConnection();
            CloseConnection();
        }


        #endregion
    }
}

