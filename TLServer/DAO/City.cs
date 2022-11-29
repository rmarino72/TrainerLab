using Dapper;
using RMLibs.basic;

namespace TLServer.DAO
{
	[Table("City")]
	public class City: BasicObject
	{
		[Key]
		public int Id { set; get; }
		public string Name { set; get; }
		public string Province { set; get; }
		public string CAP { set; get; }
	}
}

