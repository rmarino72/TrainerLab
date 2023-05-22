using System;
using System.Linq;
using Dapper;
using RMLibs.Logging;
using RMLibs.SQLDBManager.DAO;

namespace RMLibs.SQLDBManager.MySql;

public class MySqlDapperManager : MySqlManager
{
    public MySqlDapperManager(Logger logger) : base(logger)
    {
        SimpleCRUD.SetDialect(SimpleCRUD.Dialect.MySQL);
    }

    public LastId GetLastInsertedId()
    {
        try
        {
            return Conn.Query<LastId>("SELECT last_insert_id() AS lastId").FirstOrDefault();
        }
        catch (Exception ex)
        {
            Error(ex);
            throw;
        }
    }
}