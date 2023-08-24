using System.Web.Http;
using TLServer.BL;
using TLServer.BO;
using TLServer.DAO;

namespace TrainerLab.Controllers;

[Authorize]
public class UserController : ApiController
{
    [HttpGet]
    [Route("user/region")]
    public RestListResult GetRegions()
    {
        return UserBL.Instance.GetRegions();
    }

    [HttpGet]
    [Route("user/province")]
    public RestListResult GetProvinces()
    {
        return UserBL.Instance.GetProvinces();
    }

    [HttpGet]
    [Route("user/province/{region}")]
    public RestListResult GetProvincesByRegion(string region)
    {
        return UserBL.Instance.GetProvincesByRegion(region);
    }

    [HttpGet]
    [Route("user/city")]
    public RestListResult GetCities()
    {
        return UserBL.Instance.GetCities();
    }

    [HttpGet]
    [Route("user/city/{province}")]
    public RestListResult GetCitiesByProvince(string province)
    {
        return UserBL.Instance.GetCitiesByProvince(province);
    }

    [HttpGet]
    [Route("user/role")]
    public RestListResult GetRoles()
    {
        return UserBL.Instance.GetRoles();
    }

    [HttpGet]
    [Route("user/sex")]
    public RestListResult GetSexes()
    {
        return UserBL.Instance.GetSexes();
    }

    [HttpGet]
    [Route("user/logout/{email}/")]
    public RestObjectResult Logout(string email)
    {
        return AuthBl.Instance.Logout(email);
    }

    [HttpPost]
    [Route("user/")]
    public RestObjectResult NewUser([FromBody] FullUserView fullUser)
    {
        return UserBL.Instance.NewUser(fullUser);
    }

    [HttpPatch]
    [Route("user/")]
    public RestObjectResult UpdateUser([FromBody] FullUserView fullUser)
    {
        return UserBL.Instance.UpdateUser(fullUser);
    }

    [HttpGet]
    [Route("user/{email}/")]
    public RestObjectResult GetUserByEmail(string email)
    {
        return UserBL.Instance.GetUserByEmail(email);
    }

    [HttpGet]
    [Route("user/full")]
    public RestListResult GetFullUsers()
    {
        return UserBL.Instance.GetFullUsers();
    }

    [HttpGet]
    [Route("user/full/{email}/")]
    public RestObjectResult GetFullUserByEmail(string email)
    {
        return UserBL.Instance.GetFullUserByEmail(email);
    }

    [HttpPost]
    [Route("user/pass")]
    public RestObjectResult ChangePass([FromBody] ChangePassData changePassData)
    {
        return UserBL.Instance.ChangePass(changePassData);
    }

    [HttpGet]
    [Route("user/anthropometry/{email}/")]
    public RestListResult GetAnthropometries(string email)
    {
        return UserBL.Instance.GetAnthropometries(email);
    }

    [HttpGet]
    [Route("user/anthropometry/{email}/{id}")]
    public RestObjectResult GetAnthropometryById(string email, int id)
    {
        return UserBL.Instance.GetAnthropometryById(id);
    }

    [HttpPost]
    [Route("user/anthropometry/")]
    public RestObjectResult NewAnthropometry([FromBody] FullAnthropometryView anthropometry)
    {
        return UserBL.Instance.NewAnthropometry(anthropometry);
    }

    [HttpPatch]
    [Route("user/anthropometry/")]
    public RestObjectResult UpdateAnthropometry([FromBody] FullAnthropometryView anthropometry)
    {
        return UserBL.Instance.UpdateAnthropometry(anthropometry);
    }

    [HttpGet]
    [Route("user/plicometry/{email}/")]
    public RestListResult GetPlicometries(string email)
    {
        return UserBL.Instance.GetPlicometry(email);
    }

    [HttpGet]
    [Route("user/plicometry/{email}/{id}")]
    public RestObjectResult GetPlicometryById(string email, int id)
    {
        return UserBL.Instance.GetPlicometryById(id);
    }

    [HttpPost]
    [Route("user/plicometry")]
    public RestObjectResult NewPlicometry([FromBody] Plicometry plicometry)
    {
        return UserBL.Instance.NewPlicometry(plicometry);
    }

    [HttpPatch]
    [Route("user/plicometry")]
    public RestObjectResult UpdatePlicometry([FromBody] Plicometry plicometry)
    {
        return UserBL.Instance.UpdatePlicometry(plicometry);
    }

    [HttpGet]
    [Route("user/percentage/{email}/{plicoSum}")]
    public RestObjectResult GetPercentages(string email, double plicoSum)
    {
        return UserBL.Instance.GetPercentages(email, plicoSum);
    }

    [HttpGet]
    [Route("user/plicometry/print/{id}")]
    public RestObjectResult PrintPlicometry(int id)
    {
        return new ReportBl().PrintPlicometry(id);
    }

    [HttpGet]
    [Route("user/medicalanthropometry/{email}/")]
    public RestListResult GetMedicalHistoriesByMail(string email) => UserBL.Instance.GetMedicalHistoriesByMail(email);

    [HttpPost]
    [Route("user/medicalanthropometry/")]
    public RestObjectResult NewMedicalAnthropometry([FromBody] MedicalAnthropometry medicalAnthropometry) =>
        UserBL.Instance.NewMedicalAnthropometry(medicalAnthropometry);
    
    [HttpPatch]
    [Route("user/medicalanthropometry/")]
    public RestObjectResult UpdateMedicalAnthropometry([FromBody] MedicalAnthropometry medicalAnthropometry) =>
        UserBL.Instance.UpdateMedicalAnthropometry(medicalAnthropometry);

    [HttpGet]
    [Route("user/medicalanthropometry/{email}/{id}/")]
    public RestObjectResult GetMedicalAnthropometryById(string email, int id) => UserBL.Instance.GetMedicalAnthropometryById(id);

    [HttpDelete]
    [Route("user/medicalanthropometry/{id}/")]
    public RestObjectResult DeleteMedicalAnthropometry(int id) => UserBL.Instance.DeleteMedicalAnthropometry(id);
    
    [HttpGet]
    [Route("user/anthropometry/print/{id}")]
    public RestObjectResult PrintAnthropometry(int id)
    {
        return new ReportBl().PrintAnthropometry(id);
    }

}