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

namespace LayerFrontEnd.Controls.Components {
    /// <summary>
    /// Lógica de interacción para RegisterStudent.xaml
    /// </summary>
    public partial class RegisterStudent : UserControl {
        public event EventHandler? Finished;
        public RegisterStudent() {
            InitializeComponent();
        }

        private void bt_confirm_Click(object sender, RoutedEventArgs e) {
            Student s = new() {
                FirstName = tb_Names.Text,
                LastName = tb_lastNames.Text,
                Gender = cb_gender.Text,
                Major = cb_major.Text[0].ToString(),
                StudentID = tb_code.Text,
            };

            try {
                SkLogic.database.RegisterStudent(s);
                Finished!.Invoke(this, e);
            } catch(Exception ex) {
                MessageBox.Show(ex.Message, "Error");
            }
        }
    }
}
