using System;
using Dapper;
using RMLibs.basic;

namespace TLServer.DAO
{
	[Table("userdata")]
	public class UserData: BasicObject
	{
		[Key]
		public int Id { set; get; }
		public string Email { set; get; }
		public string FirstName { set; get; }
        public string LastName { set; get; }
		public DateTime BirthDate { set; get; }
		public string Sex { set; get; }
		public string AddressStreet { set; get; }
		public string AddressStreetNumber { set; get; }
		public string City { set; get; }
		public string Province { set; get; }
        public string Region { set; get; }
        public string CAP { set; get; }
		public string Phone { set; get; }
		public DateTime LastUpdateDateTime { set; get; }
    }
}

