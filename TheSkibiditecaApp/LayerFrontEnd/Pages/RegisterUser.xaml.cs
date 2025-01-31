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
    /// Lógica de interacción para RegisterUser.xaml
    /// </summary>
    public partial class RegisterUser : Page {
        public RegisterUser() {
            InitializeComponent();
        }

        private void bt_back_Click(object sender, RoutedEventArgs e) {
            NavigationService.GoBack();
        }
    }
}
