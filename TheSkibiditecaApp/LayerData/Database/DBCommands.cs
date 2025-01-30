using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LayerData.Database {
    internal static class DBCommands {
        public static SqlCommand SPLogin(string user, string password, SqlConnection conn) {
            string consult = $"DECLARE @return_value int\r\nDECLARE @message NVARCHAR(255)\r\nEXEC [dbo].[spAuthenticateUser] @Username='{user}', @Password='{password}', @ReturnCode = @return_value OUTPUT, @Message = @message OUTPUT";
            SqlCommand cmd = new(consult, conn);
            return cmd;
        }

        public static SqlCommand VITable(string table, SqlConnection conn) {
            string consult = $"SELECT * FROM {table}";
            SqlCommand cmd = new(consult, conn);
            return cmd;
        }
    }
}
