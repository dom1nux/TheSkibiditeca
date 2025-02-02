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
    /// Lógica de interacción para SelectAuthor.xaml
    /// </summary>
    public partial class SelectAuthor : UserControl {
        public SelectAuthor() {
            InitializeComponent();
            dg_authorData.ItemsSource = SkLogic.database.ViewAuthors();
        }

        private void dg_authorData_SelectionChanged(object sender, SelectionChangedEventArgs e) {
            List<string> ids = [];
            foreach(DataRowView item in dg_authorData.SelectedItems) {
                ids.Add(item.Row[0].ToString()!);
            }

            tb_authorInfo.Text = String.Join(", ", ids);
        }

        private void dg_authorData_Loaded(object sender, RoutedEventArgs e) {
            dg_authorData.Columns[0].Visibility = Visibility.Hidden;
        }
    }
}
