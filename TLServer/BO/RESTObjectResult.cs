using RMLibs.basic;

namespace TLServer.BO
{
	public class RESTObjectResult: BasicObject
	{
		
        public bool Outcome { set; get; }
        public int Code { set; get; }
        public BasicObject Data { set; get; }
        public string Message { set; get; }
    
	}
}

