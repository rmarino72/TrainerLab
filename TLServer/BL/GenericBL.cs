using System;
using System.Collections.Generic;
using RMLibs.basic;
using RMLibs.Logging;
using TLServer.BO;
using TLServer.DBManager;

namespace TLServer.BL
{
	public class GenericBL: BasicObject
	{

		protected RESTListResult MakeRestListResponse(List<BasicObject> data, int code = 0, string message = "")
		{
			RESTListResult result = new RESTListResult();
			result.Outcome = true;
			result.Data = data;
			result.Message = message;
			result.Code = code;
			return result;
		}

		protected TLDBManager BODB
		{
			get
			{
				return BODBInstance.Instance;
			}
		}

		protected GenericBL(Logger logger = null):base()
		{
			this.Logger = logger;
		}
	}
}

