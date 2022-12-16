using System;
using System.Linq;
using RMLibs.basic;
using TLServer.BO;
using TLServer.Logging;

namespace TLServer.BL
{
	public class SchedulerBL: GenericBL
	{
        #region Singleton

        private static SchedulerBL instance = null;
        private static readonly object padlock = new object();

        public static SchedulerBL Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new SchedulerBL();
                    }
                    return instance;
                }
            }
        }

        private SchedulerBL() : base(TLLogger.Instance)
        {
        }

        #endregion

        public RESTListResult GetSlotByInterval(DateTimeInterval interval)
        {
            try
            {
                return MakeRestListResponse(BODB.GetSlotByInterval(interval).Cast<BasicObject>().ToList());
            }
            catch (Exception ex)
            {
                return HandleListException(ex);
            }
        }
    }
}

