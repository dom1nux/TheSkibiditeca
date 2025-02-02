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

namespace LayerFrontEnd.Controls.Components {
    /// <summary>
    /// Lógica de interacción para SelectBook.xaml
    /// </summary>
    public partial class SelectBook : UserControl {
        public SelectBook() {
            InitializeComponent();
            dg_bookData.ItemsSource = SkLogic.database.ViewBooks();
        }

        private void dg_bookData_Loaded(object sender, RoutedEventArgs e) {
            dg_bookData.Columns[0].Visibility = Visibility.Hidden;
            dg_bookData.Columns[2].Visibility = Visibility.Hidden;
            dg_bookData.Columns[3].Visibility = Visibility.Hidden;
            dg_bookData.Columns[4].Visibility = Visibility.Hidden;
            //
            dg_bookData.Columns[1].Width = 250;
        }

        private void dg_bookData_SelectionChanged(object sender, SelectionChangedEventArgs e) {
            DataRowView info = (DataRowView)dg_bookData.SelectedItem;
            tb_bookInfo.Text = info.Row[0].ToString();
        }
    }
}
