using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using Org.BouncyCastle.Math.EC;
using RMLibs.basic;
using TLServer.BO;
using TLServer.DAO;
using TLServer.Enums;
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
                    Slot slotTmp = BODB.GetSlotById(slot.Id);
                    if (slotTmp.Status == "DONE")
                    {
                        transactionScope.Dispose();
                        return MakeRestObjectResponse(null, false, 4, "A done slot cannot be edited");
                    }
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

        public RESTObjectResult DeleteSlot(int id)
        {
            try
            {
                Slot slot = BODB.GetSlotById(id);
                if (slot == null)
                {
                    return MakeRestObjectResponse(null, false, 3, "Slot not found");
                }
                if (slot.Status == "DONE")
                {
                    return MakeRestObjectResponse(null, false, 2, "Can't delete a done Slot");
                }
                BODB.DeleteSlot(id);
                return MakeRestObjectResponse(null);
            }
            catch (Exception ex)
            {
                return HandleObjectException(ex);
            }

        }

        public RESTListResult GetMySlots(string email, DateTimeInterval interval)
        {
            try
            {
                List<FullSlotView> slots = BODB.GetSlotByInterval(interval);
                return MakeRestListResponse(slots.FindAll(x => x.Email == email || x.Status == SlotStatusEnum.FREE).Cast<BasicObject>().ToList());
            }
            catch (Exception ex)
            {
                return HandleListException(ex);
            }
        }

        public RESTObjectResult BookSlot(string email, int id)
        {
            try
            {
                using (TransactionScope ts = BODB.CreateTransactionScope())
                {
                    Slot slot = BODB.GetSlotById(id);
                    if (slot.StartDateTime < DateTime.Now)
                    {
                        return MakeRestObjectResponse(null, false, 1, "Slot has expired");
                    }
                    slot.Email = email;
                    slot.Status = SlotStatusEnum.BOOKED;
                    BODB.UpdateSlot(slot);
                    ts.Complete();
                }
                return MakeRestObjectResponse(null);
            }
            catch(Exception ex)
            {
                return HandleObjectException(ex);
            }
        }

        public RESTObjectResult FreeSlot(int id)
        {
            try
            {
                using (TransactionScope ts = BODB.CreateTransactionScope())
                {
                    Slot slot = BODB.GetSlotById(id);
                    if (slot.StartDateTime < DateTime.Now.AddHours(Config.DismissTolerance) && slot.Status == SlotStatusEnum.CONFIRMED)
                    {
                        return MakeRestObjectResponse(null, false, 1, "Too late");
                    }
                    slot.Status = SlotStatusEnum.FREE;
                    BODB.UpdateSlot(slot);
                    ts.Complete();
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

