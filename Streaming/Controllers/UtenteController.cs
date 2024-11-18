using Microsoft.AspNetCore.Mvc;

namespace Streaming.Controllers
{
    public class UtenteController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
