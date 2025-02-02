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
    /// Lógica de interacción para SelectStudent.xaml
    /// </summary>
    public partial class SelectStudent : UserControl {
        public SelectStudent() {
            InitializeComponent();
            dg_stuData.ItemsSource = SkLogic.database.ViewStudents();
        }

        private void dg_stuData_Loaded(object sender, RoutedEventArgs e) {
            dg_stuData.Columns[0].Visibility = Visibility.Hidden;
        }

        private void dg_stuData_SelectionChanged(object sender, SelectionChangedEventArgs e) {
            DataRowView info = (DataRowView)dg_stuData.SelectedItem;
            tb_stuInfo.Text = info.Row[0].ToString();
        }
    }
}
