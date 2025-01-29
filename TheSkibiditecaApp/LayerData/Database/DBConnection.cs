using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LayerData.Database {
    public class DBConnection {
        SqlConnection conn;
        public DBConnection() {
            string conex = "Data Source=161.132.37.46;Initial Catalog=TheSkibiditeca;User ID=AppLogin;Password=YourSecurePassword!123;Trust Server Certificate=True";
            conn = new SqlConnection(conex);
            
        }

        public string CheckLogin(string user, string password) {
            try {
                conn.Open();
                string loginstr = DBCommands.SBLogin(user, password);
                SqlCommand cmd = new(loginstr, conn);
                SqlDataReader dr = cmd.ExecuteReader();

                if(dr.Read()) return (string)dr["Role"];
                else return string.Empty;
            } finally { 
                conn.Close();
            }
        }
    }
}
