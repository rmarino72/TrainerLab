﻿using System;
using RMLibs.Utilities;
using TLServer.BO;
using TLServer.DAO;
using TLServer.Logging;

namespace TLServer.BL
{
    public class AuthBl : GenericBl
    {
        #region Singleton

        private static AuthBl _instance;
        private static readonly object Padlock = new object();

        public static AuthBl Instance
        {
            get
            {
                lock (Padlock)
                {
                    return _instance ??= new AuthBl();
                }
            }
        }

        private AuthBl() : base(TlLogger.Instance)
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

        public RestObjectResult Login(string email, string password)
        {
            try
            {
                User user = BODB.GetUserByEmail(email);
                if (user == null)
                {
                    return MakeRestObjectResponse(null, false, 1, "user not found");
                }
                if (StringUtils.DecodeBase64(user.Password) != password)
                {
                    return MakeRestObjectResponse(null, false, 2, "wrong password");
                }
                return MakeRestObjectResponse(new StringValue { Value=RenewToken(email)});
            }
            catch (Exception ex)
            {
                Error(ex);
                return HandleObjectException(ex);
            }
        }

        public RestObjectResult Logout(string email)
        {
            try
            {
                User user = BODB.GetUserByEmail(email);
                if (user == null)
                {
                    return MakeRestObjectResponse(null, false, 1, "user not found");
                }
                user.Token = String.Empty;
                user.ValidTokenDateTime = null;
                BODB.UpdateUser(user);
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
