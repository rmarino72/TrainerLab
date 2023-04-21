using Dapper;
using RMLibs.basic;

namespace TLServer.DAO
{
    [Table("musculargroup")]
    public class MuscularGroup: BasicObject
    {
        [Key]
        public int Id { set; get; }
        public string Name { set; get; }
        public string Description { set; get; }
    }
}