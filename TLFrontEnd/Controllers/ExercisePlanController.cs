using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using TLServer.BL;
using TLServer.BO;
using TLServer.DAO;

namespace TLFrontEnd.Controllers
{
    [Authorize]
    public class ExercisePlanController : Controller
    {
        [HttpGet]
        [Route("exerciseplan/musculargroup")]
        public RestListResult GetMuscularGroups() => ExercisePlanBl.Instance.GetMuscularGroups();
        
        [HttpGet]
        [Route("exerciseplan/musculargroup/{id:int}")]
        public RestObjectResult GetMuscularGroupById(int id) => ExercisePlanBl.Instance.GetMuscularGroupById(id);
        
        [HttpGet]
        [Route("exerciseplan/musculargroupbyname/{name}")]
        public RestObjectResult GetMuscularGroupByName(string name) => ExercisePlanBl.Instance.GetMuscularGroupByName(name);

        [HttpPost]
        [Route("exerciseplan/musculargroup")]
        public RestObjectResult NewMuscularGroup([FromBody] MuscularGroup muscularGroup) =>
            ExercisePlanBl.Instance.NewMuscularGroup(muscularGroup);
        
        [HttpPatch]
        [Route("exerciseplan/musculargroup")]
        public RestObjectResult UpdateMuscularGroup([FromBody] MuscularGroup muscularGroup) =>
            ExercisePlanBl.Instance.UpdateMuscularGroup(muscularGroup);
        
        [HttpDelete]
        [Route("exerciseplan/musculargroup/{id:int}")]
        public RestObjectResult DeleteMuscularGroup(int id) =>
            ExercisePlanBl.Instance.DeleteMuscularGroup(id);
    }
}