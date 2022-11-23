using System;
using RMLibs.Logging;
using RMLibs.SQLDBManager.MySql;

namespace TLServer.DBManager
{
	public class TLDBManager : MySqlManager
	{

		/// <summary>
		/// Constructor
		/// </summary>
		/// <param name="logger"></param>
		protected TLDBManager(Logger logger = null):base(logger)
		{ 
		}
	}
}

