using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using Streaming.Models;
using Dapper;
using System.Text.RegularExpressions;

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

        public IActionResult ContenutiUtente(int idUtente, string? inizio = null, string? fine = null)
        {
            DateOnly inizioDate = string.IsNullOrEmpty(inizio) ? DateOnly.MinValue : DateOnly.Parse(inizio);
            DateOnly fineDate = string.IsNullOrEmpty(fine) ? DateOnly.MaxValue : DateOnly.Parse(fine);
            List<Contenuto> contenuti = db.Query<Contenuto>(
                "SELECT Contenuto.ID_Contenuto, Stagione, Episodio, Titolo, Link " +
                "FROM Contenuto JOIN Visualizzazione ON Contenuto.ID_Contenuto = Visualizzazione.ID_Contenuto " +
                $"WHERE ID_Utente = {idUtente} AND [Data] >= '{inizioDate.ToString("yyyy-MM-dd")}' AND [Data] <= '{fineDate.ToString("yyyy-MM-dd")}' " +
                $"ORDER BY [Data]")
                .ToList();
            return View(contenuti);
        }
    }
}
