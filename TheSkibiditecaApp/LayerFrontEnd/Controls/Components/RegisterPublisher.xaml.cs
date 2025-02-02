using LayerData.Objects;
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

namespace LayerFrontEnd.Controls.Components{
    /// <summary>
    /// Lógica de interacción para RegisterPublisher.xaml
    /// </summary>
    public partial class RegisterPublisher : UserControl {
        public event EventHandler? Finished;
        public RegisterPublisher() {
            InitializeComponent();
        }

        private void bt_confirm_Click(object sender, RoutedEventArgs e) {
            Publisher p = new() {
                Name = tb_editName.Text,
                Address = tb_editAdress.Text,
                Email = tb_editMail.Text,
                Phone = tb_editPhone.Text
            };

            try {
                SkLogic.database.RegisterPublisher(p);
                Finished!.Invoke(this, e);
            } catch(Exception ex) {
                MessageBox.Show(ex.Message, "Error");
            }
        }
    }
}
