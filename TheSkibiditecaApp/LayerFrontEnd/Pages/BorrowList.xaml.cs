using LayerData;
using System;
using System.Collections.Generic;
using System.Data;
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
        public Func<DataView> DataSource;
        public BorrowList() {
            InitializeComponent();
            DataSource = SkLogic.database.ViewBorrow;
            updateDataSource();
        }

        private void updateDataSource() {
            dg_borrows.ItemsSource = DataSource();
        }

        private void bt_newBorrow_Click(object sender, RoutedEventArgs e) {
            NavigationService.Navigate(new BorrowBook());
        }

        private void bt_updateBorrows_Click(object sender, RoutedEventArgs e) {
            updateDataSource();
        }

        private void DataGrid_Selected(object sender, SelectionChangedEventArgs e) {
            bt_returnConfirm.IsEnabled = true;
            bt_deleteBorrow.IsEnabled = true;
        }

        private void bt_allBorrows_Click(object sender, RoutedEventArgs e) {
            DataSource = SkLogic.database.ViewBorrow;
            updateDataSource();
        }

        private void bt_pending_Click(object sender, RoutedEventArgs e) {
            DataSource = SkLogic.database.ViewPendindBorrows;
            updateDataSource();
        }

        private void bt_completed_Click(object sender, RoutedEventArgs e) {
            DataSource = SkLogic.database.ViewCompleteBorrows;
            updateDataSource();
        }
    }
}
