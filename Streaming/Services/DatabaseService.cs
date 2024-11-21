using System.Data.SqlClient;

namespace Streaming.Services
{
    public class DatabaseService
    {
        SqlConnection conn;

        DatabaseService(string databaseUrl)
        {
            conn = new SqlConnection(databaseUrl);
        }
    }
}
