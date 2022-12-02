using System;
using Dapper;
using RMLibs.basic;
namespace TLServer.BO
{
	[Table("fulluser")]
	public class FullUser: BasicObject
	{
		public int Id { set; get; }
		public string Email { set; get; }
        public string Phone { set; get; }
        public string FirstName { set; get; }
		public string LastName { set; get; }
        public string Sex { set; get; }
        public string Role { set; get; }
		public string RoleDesc { set; get; }
		public DateTime BirthDate { set; get; }

    }
}

