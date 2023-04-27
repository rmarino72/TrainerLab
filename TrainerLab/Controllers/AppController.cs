using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using TLServer.BL;
using TLServer.BO;

namespace TrainerLab.Controllers
{
    [Authorize]
    public class AppController : ApiController
    {
        [Route("app/config")]
        [HttpGet]
        public RestObjectResult GetConfig() => TLAppBL.Instance.GetConfig();

        [Route("app/config")]
        [HttpPatch]
        public RestObjectResult UpdateConfig([FromBody] TLServer.DAO.Config config) => TLAppBL.Instance.UpdateConfig(config);
    }
}
