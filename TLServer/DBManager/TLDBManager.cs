using System;
using System.Collections.Generic;
using System.Linq;
using Dapper;
using RMLibs.Logging;
using RMLibs.SQLDBManager.MySql;
using TLServer.DAO;

namespace TLServer.DBManager
{
	public class TLDBManager : MySqlDapperManager
	{

		/// <summary>
		/// Constructor
		/// </summary>
		/// <param name="logger"></param>
		protected TLDBManager(Logger logger = null):base(logger)
		{ 
		}

		public List<Province> GetProvinces()
		{
			try
			{
				return conn.GetList<Province>().ToList();
			}
			catch (Exception ex)
			{
				Error(ex);
				throw;
			}
		}

		public List<City> GetCities()
		{
            try
            {
                return conn.GetList<City>().ToList();
            }
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }
        }

		public User GetUserByEmail(string Email)
		{
			try
			{
				string query = String.Format("SELECT * FROM user WHERE Email = {0}", Apex(Email));
				return conn.Query<User>(query).FirstOrDefault();
			}
			catch (Exception ex)
			{
				Error(ex);
				throw;
			}
		}

		public void UpdateUser(User user)
		{
			try
			{
				user.LastUpdateDateTime = DateTime.Now;
				conn.Update(user);
			}
            catch (Exception ex)
            {
                Error(ex);
                throw;
            }

        }
	}
}

