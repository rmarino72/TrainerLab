using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using RMLibs.basic;
using TLServer.BO;
using TLServer.DAO;
using TLServer.Enums;
using TLServer.Logging;

namespace TLServer.BL
{
	public class SchedulerBl: GenericBl
	{
        #region Singleton

        private static SchedulerBl _instance;
        private static readonly object Padlock = new object();

        public static SchedulerBl Instance
        {
            get
            {
                lock (Padlock)
                {
                    return _instance ??= new SchedulerBl();
                }
            }
        }

        private SchedulerBl() : base(TlLogger.Instance)
        {
        }

        #endregion

        public RestListResult GetSlotByInterval(DateTimeInterval interval)
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

        public RestListResult GetSlotStatuses()
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

        public RestObjectResult NewSlot(Slot slot)
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

        public RestObjectResult GetSlotById(int id)
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

        public RestObjectResult UpdateSlot(Slot slot)
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

        public RestObjectResult DeleteSlot(int id)
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

        public RestListResult GetMySlots(string email, DateTimeInterval interval)
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

        public RestObjectResult BookSlot(string email, int id)
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

        public RestObjectResult FreeSlot(int id)
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

        public RestListResult GetSlotsByStatus(string status)
        {
            try
            {
                DateTimeInterval interval = new DateTimeInterval { Start = DateTime.Now, End = DateTime.Now.AddYears(100) };
                List<FullSlotView> slots = BODB.GetSlotByInterval(interval);
                return MakeRestListResponse(slots.FindAll(x => x.Status == status).Cast<BasicObject>().ToList());
            }
            catch (Exception ex)
            {
                return HandleListException(ex);
            }

        }
    }
}

