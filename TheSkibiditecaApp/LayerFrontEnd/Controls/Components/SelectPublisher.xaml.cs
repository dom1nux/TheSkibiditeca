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
    /// Lógica de interacción para SelectPublisher.xaml
    /// </summary>
    public partial class SelectPublisher : UserControl {
        DataView datavw = SkLogic.database.ViewEditorials();
        public SelectPublisher() {
            InitializeComponent();
            dg_pubData.Loaded += Dg_pubData_Loaded;
            dg_pubData.ItemsSource = datavw;
        }

        private void Dg_pubData_Loaded(object sender, RoutedEventArgs e) {
            dg_pubData.Columns[0].Visibility = Visibility.Hidden;
        }

        private void dg_pubData_SelectionChanged(object sender, SelectionChangedEventArgs e) {
            DataRowView info = (DataRowView)dg_pubData.SelectedItem;
            tb_pubInfo.Text = info.Row[0].ToString();
        }
    }
}
