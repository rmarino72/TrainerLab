using System;
using TLServer.BO;
using TLServer.Logging;

namespace TLServer.BL;

public class TLAppBL : GenericBl
{
    public RestObjectResult GetConfig()
    {
        try
        {
            return MakeRestObjectResponse(BODB.GetConfig());
        }
        catch (Exception ex)
        {
            return HandleObjectException(ex);
        }
    }

    public RestObjectResult UpdateConfig(DAO.Config config)
    {
        try
        {
            BODB.UpdateConfig(config);
            Config.DismissTolerance = config.DismissTolerance;
            return MakeRestObjectResponse(null);
        }
        catch (Exception ex)
        {
            return HandleObjectException(ex);
        }
    }

    #region Singleton

    private static TLAppBL instance;
    private static readonly object padlock = new();

    public static TLAppBL Instance
    {
        get
        {
            lock (padlock)
            {
                if (instance == null) instance = new TLAppBL();
                return instance;
            }
        }
    }

    private TLAppBL() : base(TlLogger.Instance)
    {
    }

    #endregion
}