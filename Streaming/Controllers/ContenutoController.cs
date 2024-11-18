using Microsoft.AspNetCore.Mvc;

namespace Streaming.Controllers
{
    public class ContenutoController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
