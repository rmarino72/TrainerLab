using System;
using System.Linq;
using RMLibs.basic;
using TLServer.BO;
using TLServer.DAO;
using TLServer.Logging;

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

    }
}