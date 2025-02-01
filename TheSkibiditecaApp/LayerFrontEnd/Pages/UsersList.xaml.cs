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
    /// Lógica de interacción para UsersList.xaml
    /// </summary>
    public partial class UsersList : Page {
        public UsersList() {
            InitializeComponent();
            dg_users.ItemsSource = SkLogic.database.ViewLibrariansTable();
        }

        private void bt_newUser_Click(object sender, RoutedEventArgs e) {
            NavigationService.Navigate(new RegisterUser());
        }

        private void bt_updateUsers_Click(object sender, RoutedEventArgs e) {
            dg_users.ItemsSource = SkLogic.database.ViewLibrariansTable();
        }

        private void dg_users_SelectionChanged(object sender, SelectionChangedEventArgs e) {
            bt_deleteUser.IsEnabled = true;
        }
    }
}
