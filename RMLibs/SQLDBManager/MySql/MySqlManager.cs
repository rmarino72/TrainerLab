﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;

using MySql.Data.MySqlClient;
using Newtonsoft.Json;

using RMLibs.Logging;
using RMLibs.SQLDBManager.DAO;


namespace RMLibs.SQLDBManager.MySql
{
	public class MySqlManager: SqlDbManager
	{

        public const int MYSQL_DEFAULT_PORT = 3306;

        public MySqlManager(Logger logger) : base(logger)
        {
            TcpPort = MySqlManager.MYSQL_DEFAULT_PORT;
        }

        public override void OpenConnection()
        {
            try
            {
                if (Conn == null)
                {
                    if (string.IsNullOrEmpty(DbHost))
                    {
                        string msg = "DBHost property cannot be null or empty!";
                        throw new Exception(msg);
                    }
                    if (string.IsNullOrEmpty(DbName))
                    {
                        string msg = "DBName property cannot be null or empty!";
                        throw new Exception(msg);
                    }
                    if (string.IsNullOrEmpty(DbUser))
                    {
                        string msg = "DBUser property cannot be null or empty!";
                        throw new Exception(msg);
                    }
                    if (string.IsNullOrEmpty(DbPassword))
                    {
                        string msg = "DBPassword property cannot be null or empty!";
                        throw new Exception(msg);
                    }
                    string connectionString = String.Format("SERVER={0};database={1};uid={2};pwd={3};port={4};SslMode=Required;",
                        DbHost,
                        DbName,
                        DbUser,
                        DbPassword,
                        TcpPort.ToString());

                    this.Conn = new MySqlConnection(connectionString);
                }
                if (Conn.State == ConnectionState.Open) throw new Exception("This connection is open yet");
                Conn.Open();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        protected override IDbCommand GetCommand(string query)
        {
            if (Conn == null) throw new Exception("No connection object instance");
            return Transaction == null ? new MySqlCommand(query, (MySqlConnection)Conn) : new MySqlCommand(query, (MySqlConnection)Conn, (MySqlTransaction)Transaction);
        }

        protected override IDbDataAdapter GetAdapter(IDbCommand cmd)
        {
            return new MySqlDataAdapter((MySqlCommand)cmd);
        }

        public override int GetLastId()
        {
            try
            {
                string query = "SELECT last_insert_id() AS lastId";
                string rs = QueryToJson(query);
                if (rs == null)
                {
                    this.Error("An error has occurred: cannot retrive the last inserted id!");
                    return -1;
                }
                List<LastId> listData = JsonConvert.DeserializeObject<List<LastId>>(rs);
                if (listData.Count == 0)
                {
                    this.Error("An error has occurred: cannot retrive the last inserted id!");
                    return -1;
                }
                LastId lastId = listData.First();
                return lastId.lastId;
            }
            catch (Exception ex)
            {
                this.Error(".GetLastId(string tableName) - " + ex.Message);
                throw ex;
            }
        }
    }
}

