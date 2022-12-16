using System;
using Dapper;
using RMLibs.basic;

namespace TLServer.BO
{
	[Table("fullslotview")]
	public class FullSlotView: BasicObject
	{
		[Key]
        public int Id { set; get; }
        public DateTime StartDateTime { set; get; }
        public DateTime EndDateTime { set; get; }
        public string Status { set; get; }
        public string Email { set; get; }
        public string Description { set; get; }
        public string FirstName { set; get; }
        public string LastName { set; get; }
    }
}

