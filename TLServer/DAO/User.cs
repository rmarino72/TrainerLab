using System;
using Dapper;
using RMLibs.basic;

namespace TLServer.DAO
{
	[Table("user")]
	public class User: BasicObject
	{
		[Key]
		public int Id { set; get; }
		public string Email { set; get; }
		public string Password { set; get; }
		public string Role { set; get; }
		public string Token { set; get; }
		public DateTime? ValidTokenDateTime { set; get; }
		public DateTime CreationDateTime { set; get; }
		public DateTime LastUpdateDateTime { set; get; }
    }
}

