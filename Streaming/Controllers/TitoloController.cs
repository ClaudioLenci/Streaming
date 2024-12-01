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

        public IActionResult TopTitoli(int limit = 10)
        {
            List<Titolo> titoli = db.Query<Titolo>(
                $"SELECT TOP {limit} Titolo.ID_titolo, Titolo.Nome, Titolo.Serie " +
                $"FROM Titolo " +
                $"JOIN Contenuto ON Titolo.ID_titolo = Contenuto.ID_titolo " +
                $"JOIN Visualizzazione ON Contenuto.ID_Contenuto = Visualizzazione.ID_Contenuto " +
                $"GROUP BY Titolo.ID_titolo, Titolo.Nome, Titolo.Serie " +
                $"ORDER BY COUNT(ID_Utente)")
                .ToList();
            return View(titoli);
        }
    }
}
