using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;

namespace Streaming.Controllers
{
    public class ContenutoController : Controller
    {
        private readonly SqlConnection db;
        public ContenutoController(SqlConnection _db)
        {
            db = _db;
        }

        public IActionResult Index()
        {
            return View();
        }
    }
}
