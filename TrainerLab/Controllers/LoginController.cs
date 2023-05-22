using System.Web.Http;
using TLServer.BL;
using TLServer.BO;

namespace TrainerLab.Controllers;

public class LoginController : ApiController
{
    [HttpPost]
    [Route("login")]
    public RestObjectResult Login([FromBody] LoginCredentials loginCredentials)
    {
        return AuthBl.Instance.Login(loginCredentials.Email, loginCredentials.Password);
    }

    [HttpGet]
    [Route("test")]
    public string test()
    {
        return "hello";
    }
}