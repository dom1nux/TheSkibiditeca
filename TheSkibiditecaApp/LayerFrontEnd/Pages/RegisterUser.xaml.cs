using LayerData;
using LayerData.Objects;
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

        private void bt_registerConfirm_Click(object sender, RoutedEventArgs e) {
            TextBox[] texboxes = { tb_address, tb_names, tb_lastNames, tb_phoneNumber };
            foreach(TextBox texbox in texboxes) {
                if(texbox.Text == "") {
                    MessageBox.Show("Los cambos no deben estar vacios");
                    return;
                }
            }

            if(cb_role.SelectedIndex == -1 ) {
                MessageBox.Show("Selecciona un rol.");
                return;
            }

            if(cb_shift.SelectedIndex == -1) {
                MessageBox.Show("Selecciona un turno.");
                return;
            }

            Librarian lib = new() {
                Address = tb_address.Text,
                FirstName = tb_names.Text,
                LastName = tb_lastNames.Text,
                Phone = tb_phoneNumber.Text,
                Role = (cb_role.Text == "Administrador" ? "Admin" : "Librarian"),
                Shift = cb_shift.Text,
            };
            try {
                SkLogic.database.RegisterUser(lib, tb_user.Text, tb_password.Text);
                NavigationService.GoBack();
            } catch(Exception ex) {
                MessageBox.Show(ex.Message, "Error");
            }
            
        }
    }
}
