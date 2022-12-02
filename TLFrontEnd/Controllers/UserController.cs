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
        [Route("user/region")]
        public RESTListResult GetRegions() => UserBL.Instance.GetRegions();

        [HttpGet]
        [Route("user/province")]
        public RESTListResult GetProvinces() => UserBL.Instance.GetProvinces();

        [HttpGet]
        [Route("user/province/{region}")]
        public RESTListResult GetProvincesByRegion(string region) => UserBL.Instance.GetProvincesByRegion(region);

        [HttpGet]
        [Route("user/city")]
        public RESTListResult GetCities() => UserBL.Instance.GetCities();

        [HttpGet]
        [Route("user/city/{province}")]
        public RESTListResult GetCitiesByProvince(string province) => UserBL.Instance.GetCitiesByProvince(province);

        [HttpGet]
        [Route("user/sex")]
        public RESTListResult GetSexes() => UserBL.Instance.GetSexes();

        [HttpPost]
        [AllowAnonymous]
        [Route("user/login")]
        public RESTObjectResult Login([FromBody] LoginCredentials loginCredentials) => AuthBL.Instance.Login(loginCredentials.Email, loginCredentials.Password);

        [HttpGet]
        [Route("user/logout/{email}")]
        public RESTObjectResult Logout(string email) => AuthBL.Instance.Logout(email);

        [HttpGet]
        [Route("user/{email}")]
        public RESTObjectResult GetUserByEmail(string email) => UserBL.Instance.GetUserByEmail(email);

        [HttpGet]
        [Route("user/full")]
        public RESTListResult GetFullUsers() => UserBL.Instance.GetFullUsers();

        [HttpGet]
        [Route("user/full/{email}")]
        public RESTObjectResult GetFullUserByEmail(string email) => UserBL.Instance.GetFullUserByEmail(email);


    }
}

