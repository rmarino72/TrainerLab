using Dapper;
using RMLibs.basic;

namespace TLServer.DAO
{
	[Table("role")]
	public class Role: BasicObject
	{
		[Key]
		public int Id { set; get; }
		public string Name { set; get; }
		public string LabelIT { set; get; }
		public string Description { set; get; }
	}
}

