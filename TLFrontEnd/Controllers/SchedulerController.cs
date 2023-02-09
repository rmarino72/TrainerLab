using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TLServer.BL;
using TLServer.BO;
using TLServer.DAO;
using TLServer.Enums;

namespace TLFrontEnd.Controllers
{
    [Authorize]
    public class SchedulerController : Controller
    {
        [HttpPost]
        [Route("scheduler/slot")]
        public RestListResult GetSlotByInterval([FromBody] DateTimeInterval interval) => SchedulerBl.Instance.GetSlotByInterval(interval);

        [HttpPost]
        [Route("scheduler/myslot/{email}")]
        public RestListResult GetMySlots(string email, [FromBody] DateTimeInterval interval) => SchedulerBl.Instance.GetMySlots(email, interval);

        [HttpPost]
        [Route("scheduler/book/{email}/{id}")]
        public RestObjectResult BookSlot(string email, int id) => SchedulerBl.Instance.BookSlot(email, id);

        [HttpPost]
        [Route("scheduler/free/{id}")]
        public RestObjectResult FreeSlot(int id) => SchedulerBl.Instance.FreeSlot(id);

        [HttpPut]
        [Route("scheduler/slot")]
        public RestObjectResult NewSlot([FromBody] Slot slot) => SchedulerBl.Instance.NewSlot(slot);

        [HttpPatch]
        [Route("scheduler/slot")]
        public RestObjectResult UpdateSlot([FromBody] Slot slot) => SchedulerBl.Instance.UpdateSlot(slot);

        [HttpGet]
        [Route("scheduler/slot/{id}")]
        public RestObjectResult GetSlotById(int id) => SchedulerBl.Instance.GetSlotById(id);

        [HttpDelete]
        [Route("scheduler/slot/{id}")]
        public RestObjectResult DeleteSlot(int id) => SchedulerBl.Instance.DeleteSlot(id);

        [HttpGet]
        [Route("scheduler/slot/booked")]
        public RestListResult GetBookedSlots() => SchedulerBl.Instance.GetSlotsByStatus(SlotStatusEnum.BOOKED);

        [HttpGet]
        [Route("scheduler/slot/confirmed")]
        public RestListResult GetConfirmedSlots() => SchedulerBl.Instance.GetSlotsByStatus(SlotStatusEnum.CONFIRMED);

        [HttpGet]
        [Route("scheduler/slot/status")]
        public RestListResult GetSlotStatuses() => SchedulerBl.Instance.GetSlotStatuses();

    }
}

