using System;
using System.Linq;
using System.Collections.Generic;
using TLServer.BO;
using TLServer.Logging;
using RMLibs.basic;

namespace TLServer.BL
{
	public class UserBL: GenericBL
	{

        #region Singleton

        private static UserBL instance = null;
        private static readonly object padlock = new object();

        public static UserBL Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new UserBL();
                    }
                    return instance;
                }
            }
        }

        private UserBL() : base(TLLogger.Instance)
        {
        }

        #endregion

        public RESTListResult GetProvinces()
		{
			try
			{
				return MakeRestListResponse(BODB.GetProvinces().Cast<BasicObject>().ToList());
			}
			catch (Exception ex)
			{
				Error(ex);
				throw;
			}
		}
	}
}

