using System.Web.Http;
using TLServer.BL;
using TLServer.BO;
using TLServer.DAO;
using TLServer.Enums;

namespace TrainerLab.Controllers;

[Authorize]
public class SchedulerController : ApiController
{
    [HttpPost]
    [Route("scheduler/slot")]
    public RestListResult GetSlotByInterval([FromBody] DateTimeInterval interval)
    {
        return SchedulerBl.Instance.GetSlotByInterval(interval);
    }

    [HttpPost]
    [Route("scheduler/myslot/{email}/")]
    public RestListResult GetMySlots(string email, [FromBody] DateTimeInterval interval)
    {
        return SchedulerBl.Instance.GetMySlots(email, interval);
    }

    [HttpPost]
    [Route("scheduler/book/{email}/{id}")]
    public RestObjectResult BookSlot(string email, int id)
    {
        return SchedulerBl.Instance.BookSlot(email, id);
    }

    [HttpPost]
    [Route("scheduler/free/{id}")]
    public RestObjectResult FreeSlot(int id)
    {
        return SchedulerBl.Instance.FreeSlot(id);
    }

    [HttpPost]
    [Route("scheduler/slot/new/")]
    public RestObjectResult NewSlot([FromBody] Slot slot)
    {
        return SchedulerBl.Instance.NewSlot(slot);
    }

    [HttpPatch]
    [Route("scheduler/slot/")]
    public RestObjectResult UpdateSlot([FromBody] Slot slot)
    {
        return SchedulerBl.Instance.UpdateSlot(slot);
    }

    [HttpGet]
    [Route("scheduler/slot/{id}")]
    public RestObjectResult GetSlotById(int id)
    {
        return SchedulerBl.Instance.GetSlotById(id);
    }

    [HttpDelete]
    [Route("scheduler/slot/{id}")]
    public RestObjectResult DeleteSlot(int id)
    {
        return SchedulerBl.Instance.DeleteSlot(id);
    }

    [HttpGet]
    [Route("scheduler/slot/booked")]
    public RestListResult GetBookedSlots()
    {
        return SchedulerBl.Instance.GetSlotsByStatus(SlotStatusEnum.BOOKED);
    }

    [HttpGet]
    [Route("scheduler/slot/confirmed")]
    public RestListResult GetConfirmedSlots()
    {
        return SchedulerBl.Instance.GetSlotsByStatus(SlotStatusEnum.CONFIRMED);
    }

    [HttpGet]
    [Route("scheduler/slot/status")]
    public RestListResult GetSlotStatuses()
    {
        return SchedulerBl.Instance.GetSlotStatuses();
    }
}