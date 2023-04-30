using Dapper;
using RMLibs.basic;

namespace TLServer.DAO
{
    [Table("exercise")]
    public class Exercise: BasicObject
    {
        [Key]
        public int Id { set; get; }
        public string Name { set; get; }
        public string Description { set; get; }
        public string MuscularGroup { set; get; }
        public int ?Image { set; get; }
    }
}