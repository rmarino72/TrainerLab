using Dapper;
using RMLibs.basic;

namespace TLServer.DAO
{
    [Table("image")]
    public class Image: BasicObject
    {
        [Key]
        public int Id { set; get; }
        public string Path { set; get; }
    }
}