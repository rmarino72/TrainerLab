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
    [Authorize]
    public class UserController : Controller
    {
        [HttpGet]
        [Route("user/province")]
        public RESTListResult GetProvinces() => UserBL.Instance.GetProvinces();

        [HttpGet]
        [Route("user/city")]
        public RESTListResult GetCities() => UserBL.Instance.GetCities();

        [HttpPost]
        [AllowAnonymous]
        [Route("user/login")]
        public RESTObjectResult Login([FromBody] LoginCredentials loginCredentials) => AuthBL.Instance.Login(loginCredentials.Email, loginCredentials.Password);

    }
}

