using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing;
using TLServer.BL;
using TLServer.BO;

namespace TLFrontEnd.Controllers
{
    [Authorize]
    public class AppController : Controller
    {
        [Route("app/config")]
        [HttpGet]
        public RestObjectResult GetConfig() => TLAppBL.Instance.GetConfig();

        [Route("app/config")]
        [HttpPatch]
        public RestObjectResult UpdateConfig([FromBody] TLServer.DAO.Config config) => TLAppBL.Instance.UpdateConfig(config);
    }
}

