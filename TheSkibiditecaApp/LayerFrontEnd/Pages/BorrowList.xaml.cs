using LayerData;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using TheSkibiditecaApp;
using TheSkibiditecaApp.Windows;

namespace LayerFrontEnd.Pages {
    /// <summary>
    /// Lógica de interacción para BorrowList.xaml
    /// </summary>
    public partial class BorrowList : Page {
        public BorrowList() {
            InitializeComponent();
            dg_borrows.ItemsSource = SkLogic.database.ViewBorrowTable();
        }

        private void bt_newBorrow_Click(object sender, RoutedEventArgs e) {
            NavigationService.Navigate(new BorrowBook());
        }

        private void bt_updateBorrows_Click(object sender, RoutedEventArgs e) {
            dg_borrows.ItemsSource = SkLogic.database.ViewBorrowTable();
        }

        private void DataGrid_Selected(object sender, SelectionChangedEventArgs e) {
            bt_returnConfirm.Visibility = Visibility.Visible;
            bt_deleteBorrow.Visibility = Visibility.Visible;
        }
    }
}
