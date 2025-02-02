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

namespace LayerFrontEnd.Controls.Components {
    /// <summary>
    /// Lógica de interacción para RegisterAuthor.xaml
    /// </summary>
    public partial class RegisterAuthor : UserControl {
        public event EventHandler? Finished;
        public RegisterAuthor() {
            InitializeComponent();
        }

        private void bt_confirm_Click(object sender, RoutedEventArgs e) {
            if(tb_authorName.Text == "" || tb_authorLastName.Text == "") {
                MessageBox.Show("Los campos no deben estar vacios.", "Error");
            }
            Author a = new() { 
                Name = tb_authorName.Text,
                LastName = tb_authorLastName.Text
            };

            try {
                SkLogic.database.RegisterAuhor(a);
                Finished!.Invoke(this, e);
            } catch(Exception ex) {
                MessageBox.Show(ex.Message, "Error");
            }
        }
    }
}
