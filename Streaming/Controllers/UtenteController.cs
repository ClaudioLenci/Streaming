using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;

namespace Streaming.Controllers
{
    public class UtenteController : Controller
    {
        private readonly SqlConnection db;

        public UtenteController(SqlConnection _db)
        {
            db = _db;
        }

        public IActionResult Index()
        {
            return View();
        }
    }
}
