using System;
using TLServer.BO;
using TLServer.Logging;

namespace TLServer.BL
{
	public class TLAppBL:GenericBl
	{
        #region Singleton

        private static TLAppBL instance = null;
        private static readonly object padlock = new object();

        public static TLAppBL Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new TLAppBL();
                    }
                    return instance;
                }
            }
        }

        private TLAppBL() : base(TlLogger.Instance)
        {
        }

        #endregion

        public RestObjectResult GetConfig()
        {
            try
            {
                return MakeRestObjectResponse(BODB.GetConfig());
            }
            catch (Exception ex)
            {
                return HandleObjectException(ex);
            }
        }

        public RestObjectResult UpdateConfig(DAO.Config config)
        {
            try
            {
                BODB.UpdateConfig(config);
                TLServer.Config.DismissTolerance = config.DismissTolerance;
                return MakeRestObjectResponse(null);
            }
            catch (Exception ex)
            {
                return HandleObjectException(ex);
            }
        }
    }
}

