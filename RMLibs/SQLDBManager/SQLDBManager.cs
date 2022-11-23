using System;
using System.Data;
using System.Transactions;

using Newtonsoft.Json;

using RMLibs.basic;
using RMLibs.Logging;

namespace RMLibs.SQLDBManager
{
	public class SQLDBManager: BasicObject
	{

        protected IDbConnection conn;
        protected IDbTransaction transaction;


        public string DBHost { get; set; }
        public string DBName { get; set; }
        public int TCPPort { get; set; }
        public string DBPassword { get; set; }
        public string DBUser { get; set; }


        //********** METHODS TO BE IMPLEMENTED IN SUB CLASSES **********

        protected SQLDBManager(Logger logger = null)
        {
            Logger = logger;
        }

        protected virtual IDbCommand GetCommand(string query)
        {
            throw new NotImplementedException();
        }

        protected virtual IDbDataAdapter GetAdapter(IDbCommand cmd)
        {
            throw new NotImplementedException();
        }

        public virtual int GetLastId()
        {
            throw new NotImplementedException();
        }

        /// <summary>
        /// Opens the connection to the database
        /// </summary>
        /// <exception cref="Exception"></exception>
        public virtual void OpenConnection()
        {
        }

        //***************************************************************



        /// <summary>
        /// Closes the connection to the database
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void CloseConnection()
        {
            try
            {
                if (transaction != null) throw new Exception("There is a pending transaction");
                if (conn == null) throw new Exception("The connection does not exist");
                if (conn.State != ConnectionState.Open) throw new Exception("The connection is not open");
                conn.Close();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        /// <summary>
        /// Executes the query and returns the result in a DataSet
        /// </summary>
        /// <param name="query">The query to be executed</param>
        /// <returns></returns>
        public DataSet Query(string query)
        {
            try
            {
                if (conn == null) throw new Exception("The connection does not exist");
                if (conn.State != ConnectionState.Open) throw new Exception("The connection is not open");
                IDbCommand cmd = GetCommand(query);
                IDataAdapter dataAdapter = GetAdapter(cmd);
                DataSet ds = new DataSet();
                dataAdapter.Fill(ds);
                return ds;
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        /// <summary>
        /// Executes the query and returns the result in JSON format
        /// </summary>
        /// <param name="query">The query to be executed</param>
        /// <returns></returns>
        public string QueryToJson(string query)
        {
            try
            {
                return JsonConvert.SerializeObject(Query(query));
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        /// <summary>
        /// Executes the SQL command (INSERT, UPDATE, DELETE...) and returns the number of affected rows
        /// </summary>
        /// <param name="sqlCommand">Te command to be executed</param>
        /// <returns></returns>
        public int SqlCommand(string sqlCommand)
        {
            try
            {
                if (conn == null) throw new Exception("The connection does not exist");
                if (conn.State != ConnectionState.Open) throw new Exception("The connection is not open");
                IDbCommand cmd = GetCommand(sqlCommand);
                return cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        /// <summary>
        /// Creates a transactionscope and returns it
        /// </summary>
        /// <returns></returns>
        public TransactionScope CreateTransactionScope()
        {
            return new TransactionScope();
        }

        /// <summary>
        /// Starts a transaction on the current connection
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void StartTransaction()
        {
            try
            {
                if (conn == null) throw new Exception("The connection does not exist");
                if (conn.State != ConnectionState.Open) throw new Exception("The connection is not open");
                if (transaction != null) throw new Exception("Error Transaction: another transaction is already running");
                transaction = conn.BeginTransaction();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        /// <summary>
        /// Commits the current transaction on this connection
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void CommitTransaction()
        {
            try
            {
                if (conn == null) throw new Exception("The connection does not exist");
                if (conn.State != ConnectionState.Open) throw new Exception("The connection is not open");
                if (transaction == null) throw new Exception("There is no pending transaction");
                transaction.Commit();
                transaction.Dispose();
                transaction = null;
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        /// <summary>
        /// Rolls back the current transaction on this connection
        /// </summary>
        /// <exception cref="Exception"></exception>
        public void RollBackTransaction()
        {
            try
            {
                if (conn == null) throw new Exception("The connection does not exist");
                if (conn.State != ConnectionState.Open) throw new Exception("The connection is not open");
                if (transaction == null) throw new Exception("There is no pending transaction");
                transaction.Rollback();
                transaction.Dispose();
                transaction = null;
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

        public static string Apex(string value)
        {
            return "'" + value.Trim().Replace("'", "''") + "'";
        }
    }
}

