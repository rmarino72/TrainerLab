using System;
using System.Linq;
using TLServer.BO;
using TLServer.Logging;
using RMLibs.basic;
using TLServer.DAO;
using RMLibs.Utilities;
using System.Transactions;

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

        public RESTListResult GetRoles()
        {
            try
            {
                return MakeRestListResponse(BODB.GetRoles().Cast<BasicObject>().ToList());
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

        public RESTObjectResult NewUser(FullUserView fullUser)
        {
            try
            {
                User user = BODB.GetUserByEmail(fullUser.Email);
                if (user != null)
                {
                    return MakeRestObjectResponse(null, false, 1, "The following email already exists: " + fullUser.Email);
                }
                BODB.NewUser(fullUser);
                return MakeRestObjectResponse(null);
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleObjectException(ex);
            }
        }

        public RESTObjectResult UpdateUser(FullUserView fullUser)
        {
            try
            {
                BODB.UpdateUser(fullUser);
                return MakeRestObjectResponse(null);
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleObjectException(ex);
            }
        }

        public RESTObjectResult ChangePass(ChangePassData changePassData)
        {
            try
            {
                if (changePassData.NewPassword != changePassData.ConfirmPassword)
                {
                    return MakeRestObjectResponse(null, false, 1, "Confirm passowrd does not match with new password");
                }
                User user = BODB.GetUserByEmail(changePassData.Email);
                if (!string.IsNullOrEmpty(changePassData.OldPassword))
                {   
                    if (changePassData.OldPassword != StringUtils.DecodeBase64(user.Password))
                    {
                        return MakeRestObjectResponse(null, false, 2, "Old password is wrong");
                    }
                }
                user.Password = StringUtils.EncodeBase64(changePassData.NewPassword);
                user.LastUpdateDateTime = DateTime.Now;
                BODB.UpdateUser(user);
                return MakeRestObjectResponse(null);
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleObjectException(ex);
            }
        }

        public RESTListResult GetAnthropometries(string email)
        {
            try
            {
                return MakeRestListResponse(BODB.GetAnthropometries(email).Cast<BasicObject>().ToList());
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleListException(ex);
            }
        }

        public RESTObjectResult GetAnthropometryById(int id)
        {
            try
            {
                return MakeRestObjectResponse(BODB.GetAnthropometryById(id));
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleObjectException(ex);
            }
        }

        public RESTObjectResult NewAnthropometry(FullAnthropometryView anthropometry)
        {
            try
            {
                using (TransactionScope ts = BODB.CreateTransactionScope())
                {
                    anthropometry.Date = anthropometry.Date.ToLocalTime();
                    UserData userData = BODB.GetUserDataByEmail(anthropometry.Email);
                    userData.Height = anthropometry.Height;
                    userData.LastUpdateDateTime = DateTime.Now;
                    anthropometry.LastUpdateDateTime = DateTime.Now;
                    BODB.UpdateUserData(userData);
                    BODB.NewAnthropometry((Anthropometry)anthropometry);
                    ts.Complete();
                    return MakeRestObjectResponse(null);
                }
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleObjectException(ex);
            }
        }

        public RESTObjectResult UpdateAnthropometry(FullAnthropometryView anthropometry)
        {
            try
            {
                using (TransactionScope ts = BODB.CreateTransactionScope())
                {
                    anthropometry.Date = anthropometry.Date.ToLocalTime();
                    UserData userData = BODB.GetUserDataByEmail(anthropometry.Email);
                    userData.Height = anthropometry.Height;
                    userData.LastUpdateDateTime = DateTime.Now;
                    anthropometry.LastUpdateDateTime = DateTime.Now;
                    BODB.UpdateUserData(userData);
                    BODB.UpdateAnthropometry((Anthropometry)anthropometry);
                    ts.Complete();
                    return MakeRestObjectResponse(null);
                }
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleObjectException(ex);
            }
        }

        public RESTListResult GetPlicometry(string email)
        {
            try
            {
                return MakeRestListResponse(BODB.GetPlicometries(email).Cast<BasicObject>().ToList());
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleListException(ex);
            }
        }

        public RESTObjectResult GetPlicometryById(int id)
        {
            try
            {
                return MakeRestObjectResponse(BODB.GetPlicometryById(id));
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleObjectException(ex);
            }
        }

        public RESTObjectResult NewPlicometry(Plicometry plicometry)
        {
            try
            {
                BODB.NewPlicometry(plicometry);
                return MakeRestObjectResponse(null);
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleObjectException(ex);
            }
        }

        public RESTObjectResult UpdatePlicometry(Plicometry plicometry)
        {
            try
            {
                BODB.UpdatePlicometry(plicometry);
                return MakeRestObjectResponse(null);
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleObjectException(ex);
            }
        }
    }
}

