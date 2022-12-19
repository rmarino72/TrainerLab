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

        [HttpPut]
        [Route("scheduler/slot")]
        public RESTObjectResult NewSlot([FromBody] Slot slot) => SchedulerBL.Instance.NewSlot(slot);

        [HttpGet]
        [Route("scheduler/slot/status")]
        public RESTListResult GetSlotStatuses() => SchedulerBL.Instance.GetSlotStatuses();
    }
}

