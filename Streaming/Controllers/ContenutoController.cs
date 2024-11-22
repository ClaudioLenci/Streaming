using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using Streaming.Models;
using Dapper;

namespace Streaming.Controllers
{
    public class ContenutoController : Controller
    {
        private readonly SqlConnection db;
        public ContenutoController(SqlConnection _db)
        {
            db = _db;
        }

        public IActionResult Contenuto(int id)
        {
            Contenuto contenuto = db.Query<Contenuto>(
                $"SELECT * " +
                $"FROM Contenuto " +
                $"WHERE ID_Contenuto = {id}")
                .First();
            return View(contenuto);
        }

        public IActionResult TopContenuti(int limit = 10)
        {
            List<Contenuto> topContenuti = db.Query<Contenuto>(
                $"SELECT TOP {limit} ID_Contenuto, Stagione, Episodio, Titolo, Link " +
                "FROM Contenuto JOIN Visualizzazione ON Contenuto.ID_Contenuto = Visualizzazione.ID_Contenuto " +
                "GROUP BY ID_Contenuto " +
                "ORDER BY COUNT(ID_Utente)")
                .ToList();
            return View(topContenuti);
        }
    }
}
