using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;

namespace Streaming.Controllers
{
    public class TitoloController : Controller
    {
        private readonly SqlConnection db;

        public TitoloController(SqlConnection _db)
        {
            db = _db;
        }

        public IActionResult Index()
        {
            return View();
        }
    }
}
