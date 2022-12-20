using System;
using System.Linq;
using System.Transactions;
using RMLibs.basic;
using TLServer.BO;
using TLServer.DAO;
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

        public RESTListResult GetSlotStatuses()
        {
            try
            {
                return MakeRestListResponse(BODB.GetSlotStatuses().Cast<BasicObject>().ToList());
            }
            catch (Exception ex)
            {
                return HandleListException(ex);
            }
        }

        public RESTObjectResult NewSlot(Slot slot)
        {
            try
            {
                using (TransactionScope transactionScope = BODB.CreateTransactionScope())
                {
                    slot.StartDateTime = slot.StartDateTime.ToLocalTime();
                    slot.EndDateTime = slot.EndDateTime.ToLocalTime();
                    if (!BODB.VerifySlot(slot))
                    {
                        transactionScope.Dispose();
                        return MakeRestObjectResponse(null, false, 1, "Not compatible slot!");
                    }
                    BODB.NewSlot(slot);
                    transactionScope.Complete();
                }
                return MakeRestObjectResponse(null);
            }
            catch (Exception ex)
            {
                return HandleObjectException(ex);
            }
        }

        public RESTObjectResult GetSlotById(int id)
        {
            try
            {
                return MakeRestObjectResponse(BODB.GetSlotById(id));
            }
            catch (Exception ex)
            {
                return HandleObjectException(ex);
            }

        }

        public RESTObjectResult UpdateSlot(Slot slot)
        {
            try
            {
                using (TransactionScope transactionScope = BODB.CreateTransactionScope())
                {
                    slot.StartDateTime = slot.StartDateTime.ToLocalTime();
                    slot.EndDateTime = slot.EndDateTime.ToLocalTime();
                    if (!BODB.VerifySlot(slot))
                    {
                        transactionScope.Dispose();
                        return MakeRestObjectResponse(null, false, 1, "Not compatible slot!");
                    }
                    BODB.UpdateSlot(slot);
                    transactionScope.Complete();
                }
                return MakeRestObjectResponse(null);
            }
            
            catch (Exception ex)
            {
                return HandleObjectException(ex);
            }

        }
    }
}

