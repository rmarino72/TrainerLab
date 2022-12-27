﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TLServer.BL;
using TLServer.BO;
using TLServer.DAO;

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
        [Route("user/role")]
        public RESTListResult GetRoles() => UserBL.Instance.GetRoles();

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

        [HttpPost]
        [Route("user/")]
        public RESTObjectResult NewUser([FromBody] FullUserView fullUser) => UserBL.Instance.NewUser(fullUser);

        [HttpPatch]
        [Route("user/")]
        public RESTObjectResult UpdateUser([FromBody] FullUserView fullUser) => UserBL.Instance.UpdateUser(fullUser);

        [HttpGet]
        [Route("user/{email}")]
        public RESTObjectResult GetUserByEmail(string email) => UserBL.Instance.GetUserByEmail(email);

        [HttpGet]
        [Route("user/full")]
        public RESTListResult GetFullUsers() => UserBL.Instance.GetFullUsers();

        [HttpGet]
        [Route("user/full/{email}")]
        public RESTObjectResult GetFullUserByEmail(string email) => UserBL.Instance.GetFullUserByEmail(email);

        [HttpPost]
        [Route("user/pass")]
        public RESTObjectResult ChangePass([FromBody] ChangePassData changePassData) => UserBL.Instance.ChangePass(changePassData);

        [HttpGet]
        [Route("user/anthropometry/{email}")]
        public RESTListResult GetAnthropometries(string email) => UserBL.Instance.GetAnthropometries(email);

        [HttpGet]
        [Route("user/anthropometry/{email}/{id}")]
        public RESTObjectResult GetAnthropometryById(string email, int id) => UserBL.Instance.GetAnthropometryById(id);

        [HttpPost]
        [Route("user/anthropometry")]
        public RESTObjectResult NewAnthropometry([FromBody] FullAnthropometryView anthropometry) => UserBL.Instance.NewAnthropometry(anthropometry);

        [HttpPatch]
        [Route("user/anthropometry")]
        public RESTObjectResult UpdateAnthropometry([FromBody] FullAnthropometryView anthropometry) => UserBL.Instance.UpdateAnthropometry(anthropometry);

    }
}

