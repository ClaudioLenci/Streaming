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

        public IActionResult ContenutiUtente(int idUtente)
        {
            List<Contenuto> contenuti = db.Query<Contenuto>(
                "SELECT ID_Contenuto, Stagione, Episodio, Titolo, Link " +
                "FROM Contenuto JOIN Visualizzazione ON Contenuto.ID_Contenuto = Visualizzazione.ID_Contenuto " +
                $"WHERE ID_Utente = {idUtente} " +
                $"ORDER BY [Data]")
                .ToList();
            return View(contenuti);
        }

        public IActionResult ContenutiUtente(int idUtente, DateOnly inizio, DateOnly fine)
        {
            List<Contenuto> contenuti = db.Query<Contenuto>(
                "SELECT ID_Contenuto, Stagione, Episodio, Titolo, Link " +
                "FROM Contenuto JOIN Visualizzazione ON Contenuto.ID_Contenuto = Visualizzazione.ID_Contenuto " +
                $"WHERE ID_Utente = {idUtente} AND [Data] >= {inizio} AND [Data] <= {fine} " +
                "ORDER BY [Data]")
                .ToList();
            return View(contenuti);
        }
    }
}
