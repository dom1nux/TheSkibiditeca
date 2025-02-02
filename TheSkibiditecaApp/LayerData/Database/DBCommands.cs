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

        public static SqlCommand SPReturnBorrow(string borrID, string bookState, SqlConnection conn) {
            string consult =
                "EXEC [dbo].[spProcessReturn]" +
                $"@BorrowID  = {borrID}, " +
                $"@BookState = '{bookState}', " +
                $"@Observation = 'q we'";

            SqlCommand cmd = new(consult, conn);
            return cmd;
        }

        public static SqlCommand SPRegAuthor(Author a, SqlConnection conn) {
            string consult = "EXEC [dbo].[spAddAuthor]" +
                $"@FirstName = '{a.Name}'," +
                $"@LastName = '{a.LastName}'";
            SqlCommand cmd = new(consult, conn);
            return cmd;
        }

        public static SqlCommand SPRegPublisher(Publisher p, SqlConnection conn) {
            string consult = "EXEC [dbo].[spAddPublisher]" +
                $"@Name = '{p.Name}', " +
                $"@Address = '{p.Address}', " +
                $"@PhoneNumber = '{p.Phone}', " +
                $"@Email = '{p.Email}'";
            SqlCommand cmd = new(consult, conn);
            return cmd;
        }

        public static SqlCommand SPRegStudent(Student s, SqlConnection conn) {
            string consult = "EXEC [dbo].[spAddStudent]" +
                $"@StudentID = {s.StudentID}, " +
                $"@Name = '{s.FirstName}', " +
                $"@LastName = '{s.LastName}', " +
                $"@Gender = '{s.Gender}', " +
                $"@Major = '{s.Major}'";
            SqlCommand cmd = new(consult, conn);
            return cmd;
        }

        public static SqlCommand SPConBookAuthor(string book, string author, SqlConnection conn) {
            string consult = "EXEC [dbo].[spConnectBookAuthor]" +
                $"@BookId = {book}, " +
                $"@AuthorID = {author}";
            SqlCommand cmd = new(consult, conn);
            return cmd;
        }

        public static SqlCommand SPAddBook(Book b, SqlConnection conn) {
            string consult = "EXEC [dbo].[spAddBook] " +
                $"@Title = '{b.Title}', " +
                $"@Cover = NULL, " +
                $"@PublicationYear = {b.AgePub}, " +
                $"@GenreID = NULL, " +
                $"@ISBN = '{b.ISBN}', " +
                $"@PublisherID = {b.PublisherID}, " +
                $"@Pages = {b.cantPages}, " +
                $"@Language = {b.Languaje}";
            SqlCommand cmd = new(consult, conn);
            return cmd;
        }
    }
}
