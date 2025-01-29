using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LayerData.Database {
    public static class DBCommands {
        public static string SBLogin(string user, string password) {
            return $"DECLARE @return_value int\r\nDECLARE @message NVARCHAR(255)\r\nEXEC [dbo].[spAuthenticateUser] @Username='{user}', @Password='{password}', @ReturnCode = @return_value OUTPUT, @Message = @message OUTPUT";
        }
    }
}
