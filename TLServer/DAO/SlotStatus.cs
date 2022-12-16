using Dapper;
using RMLibs.basic;

namespace TLServer.DAO
{
    [Table("slotstatus")]
	public class SlotStatus: BasicObject
	{
        [Key]
        public int Id { set; get; }
        public string Name { set; get; }
        public string LabelIT { set; get; }
        public string Description { set; get; }
    }
}

