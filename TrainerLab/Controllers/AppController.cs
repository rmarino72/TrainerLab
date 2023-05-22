using System.Web.Http;
using TLServer.BL;
using TLServer.BO;
using TLServer.DAO;

namespace TrainerLab.Controllers;

[Authorize]
public class AppController : ApiController
{
    [Route("app/config")]
    [HttpGet]
    public RestObjectResult GetConfig()
    {
        return TLAppBL.Instance.GetConfig();
    }

    [Route("app/config")]
    [HttpPatch]
    public RestObjectResult UpdateConfig([FromBody] Config config)
    {
        return TLAppBL.Instance.UpdateConfig(config);
    }
}