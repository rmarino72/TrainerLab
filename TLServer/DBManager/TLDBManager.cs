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
	}
}

