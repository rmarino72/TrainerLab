using System.Collections.Generic;
using TLServer.DAO;

namespace TLServer.BO;

public class CompleteTrainingPlan: TrainingPlan
{
    public List<TrainingPlanDetail>Details { set; get; }
}