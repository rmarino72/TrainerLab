using System;
using Dapper;
using RMLibs.basic;

namespace TLServer.DAO
{
	[Table("slot")]
	public class Slot: BasicObject
	{
		[Key]
		public int Id { set; get; }
		public DateTime StartDateTime { set; get; }
        public DateTime EndDateTime { set; get; }
		public string Status { set; get; }
		public string Email { set; get; }
		public string Description { set; get; }
    }
}

