using System;
using System.Collections.Generic;
using Google.Protobuf;
using RMLibs.basic;
using RMLibs.Logging;
using TLServer.BO;
using TLServer.DBManager;

namespace TLServer.BL
{
	public class GenericBL: BasicObject
	{

		protected RESTListResult MakeRestListResponse(List<BasicObject> data, bool outcome=true, int code = 0, string message = "")
		{
			RESTListResult result = new RESTListResult();
			result.Outcome = outcome;
			result.Data = data;
			result.Message = message;
			result.Code = code;
			return result;
		}

        protected RESTObjectResult MakeRestObjectResponse(BasicObject data, bool outcome = true, int code = 0, string message = "")
        {
            RESTObjectResult result = new RESTObjectResult();
            result.Outcome = outcome;
            result.Data = data;
            result.Message = message;
            result.Code = code;
            return result;
        }

		protected RESTListResult HandleListException(Exception ex, int code = 0)
		{
            RESTListResult result = new RESTListResult();
            result.Outcome = false;
            result.Data = null;
            result.Message = ex.Message;
            result.Code = code;
            return result;
        }

        protected RESTObjectResult HandleObjectException(Exception ex, int code = 0)
        {
            RESTObjectResult result = new RESTObjectResult();
            result.Outcome = false;
            result.Data = null;
            result.Message = ex.Message;
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

