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
        public RestListResult GetRegions() => UserBL.Instance.GetRegions();

        [HttpGet]
        [Route("user/province")]
        public RestListResult GetProvinces() => UserBL.Instance.GetProvinces();

        [HttpGet]
        [Route("user/province/{region}")]
        public RestListResult GetProvincesByRegion(string region) => UserBL.Instance.GetProvincesByRegion(region);

        [HttpGet]
        [Route("user/city")]
        public RestListResult GetCities() => UserBL.Instance.GetCities();

        [HttpGet]
        [Route("user/city/{province}")]
        public RestListResult GetCitiesByProvince(string province) => UserBL.Instance.GetCitiesByProvince(province);

        [HttpGet]
        [Route("user/role")]
        public RestListResult GetRoles() => UserBL.Instance.GetRoles();

        [HttpGet]
        [Route("user/sex")]
        public RestListResult GetSexes() => UserBL.Instance.GetSexes();

        [HttpPost]
        [AllowAnonymous]
        [Route("user/login")]
        public RestObjectResult Login([FromBody] LoginCredentials loginCredentials) => AuthBl.Instance.Login(loginCredentials.Email, loginCredentials.Password);

        [HttpGet]
        [Route("user/logout/{email}")]
        public RestObjectResult Logout(string email) => AuthBl.Instance.Logout(email);

        [HttpPost]
        [Route("user/")]
        public RestObjectResult NewUser([FromBody] FullUserView fullUser) => UserBL.Instance.NewUser(fullUser);

        [HttpPatch]
        [Route("user/")]
        public RestObjectResult UpdateUser([FromBody] FullUserView fullUser) => UserBL.Instance.UpdateUser(fullUser);

        [HttpGet]
        [Route("user/{email}")]
        public RestObjectResult GetUserByEmail(string email) => UserBL.Instance.GetUserByEmail(email);

        [HttpGet]
        [Route("user/full")]
        public RestListResult GetFullUsers() => UserBL.Instance.GetFullUsers();

        [HttpGet]
        [Route("user/full/{email}")]
        public RestObjectResult GetFullUserByEmail(string email) => UserBL.Instance.GetFullUserByEmail(email);

        [HttpPost]
        [Route("user/pass")]
        public RestObjectResult ChangePass([FromBody] ChangePassData changePassData) => UserBL.Instance.ChangePass(changePassData);

        [HttpGet]
        [Route("user/anthropometry/{email}")]
        public RestListResult GetAnthropometries(string email) => UserBL.Instance.GetAnthropometries(email);

        [HttpGet]
        [Route("user/anthropometry/{email}/{id}")]
        public RestObjectResult GetAnthropometryById(string email, int id) => UserBL.Instance.GetAnthropometryById(id);

        [HttpPost]
        [Route("user/anthropometry")]
        public RestObjectResult NewAnthropometry([FromBody] FullAnthropometryView anthropometry) => UserBL.Instance.NewAnthropometry(anthropometry);

        [HttpPatch]
        [Route("user/anthropometry")]
        public RestObjectResult UpdateAnthropometry([FromBody] FullAnthropometryView anthropometry) => UserBL.Instance.UpdateAnthropometry(anthropometry);

        [HttpGet]
        [Route("user/plicometry/{email}")]
        public RestListResult GetPlicometries(string email) => UserBL.Instance.GetPlicometry(email);

        [HttpGet]
        [Route("user/plicometry/{email}/{id}")]
        public RestObjectResult GetPlicometryById(string email, int id) => UserBL.Instance.GetPlicometryById(id);

        [HttpPost]
        [Route("user/plicometry")]
        public RestObjectResult NewPlicometry([FromBody]Plicometry plicometry) => UserBL.Instance.NewPlicometry(plicometry);

        [HttpPatch]
        [Route("user/plicometry")]
        public RestObjectResult UpdatePlicometry([FromBody] Plicometry plicometry) => UserBL.Instance.UpdatePlicometry(plicometry);
    }
}

