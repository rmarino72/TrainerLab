using System;
using Dapper;
using RMLibs.Logging;

namespace RMLibs.SQLDBManager.MySql
{
    public class MySqlDapperManager : MySqlManager
    {
        public MySqlDapperManager(Logger logger) : base(logger)
        {
            SimpleCRUD.SetDialect(SimpleCRUD.Dialect.MySQL);
        }
    }
}

