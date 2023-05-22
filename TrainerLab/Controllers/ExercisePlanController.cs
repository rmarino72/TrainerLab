using System;
using System.Net.Http;
using System.Web;
using System.Web.Http;
using TLServer.BL;
using TLServer.BO;
using TLServer.DAO;

namespace TrainerLab.Controllers
{
    [Authorize]
    public class ExercisePlanController : ApiController
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

        [HttpGet]
        [Route("exerciseplan/exercise")]
        public RestListResult GetFullExercises() => ExercisePlanBl.Instance.GetFullExercises();

        [HttpGet]
        [Route("exerciseplan/exercise/{id:int}")]
        public RestObjectResult GetFullExerciseById(int id) => ExercisePlanBl.Instance.GetFullExerciseById(id);
        
        [HttpGet]
        [Route("exerciseplan/exercise/bymusculargroup/{musculargroup}/")]
        public RestListResult GetFullExerciseByMuscularGroup(string muscularGroup) => ExercisePlanBl.Instance.GetFullExerciseByMuscularGroup(muscularGroup);

        [HttpPost]
        [Route("exerciseplan/exercise")]
        public RestObjectResult NewExercise() => ExercisePlanBl.Instance.NewExercise(HttpContext.Current.Request);
        
        [HttpPatch]
        [Route("exerciseplan/exercise")]
        public RestObjectResult UpdateExercise() => ExercisePlanBl.Instance.UpdateExercise(HttpContext.Current.Request);

        [HttpGet]
        [Route("exerciseplan/trainingplan/{id:int}/")]
        public RestListResult GetFullTrainingPlanById(int id) => ExercisePlanBl.Instance.GetFullTrainingPlanById(id);
        
        [HttpGet]
        [Route("exerciseplan/trainingplan/user/{id:int}/")]
        public RestListResult GetTrainingPlanByUserId(int id) =>
            ExercisePlanBl.Instance.GetTrainingPlansByUserId(id);

        [HttpPost]
        [Route("exerciseplan/trainingplan/")]
        public RestObjectResult NewTrainingPlan([FromBody] CompleteTrainingPlan completeTrainingPlan) =>
            ExercisePlanBl.Instance.NewTrainingPlan(completeTrainingPlan);
        
        [HttpPatch]
        [Route("exerciseplan/trainingplan/")]
        public RestObjectResult UpdateTrainingPlan([FromBody] CompleteTrainingPlan completeTrainingPlan) =>
            ExercisePlanBl.Instance.UpdateTrainingPlan(completeTrainingPlan);
    }
}