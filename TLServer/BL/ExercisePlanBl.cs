using System.IO;
using System.Linq;
using System.Web;
using RMLibs.basic;
using RMLibs.Utilities;
using TLServer.BO;
using TLServer.DAO;
using TLServer.Logging;
using Exception = System.Exception;

namespace TLServer.BL
{
    public class ExercisePlanBl: GenericBl
    {
        #region Singleton

        private static ExercisePlanBl _instance;
        private static readonly object Padlock = new object();

        public static ExercisePlanBl Instance
        {
            get
            {
                lock (Padlock)
                {
                    return _instance ??= new ExercisePlanBl();
                }
            }
        }

        private ExercisePlanBl() : base(TlLogger.Instance)
        {
        }

        #endregion

        public RestListResult GetMuscularGroups()
        {
            try
            {
                return MakeRestListResponse(BODB.GetMuscularGroups().Cast<BasicObject>().ToList());
            }
            catch (Exception ex)
            {
                return HandleListException(ex);
            }
        }
        
        public RestObjectResult GetMuscularGroupById(int id)
        {
            try
            {
                return MakeRestObjectResponse(BODB.GetMuscularGroupById(id));
            }
            catch (Exception ex)
            {
                return HandleObjectException(ex);
            }
        }
        
        public RestObjectResult GetMuscularGroupByName(string name)
        {
            try
            {
                return MakeRestObjectResponse(BODB.GetMuscularGroupByName(name));
            }
            catch (Exception ex)
            {
                return HandleObjectException(ex);
            }
        }

        public RestObjectResult NewMuscularGroup(MuscularGroup muscularGroup)
        {
            try
            {
                BODB.NewMuscularGroup(muscularGroup);
                return MakeRestObjectResponse(null);
            }
            catch (Exception ex)
            {
                return HandleObjectException(ex);
            }
        }
        
        public RestObjectResult UpdateMuscularGroup(MuscularGroup muscularGroup)
        {
            try
            {
                BODB.UpdateMuscularGroup(muscularGroup);
                return MakeRestObjectResponse(null);
            }
            catch (Exception ex)
            {
                return HandleObjectException(ex);
            }
        }
        
        public RestObjectResult DeleteMuscularGroup(int id)
        {
            try
            {
                BODB.DeleteMuscularGroup(id);
                return MakeRestObjectResponse(null);
            }
            catch (Exception ex)
            {
                return HandleObjectException(ex);
            }
        }

        public RestListResult GetFullExercises()
        {
            try
            {
                return MakeRestListResponse(BODB.GetFullExercises().Cast<BasicObject>().ToList());
            }
            catch (Exception ex)
            {
                return HandleListException(ex);
            }
        }

        public RestObjectResult GetFullExerciseById(int id)
        {
            try
            {
                return MakeRestObjectResponse(BODB.GetFullExerciseById(id));
            }
            catch (Exception ex)
            {
                return HandleObjectException(ex);
            }
        }

        public RestListResult GetFullExerciseByMuscularGroup(string muscularGroup)
        {
            try
            {
                return MakeRestListResponse(BODB.GetFullExerciseByMuscularGroup(muscularGroup).Cast<BasicObject>().ToList());
            }
            catch (Exception ex)
            {
                return HandleListException(ex);
            }
        }

        public RestObjectResult NewExercise(HttpRequest request)
        {
            try
            {
                Image image = null;
                Exercise exercise = new Exercise()
                {
                    Name = request.Form.Get("Name"),
                    MuscularGroup = request.Form.Get("MuscularGroup"),
                    Description = request.Form.Get("Description")
                };
                if (request.Files.Count > 0)
                {
                    string uid = SecurityUtils.GetNewGuid();
                    HttpPostedFile postedFile = request.Files[0];
                    if (postedFile != null)
                    {
                        string[] fileNameParts = postedFile.FileName.Split('.');
                        string fileName = uid + "." + fileNameParts.Last();
                        image = new Image()
                        {
                            Path = fileName
                        };
                        string filePath = Path.Combine(Config.BaseDir, Config.ImagesPath, fileName);
                        postedFile.SaveAs(filePath);
                    }
                }
                using (var ts = BODB.CreateTransactionScope())
                {
                    var imageId = image != null ? BODB.NewImage(image) : null;
                    exercise.Image = imageId;
                    BODB.NewExercise(exercise);
                    ts.Complete();
                    ts.Dispose();
                }

                return MakeRestObjectResponse(null);
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleObjectException(ex);
            }
        }

        public RestObjectResult UpdateExercise(HttpRequest request)
        {
            try
            {
                Image image = null;
                int id = int.Parse(request.Form.Get("Id"));
                var exercise = BODB.GetExerciseById(id);
                exercise.Name = request.Form.Get("Name");
                exercise.MuscularGroup = request.Form.Get("MuscularGroup");
                exercise.Description = request.Form.Get("Description");
                if (request.Files.Count > 0)
                {
                    if (exercise.Image != null)
                    {
                        Image oldImg = BODB.GetImageById(exercise.Image);
                        var path = Path.Combine(Config.BaseDir, Config.ImagesPath, oldImg.Path);
                        File.Delete(path);
                    }

                    string uid = SecurityUtils.GetNewGuid();
                    HttpPostedFile postedFile = request.Files[0];
                    if (postedFile != null)
                    {
                        string[] fileNameParts = postedFile.FileName.Split('.');
                        string fileName = uid + "." + fileNameParts.Last();
                        image = new Image()
                        {
                            Path = fileName
                        };
                        var filePath = Path.Combine(Config.BaseDir, Config.ImagesPath, fileName);
                        postedFile.SaveAs(filePath);
                    }
                    
                }
                using (var ts = BODB.CreateTransactionScope())
                {
                    int? oldId = exercise.Image;
                    if (image != null) exercise.Image = BODB.NewImage(image);
                    BODB.UpdateExercise(exercise);
                    if (oldId != null && image != null) BODB.DeleteImage(oldId);
                    ts.Complete();
                    ts.Dispose();
                }
                return MakeRestObjectResponse(null);
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleObjectException(ex);
            }
        }

        public RestListResult GetTrainingPlansByUserId(int id)
        {
            try
            {
                return MakeRestListResponse(BODB.GetTrainingPlansByUserId(id).Cast<BasicObject>().ToList());
            }
            catch (Exception ex)
            {
                return HandleListException(ex);
            }
        }

        public RestListResult GetFullTrainingPlanByUserEmail(string email)
        {
            try
            {
                return MakeRestListResponse(BODB.GetFullTrainingPlansByUserEmail(email).Cast<BasicObject>().ToList());
            }
            catch (Exception ex)
            {
                return HandleListException(ex);
            }
        }

        public RestListResult GetFullTrainingPlanById(int id)
        {
            try
            {
                return MakeRestListResponse(BODB.GetFullTrainingPlanById(id).Cast<BasicObject>().ToList());
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleListException(ex);
            }
        }

        public RestObjectResult NewTrainingPlan(CompleteTrainingPlan completeTrainingPlan)
        {
            if (completeTrainingPlan.Details.Count == 0)
            {
                return HandleObjectException(new Exception("Non sono stati inseriti esercizi per questo piano!"));
            }

            using (var ts = BODB.CreateTransactionScope())
            {
                try
                {
                    var id= BODB.NewTrainingPlan(completeTrainingPlan);
                    foreach (var detail in completeTrainingPlan.Details)
                    {
                        detail.TrainingPlanId = id;
                        BODB.NewTrainingPlanDetail(detail);
                    }

                    ts.Complete();
                    ts.Dispose();
                    return MakeRestObjectResponse(null);
                }
                catch (Exception ex)
                {
                    ts.Dispose();
                    return HandleObjectException(ex);
                }
            }
        }

        public RestObjectResult UpdateTrainingPlan(CompleteTrainingPlan completeTrainingPlan)
        {
            if (completeTrainingPlan.Details.Count == 0)
            {
                return HandleObjectException(new Exception("Non sono stati inseriti esercizi per questo piano!"));
            }
            using (var ts = BODB.CreateTransactionScope())
            {
                try
                {
                    var id = completeTrainingPlan.Id;
                    BODB.DeleteTrainingPlanDetailByTrainingPlanId((int)id);
                    foreach (var detail in completeTrainingPlan.Details)
                    {
                        detail.TrainingPlanId = id;
                        BODB.NewTrainingPlanDetail(detail);
                    }
                    BODB.UpdateTrainingPlan(completeTrainingPlan);
                    ts.Complete();
                    ts.Dispose();
                    return MakeRestObjectResponse(null);
                }
                catch (Exception ex)
                {
                    ts.Dispose();
                    return HandleObjectException(ex);
                }
            }
        }

    }
}