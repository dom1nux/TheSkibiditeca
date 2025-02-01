using LayerData.Objects;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace LayerData.Database {
    internal static class DBCommands {
        public static SqlCommand SPLogin(string user, string password, SqlConnection conn) {
            string consult =
                "DECLARE @return_value int\r\n" +
                "DECLARE @message NVARCHAR(255)\r\n" +
                "EXEC [dbo].[spAuthenticateUser] " +
                $"@Username='{user}'," +
                $"@Password='{password}'," +
                "@ReturnCode = @return_value OUTPUT, @Message = @message OUTPUT";

            SqlCommand cmd = new(consult, conn);
            return cmd;
        }

        public static SqlCommand VITable(string table, SqlConnection conn) {
            string consult = $"SELECT * FROM {table}";
            SqlCommand cmd = new(consult, conn);
            return cmd;
        }

        public static SqlCommand VICustomTable(string query, string table, SqlConnection conn) {
            string consult = $"SELECT {query} FROM {table}";
            SqlCommand cmd = new(consult, conn);
            return cmd;
        }

        public static SqlCommand SPRegLibrarian(Librarian lib, string user, string password, SqlConnection conn) {
            string consult =
                "EXEC [dbo].[spRegisterUser] " +
                $"@Username = '{user}'," +
                $"@Password = '{password}'," +
                $"@Role = '{lib.Role}'," +
                $"@FirstName = '{lib.FirstName}'," +
                $"@LastName = '{lib.LastName}'," +
                $"@Address = '{lib.Address}'," +
                $"@PhoneNumber = '{lib.Phone}'," +
                $"@Shift = '{lib.Shift}';";
            SqlCommand cmd = new(consult, conn);
            return cmd;
        }

        public static SqlCommand SPRegBorrow(string stID, string bookID, DateTime date, SqlConnection conn) {
            string consult =
                "EXEC [dbo].[spProcessLending]" +
                $"@StudentID = {stID}," +
                $"@BookID = {bookID}," +
                $"@BorrowDate = '{date.ToShortDateString()}'";
            SqlCommand cmd = new(consult, conn);
            return cmd;
        }

        public static SqlCommand SPReturnBorrow(string borrID, SqlConnection conn) {
            string consult =
                "EXEC [dbo].[spProcessReturn]" +
                $"@BorrowID  = {borrID}";
            SqlCommand cmd = new(consult, conn);
            return cmd;
        }
    }
}
