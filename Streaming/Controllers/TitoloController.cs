using Dapper;
using Microsoft.AspNetCore.Mvc;
using Streaming.Models;
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

        public IActionResult All()
        {
            List<Titolo> contenuti = db.Query<Titolo>(
                "SELECT * " +
                "FROM Titolo"
                ).ToList();
            return View(contenuti);
        }
    }
}
