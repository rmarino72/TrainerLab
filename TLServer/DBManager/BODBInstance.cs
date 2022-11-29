using System;

using TLServer.Logging;

namespace TLServer.DBManager
{
	public class BODBInstance: TLDBManager
	{
        #region Singleton

        private static BODBInstance instance = null;
        private static readonly object padlock = new object();

        public static BODBInstance Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new BODBInstance();
                    }
                    return instance;
                }
            }
        }

        private BODBInstance() : base(TLLogger.Instance)
        {
            DBHost = Config.DBHost;
            TCPPort = Config.DBPort;
            DBUser = Config.DBUser;
            DBPassword = Config.DBPassword;
            DBName = Config.DBName;
            OpenConnection();
            CloseConnection();
        }


        #endregion
    }
}

