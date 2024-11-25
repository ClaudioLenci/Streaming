using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using Streaming.Models;
using Dapper;

namespace Streaming.Controllers
{
    public class UtenteController : Controller
    {
        private readonly SqlConnection db;

        public UtenteController(SqlConnection _db)
        {
            db = _db;
        }

        public IActionResult All()
        {
            List<Utente> utenti = db.Query<Utente>(
                "SELECT * FROM Utente")
                .ToList();
            return View(utenti);
        }

        public IActionResult Pending()
        {
            return View();
        }
    }
}
