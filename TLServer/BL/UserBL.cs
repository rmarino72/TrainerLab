using System;
using System.Linq;
using RMLibs.basic;
using RMLibs.Utilities;
using TLServer.BO;
using TLServer.DAO;
using TLServer.Logging;

namespace TLServer.BL;

public class UserBL : GenericBl
{
    public RestListResult GetRegions()
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

    public RestListResult GetProvinces()
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

    public RestListResult GetProvincesByRegion(string region)
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

    public RestListResult GetCities()
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

    public RestListResult GetCitiesByProvince(string province)
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

    public RestListResult GetRoles()
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

    public RestListResult GetSexes()
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

    public RestObjectResult GetUserByEmail(string email)
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

    public RestListResult GetFullUsers()
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

    public RestObjectResult GetFullUserByEmail(string email)
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

    public RestObjectResult NewUser(FullUserView fullUser)
    {
        try
        {
            var user = BODB.GetUserByEmail(fullUser.Email);
            if (user != null)
                return MakeRestObjectResponse(null, false, 1, "The following email already exists: " + fullUser.Email);
            BODB.NewUser(fullUser);
            return MakeRestObjectResponse(null);
        }
        catch (Exception ex)
        {
            Error(ex);
            return HandleObjectException(ex);
        }
    }

    public RestObjectResult UpdateUser(FullUserView fullUser)
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

    public RestObjectResult ChangePass(ChangePassData changePassData)
    {
        try
        {
            if (changePassData.NewPassword != changePassData.ConfirmPassword)
                return MakeRestObjectResponse(null, false, 1, "Confirm passowrd does not match with new password");
            var user = BODB.GetUserByEmail(changePassData.Email);
            if (!string.IsNullOrEmpty(changePassData.OldPassword))
                if (changePassData.OldPassword != StringUtils.DecodeBase64(user.Password))
                    return MakeRestObjectResponse(null, false, 2, "Old password is wrong");
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

    public RestListResult GetAnthropometries(string email)
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

    public RestObjectResult GetAnthropometryById(int id)
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

    public RestObjectResult NewAnthropometry(FullAnthropometryView anthropometry)
    {
        try
        {
            using (var ts = BODB.CreateTransactionScope())
            {
                anthropometry.Date = anthropometry.Date.ToLocalTime();
                var userData = BODB.GetUserDataByEmail(anthropometry.Email);
                userData.Height = anthropometry.Height;
                userData.LastUpdateDateTime = DateTime.Now;
                anthropometry.LastUpdateDateTime = DateTime.Now;
                BODB.UpdateUserData(userData);
                BODB.NewAnthropometry(anthropometry);
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

    public RestObjectResult UpdateAnthropometry(FullAnthropometryView anthropometry)
    {
        try
        {
            using (var ts = BODB.CreateTransactionScope())
            {
                anthropometry.Date = anthropometry.Date.ToLocalTime();
                var userData = BODB.GetUserDataByEmail(anthropometry.Email);
                userData.Height = anthropometry.Height;
                userData.LastUpdateDateTime = DateTime.Now;
                anthropometry.LastUpdateDateTime = DateTime.Now;
                BODB.UpdateUserData(userData);
                BODB.UpdateAnthropometry(anthropometry);
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

    public RestListResult GetPlicometry(string email)
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

    public RestObjectResult GetPlicometryById(int id)
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

    public RestObjectResult NewPlicometry(Plicometry plicometry)
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

    public RestObjectResult UpdatePlicometry(Plicometry plicometry)
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

    public RestObjectResult GetPercentages(string email, double plicoSum)
    {
        try
        {
            UserData user = BODB.GetUserDataByEmail(email);
            var tmp = (DateTime.Now - user.BirthDate);
            var age = (new DateTime(tmp.Ticks)).Year;
            var bodyDensity = user.Sex == "M"? 
                GymnFormulas.BodyDensityMan(plicoSum, age) :
                GymnFormulas.BodyDensityWoman(plicoSum, age);
            bodyDensity = Math.Round(bodyDensity, 2);
            var fatPerc = Math.Round(GymnFormulas.FatPercentage(bodyDensity), 2);
            var percentages = new Percentages { FatPercentage = fatPerc, BodyDensity = bodyDensity };
            return MakeRestObjectResponse(percentages);
        }
        catch (Exception ex)
        {
            Error(ex);
            return HandleObjectException(ex);
        }
    }

    #region Singleton

    private static UserBL _instance;
    private static readonly object Padlock = new();

    public static UserBL Instance
    {
        get
        {
            lock (Padlock)
            {
                if (_instance == null) _instance = new UserBL();
                return _instance;
            }
        }
    }

    private UserBL() : base(TlLogger.Instance)
    {
    }

    #endregion
}