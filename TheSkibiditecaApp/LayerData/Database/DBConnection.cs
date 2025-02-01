using LayerData.Objects;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;

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
                SqlCommand cmd = DBCommands.SPLogin(user, password, conn);
                SqlDataReader dr = cmd.ExecuteReader();
                if(dr.Read()) return (string)dr["Role"];
                else return string.Empty;
            } finally {
                conn.Close();
            }
        }

        public void RegisterUser(Librarian lib, string user, string pass) {
            try {
                conn.Open();
                SqlCommand cmd = DBCommands.SPRegLibrarian(lib, user, pass, conn);
                cmd.ExecuteNonQuery();
            } finally { 
                conn.Close();
            }
        }

        public void RegisterBorrow(string stId, string bookId, DateTime date) {
            try {
                conn.Open();
                SqlCommand cmd = DBCommands.SPRegBorrow(stId, bookId, date, conn);
                cmd.ExecuteNonQuery();
            } finally {
                conn.Close();
            }
        }

        public void ReturnedBorrow(string borrowId) {
            try {
                conn.Open();
                SqlCommand cmd = DBCommands.SPReturnBorrow(borrowId, conn);
                cmd.ExecuteNonQuery();
            } finally {
                conn.Close();
            }
        }

        public DataView ViewBorrow() {
            return LoadView("vwAllBorrows");
        }

        public DataView ViewPendindBorrows() {
            return LoadView("vwPendingBorrows");
        }

        public DataView ViewCompleteBorrows() {
            return LoadView("vwReturnedBorrows");
        }

        public DataView ViewAuthors() {
            return LoadView("vwAuthorInfo");
        }

        public DataView ViewEditorials() {
            return LoadView("vwPublisherInfo");
        }

        public DataView ViewStudents() {
            return LoadView("vwStudentInfo");
        }

        public DataView ViewLibrarians() {
            return LoadView("vwLibrarianInfo");
        }

        public DataView ViewRegisters() {
            return LoadView("vwOperationLog");
        }

        private DataView LoadView(string table) {
            try {
                DataTable dt = new();
                conn.Open();
                SqlCommand cmd = DBCommands.VITable(table, conn);
                SqlDataReader dr = cmd.ExecuteReader();
                dt.Load(dr);
                return dt.DefaultView;
            } finally {
                conn.Close();
            }
        }
    }
}
