using Microsoft.AspNetCore.Mvc;

namespace Streaming.Controllers
{
    public class TitoloController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
