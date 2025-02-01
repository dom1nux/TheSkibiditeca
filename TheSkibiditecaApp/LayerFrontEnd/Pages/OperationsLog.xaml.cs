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

namespace LayerFrontEnd.Pages {
    /// <summary>
    /// Lógica de interacción para OperationsLog.xaml
    /// </summary>
    public partial class OperationsLog : Page {
        public OperationsLog() {
            InitializeComponent();
            dg_operationsLogs.ItemsSource = SkLogic.database.ViewRegistersTables();
        }

        private void bt_updateGrid_Click(object sender, RoutedEventArgs e) {
            dg_operationsLogs.ItemsSource = SkLogic.database.ViewRegistersTables();
        }
    }
}
