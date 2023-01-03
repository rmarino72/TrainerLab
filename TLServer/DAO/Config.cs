using Dapper;
using RMLibs.basic;
namespace TLServer.DAO
{
	[Table ("config")]
	public class Config: BasicObject
	{
		[Key]
		public int Id { set; get; }
		public int DismissTolerance { set; get; }

    }
}

