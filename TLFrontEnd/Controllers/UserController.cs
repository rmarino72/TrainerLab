using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TLServer.BL;
using TLServer.BO;

namespace TLFrontEnd.Controllers
{
    public class UserController : Controller
    {
        [HttpGet]
        [Authorize]
        [Route("user/province")]
        public RESTListResult GetProvinces() => UserBL.Instance.GetProvinces();

        [HttpGet]
        [Authorize]
        [Route("user/city")]
        public RESTListResult GetCities() => UserBL.Instance.GetCities();

    }
}

