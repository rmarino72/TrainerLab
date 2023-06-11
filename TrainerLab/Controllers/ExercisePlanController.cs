using System.Web;
using System.Web.Http;
using TLServer.BL;
using TLServer.BO;
using TLServer.DAO;

namespace TrainerLab.Controllers;

[Authorize]
public class ExercisePlanController : ApiController
{
    [HttpGet]
    [Route("exerciseplan/musculargroup")]
    public RestListResult GetMuscularGroups()
    {
        return ExercisePlanBl.Instance.GetMuscularGroups();
    }

    [HttpGet]
    [Route("exerciseplan/musculargroup/{id:int}")]
    public RestObjectResult GetMuscularGroupById(int id)
    {
        return ExercisePlanBl.Instance.GetMuscularGroupById(id);
    }

    [HttpGet]
    [Route("exerciseplan/musculargroupbyname/{name}")]
    public RestObjectResult GetMuscularGroupByName(string name)
    {
        return ExercisePlanBl.Instance.GetMuscularGroupByName(name);
    }

    [HttpPost]
    [Route("exerciseplan/musculargroup")]
    public RestObjectResult NewMuscularGroup([FromBody] MuscularGroup muscularGroup)
    {
        return ExercisePlanBl.Instance.NewMuscularGroup(muscularGroup);
    }

    [HttpPatch]
    [Route("exerciseplan/musculargroup")]
    public RestObjectResult UpdateMuscularGroup([FromBody] MuscularGroup muscularGroup)
    {
        return ExercisePlanBl.Instance.UpdateMuscularGroup(muscularGroup);
    }

    [HttpDelete]
    [Route("exerciseplan/musculargroup/{id:int}")]
    public RestObjectResult DeleteMuscularGroup(int id)
    {
        return ExercisePlanBl.Instance.DeleteMuscularGroup(id);
    }

    [HttpGet]
    [Route("exerciseplan/exercise")]
    public RestListResult GetFullExercises()
    {
        return ExercisePlanBl.Instance.GetFullExercises();
    }

    [HttpGet]
    [Route("exerciseplan/exercise/{id:int}")]
    public RestObjectResult GetFullExerciseById(int id)
    {
        return ExercisePlanBl.Instance.GetFullExerciseById(id);
    }

    [HttpGet]
    [Route("exerciseplan/exercise/bymusculargroup/{musculargroup}/")]
    public RestListResult GetFullExerciseByMuscularGroup(string muscularGroup)
    {
        return ExercisePlanBl.Instance.GetFullExerciseByMuscularGroup(muscularGroup);
    }

    [HttpPost]
    [Route("exerciseplan/exercise")]
    public RestObjectResult NewExercise()
    {
        return ExercisePlanBl.Instance.NewExercise(HttpContext.Current.Request);
    }

    [HttpPatch]
    [Route("exerciseplan/exercise")]
    public RestObjectResult UpdateExercise()
    {
        return ExercisePlanBl.Instance.UpdateExercise(HttpContext.Current.Request);
    }

    [HttpGet]
    [Route("exerciseplan/trainingplan/{id:int}/")]
    public RestListResult GetFullTrainingPlanById(int id)
    {
        return ExercisePlanBl.Instance.GetFullTrainingPlanById(id);
    }

    [HttpGet]
    [Route("exerciseplan/trainingplan/user/{id:int}/")]
    public RestListResult GetTrainingPlanByUserId(int id)
    {
        return ExercisePlanBl.Instance.GetTrainingPlansByUserId(id);
    }

    [HttpPost]
    [Route("exerciseplan/trainingplan/")]
    public RestObjectResult NewTrainingPlan([FromBody] CompleteTrainingPlan completeTrainingPlan)
    {
        return ExercisePlanBl.Instance.NewTrainingPlan(completeTrainingPlan);
    }

    [HttpPatch]
    [Route("exerciseplan/trainingplan/")]
    public RestObjectResult UpdateTrainingPlan([FromBody] CompleteTrainingPlan completeTrainingPlan)
    {
        return ExercisePlanBl.Instance.UpdateTrainingPlan(completeTrainingPlan);
    }

    [HttpGet]
    [Route("exerciseplan/print/{id}")]
    public RestObjectResult PrintPlan(int id) => new ReportBl().PrintPlan(id);
}