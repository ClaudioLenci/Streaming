using Microsoft.AspNetCore.Mvc;
using System.Data.SqlClient;
using Streaming.Models;
using Dapper;
using System.Security.Cryptography;
using System.Text;

namespace Streaming.Controllers
{
    public class UtenteController : Controller
    {
        private readonly SqlConnection db;
        private SHA256 sha256;

        private string HashPassword(string password)
        {
            byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
            StringBuilder stringBuilder = new StringBuilder();
            for(int i=0;i<bytes.Length; i++)
            {
                stringBuilder.Append(bytes[i].ToString("x2"));
            }
            return stringBuilder.ToString();
        }

        public UtenteController(SqlConnection _db)
        {
            db = _db;
            sha256 = SHA256.Create();
        }

        public IActionResult All()
        {
            List<Utente> utenti = db.Query<Utente>(
                "SELECT * FROM Utente")
                .ToList();
            return View(utenti);
        }

        public IActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public RedirectToActionResult Login(string username, string password)
        {
            string hashedPassword = HashPassword(password);
            if(db.Query<bool>($"SELECT CASE " +
                $"WHEN EXISTS ( " +
                    $"SELECT * " +
                    $"FROM Utente " +
                    $"WHERE Username = '{username}' AND PasswordHash = '{hashedPassword}' " +
                $") THEN 1 ELSE 0 " +
                $"END AS Credentials")
                .First())
            {
                return RedirectToAction("All", "Utente");
            }
            else
            {
                return RedirectToAction("Login", "Utente");
            }
        }

        public IActionResult Pending()
        {
            return View();
        }
    }
}
