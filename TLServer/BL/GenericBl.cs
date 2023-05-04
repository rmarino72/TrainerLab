﻿using System;
using System.Collections.Generic;
using RMLibs.basic;
using RMLibs.Logging;
using TLServer.BO;
using TLServer.DBManager;

namespace TLServer.BL
{
	public class GenericBl: BasicObject
	{

		protected RestListResult MakeRestListResponse(List<BasicObject> data, bool outcome=true, int code = 0, string message = "")
		{
			RestListResult result = new RestListResult();
			result.Outcome = outcome;
			result.Data = data;
			result.Message = message;
			result.Code = code;
			return result;
		}

        protected RestObjectResult MakeRestObjectResponse(BasicObject data, bool outcome = true, int code = 0, string message = "")
        {
            RestObjectResult result = new RestObjectResult();
            result.Outcome = outcome;
            result.Data = data;
            result.Message = message;
            result.Code = code;
            return result;
        }

		protected RestListResult HandleListException(Exception ex, int code = 0)
		{
            Error(ex);
            RestListResult result = new RestListResult();
            result.Outcome = false;
            result.Data = null;
            result.Message = ex.Message;
            result.Code = code;
            return result;
        }

        protected RestObjectResult HandleObjectException(Exception ex, int code = 0)
        {
            Error(ex);
            RestObjectResult result = new RestObjectResult();
            result.Outcome = false;
            result.Data = null;
            result.Message = ex.Message;
            result.Code = code;
            return result;
        }

        /// <summary>
        /// Database Manager Instance
        /// </summary>
        protected TlDbManager BODB => BoDbInstance.Instance;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="logger"></param>
        protected GenericBl(Logger logger = null)
        {
			this.Logger = logger;
		}
	}
}
