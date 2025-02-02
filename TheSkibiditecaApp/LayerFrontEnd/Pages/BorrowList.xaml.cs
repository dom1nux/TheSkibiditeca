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
            setReturnButtons(false);
            if(dg_borrows.Columns.Count != 0) dg_borrows.Columns[0].Visibility = Visibility.Hidden;
        }

        private void setReturnButtons(bool t) {
            if(t) {
                bt_returnConfirm.IsEnabled = true;
                cb_bookStatus.Visibility = Visibility.Visible;
            }else {
                bt_returnConfirm.IsEnabled = false;
                cb_bookStatus.Visibility = Visibility.Hidden;
            }
        }

        private void bt_newBorrow_Click(object sender, RoutedEventArgs e) {
            NavigationService.Navigate(new BorrowBook());
        }

        private void bt_updateBorrows_Click(object sender, RoutedEventArgs e) {
            updateDataSource();
        }

        private void DataGrid_Selected(object sender, SelectionChangedEventArgs e) {
            DataRowView info = (DataRowView)dg_borrows.SelectedItem;
            if(info != null) {
                string status = info.Row[4].ToString()!;
                setReturnButtons(status != "Devuelto");
            } 
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

        private void bt_returnConfirm_Click(object sender, RoutedEventArgs e) {
            try {
                if(cb_bookStatus.SelectedIndex == -1) {
                    MessageBox.Show("Ingresa el estado en el que se retornó el libro.");
                    return;
                }
                DataRowView info = (DataRowView)dg_borrows.SelectedItem;
                string id = info.Row[0].ToString()!;
                SkLogic.database.ReturnedBorrow(id, cb_bookStatus.Text);
                updateDataSource();

            } catch(Exception ex) {
                MessageBox.Show(ex.Message, "Error");
            }
        }

        private void dg_borrows_Loaded(object sender, RoutedEventArgs e) {
            dg_borrows.Columns[0].Visibility = Visibility.Hidden;
        }
    }
}
