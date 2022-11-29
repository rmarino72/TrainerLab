using System;
using RMLibs.basic;
using RMLibs.Utilities;
using TLServer.BO;
using TLServer.DAO;
using TLServer.Logging;

namespace TLServer.BL
{
    public class AuthBL : GenericBL
    {
        #region Singleton

        private static AuthBL instance = null;
        private static readonly object padlock = new object();

        public static AuthBL Instance
        {
            get
            {
                lock (padlock)
                {
                    if (instance == null)
                    {
                        instance = new AuthBL();
                    }
                    return instance;
                }
            }
        }

        private AuthBL() : base(TLLogger.Instance)
        {
        }

        #endregion

        private string RenewToken(string email)
        {
            try
            {
                User user = BODB.GetUserByEmail(email);
                user.Token = SecurityUtils.GetNewGuid();
                user.ValidTokenDateTime = DateTime.Now.AddMinutes(Config.Session);
                BODB.UpdateUser(user);
                return user.Token;
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public string VerifyToken(string email, string token)
        {
            try
            {
                User user = BODB.GetUserByEmail(email);
                if (user.Token != token)
                {
                    Debug("Wrong token");
                    return string.Empty;
                }
                if (DateTime.Now > user.ValidTokenDateTime)
                {
                    Debug("Token Expired");
                    return string.Empty;
                }
                return RenewToken(email);
            }
            catch (Exception ex)
            {
                Error(ex);
                return String.Empty;
            }
        }

        public RESTObjectResult Login(string email, string password)
        {
            try
            {
                User user = BODB.GetUserByEmail(email);
                if (user == null)
                {
                    return MakeRestObjectResponse(null, 1, "user not foud");
                }
                if (StringUtils.DecodeBase64(user.Password) != password)
                {
                    return MakeRestObjectResponse(null, 2, "wrong password");
                }
                return MakeRestObjectResponse(new StringValue { Value=RenewToken(email)});
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleObjectException(ex);
            }
        }
    }
}

