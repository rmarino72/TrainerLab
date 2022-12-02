using System;
using System.Linq;
using System.Collections.Generic;
using TLServer.BO;
using TLServer.Logging;
using RMLibs.basic;

namespace TLServer.BL
{
	public class UserBL: GenericBL
	{

        #region Singleton

        private static UserBL instance = null;
        private static readonly object padlock = new object();

        public static UserBL Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new UserBL();
                    }
                    return instance;
                }
            }
        }

        private UserBL() : base(TLLogger.Instance)
        {
        }

        #endregion

        public RESTListResult GetRegions()
        {
            try
            {
                return MakeRestListResponse(BODB.GetRegions().Cast<BasicObject>().ToList());
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleListException(ex);
            }
        }

        public RESTListResult GetProvinces()
		{
			try
			{
				return MakeRestListResponse(BODB.GetProvinces().Cast<BasicObject>().ToList());
			}
			catch (Exception ex)
			{
				Error(ex);
				return HandleListException(ex);
			}
		}

        public RESTListResult GetProvincesByRegion(string region)
        {
            try
            {
                return MakeRestListResponse(BODB.GetProvincesByRegion(region).Cast<BasicObject>().ToList());
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleListException(ex);
            }
        }

        public RESTListResult GetCities()
        {
            try
            {
                return MakeRestListResponse(BODB.GetCities().Cast<BasicObject>().ToList());
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleListException(ex);
            }
        }

        public RESTListResult GetCitiesByProvince(string province)
        {
            try
            {
                return MakeRestListResponse(BODB.GetCitiesByProvince(province).Cast<BasicObject>().ToList());
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleListException(ex);
            }
        }

        public RESTListResult GetSexes()
        {
            try
            {
                return MakeRestListResponse(BODB.GetSexes().Cast<BasicObject>().ToList());
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleListException(ex);
            }
        }

        public RESTObjectResult GetUserByEmail(string email)
        {
            try
            {
                return MakeRestObjectResponse(BODB.GetUserByEmail(email));
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleObjectException(ex);
            }
        }

        public RESTListResult GetFullUsers()
        {
            try
            {
                return MakeRestListResponse(BODB.GetFullUsers().Cast<BasicObject>().ToList());
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleListException(ex);
            }
        }

        public RESTObjectResult GetFullUserByEmail(string email)
        {
            try
            {
                return MakeRestObjectResponse(BODB.GetFullUserByEmail(email));
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleObjectException(ex);
            }
        }

    }
}

