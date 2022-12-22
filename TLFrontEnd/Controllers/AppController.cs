using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Routing;
using TLServer.BL;
using TLServer.BO;

// For more information on enabling MVC for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace TLFrontEnd.Controllers
{
    [Authorize]
    public class AppController : Controller
    {
        [Route("app/config")]
        [HttpGet]
        public RESTObjectResult GetConfig() => TLAppBL.Instance.GetConfig();

        [Route("app/config")]
        [HttpPatch]
        public RESTObjectResult UpdateConfig([FromBody] TLServer.DAO.Config config) => TLAppBL.Instance.UpdateConfig(config);
    }
}

