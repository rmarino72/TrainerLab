using Dapper;
using RMLibs.basic;

namespace TLServer.DAO
{
	[Table("province")]	
	public class Province: BasicObject
	{
		[Key]
		public int Id { set; get; }
		public string Name { set; get; }
		public string Abbreviation { set; get; }
		public string Region { set; get; }
	}
}

