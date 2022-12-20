﻿using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TLServer.BL;
using TLServer.BO;
using TLServer.DAO;

// For more information on enabling MVC for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace TLFrontEnd.Controllers
{
    [Authorize]
    public class SchedulerController : Controller
    {
        [HttpPost]
        [Route("scheduler/slot")]
        public RESTListResult GetSlotByInterval([FromBody] DateTimeInterval interval) => SchedulerBL.Instance.GetSlotByInterval(interval);

        [HttpPost]
        [Route("scheduler/myslot/{email}")]
        public RESTListResult GetMySlots(string email, [FromBody] DateTimeInterval interval) => SchedulerBL.Instance.GetMySlots(email, interval);

        [HttpPost]
        [Route("scheduler/book/{email}/{id}")]
        public RESTObjectResult BookSlot(string email, int id) => SchedulerBL.Instance.BookSlot(email, id);

        [HttpPost]
        [Route("scheduler/free/{id}")]
        public RESTObjectResult FreeSlot(int id) => SchedulerBL.Instance.FreeSlot(id);

        [HttpPut]
        [Route("scheduler/slot")]
        public RESTObjectResult NewSlot([FromBody] Slot slot) => SchedulerBL.Instance.NewSlot(slot);

        [HttpPatch]
        [Route("scheduler/slot")]
        public RESTObjectResult UpdateSlot([FromBody] Slot slot) => SchedulerBL.Instance.UpdateSlot(slot);

        [HttpGet]
        [Route("scheduler/slot/{id}")]
        public RESTObjectResult GetSlotById(int id) => SchedulerBL.Instance.GetSlotById(id);

        [HttpDelete]
        [Route("scheduler/slot/{id}")]
        public RESTObjectResult DeleteSlot(int id) => SchedulerBL.Instance.DeleteSlot(id);

        [HttpGet]
        [Route("scheduler/slot/status")]
        public RESTListResult GetSlotStatuses() => SchedulerBL.Instance.GetSlotStatuses();

    }
}

