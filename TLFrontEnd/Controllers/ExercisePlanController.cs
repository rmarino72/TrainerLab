using Microsoft.AspNetCore.Mvc;

namespace TLFrontEnd.Controllers
{
    public class ExercisePlanController : Controller
    {
        // GET
        public IActionResult Index()
        {
            return View();
        }
    }
}