using TLServer.Logging;

namespace TLServer.DBManager;

public class BoDbInstance : TlDbManager
{
    #region Singleton

    private static BoDbInstance _instance;
    private static readonly object Padlock = new();

    public static BoDbInstance Instance
    {
        get
        {
            lock (Padlock)
            {
                return _instance ??= new BoDbInstance();
            }
        }
    }

    private BoDbInstance() : base(TlLogger.Instance)
    {
        DbHost = Config.DbHost;
        TcpPort = Config.DbPort;
        DbUser = Config.DbUser;
        DbPassword = Config.DbPassword;
        DbName = Config.DbName;
        OpenConnection();
        CloseConnection();
    }

    public sealed override void OpenConnection()
    {
        base.OpenConnection();
    }

    #endregion
}