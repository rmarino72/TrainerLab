using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TLServer.BL;
using TLServer.BO;

// For more information on enabling MVC for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace TLFrontEnd.Controllers
{
    [Authorize]
    public class SchedulerController : Controller
    {
        [HttpPost]
        [Route("scheduler/slot")]
        public RESTListResult GetSlotByInterval([FromBody] DateTimeInterval interval) => SchedulerBL.Instance.GetSlotByInterval(interval);
    }
}

