using Dapper;
using TLServer.DAO;

namespace TLServer.BO;

[Table("fullexerciseview")]
public class FullExerciseView : Exercise
{
    public string MuscularGroupName { set; get; }
    public string Path { set; get; }
}