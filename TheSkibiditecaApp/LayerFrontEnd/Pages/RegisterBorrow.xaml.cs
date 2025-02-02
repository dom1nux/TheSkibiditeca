using LayerData;
using LayerFrontEnd.Controls.Components;
using LayerFrontEnd.Pages;
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
using System.Windows.Shapes;

namespace TheSkibiditecaApp.Windows{
    public partial class BorrowBook : Page {
        private bool fraStuNew = false;
        private SelectStudent st = new();
        public BorrowBook() { 
            InitializeComponent();
            fra_student.Navigate(st);
        }

        private void bt_back_Click(object sender, RoutedEventArgs e) {
            NavigationService.GoBack();
        }

        private void bt_sudentFrame_Click(object sender, RoutedEventArgs e) {
            if(fraStuNew) {
                fra_student.Navigate(st);
                bt_sudentFrame.Content = "Nuevo";
            } else {
                RegisterStudent rs = new();
                rs.Finished += (sender, e) => {
                    st.updateDataSource();
                    fra_student.Navigate(st);
                    bt_sudentFrame.Content = "Nuevo";
                    fraStuNew = !fraStuNew;
                };
                fra_student.Navigate(rs);
                bt_sudentFrame.Content = "Existente";
            }

            fraStuNew = !fraStuNew;
        }

        private void bt_registerConfirm_Click(object sender, RoutedEventArgs e) {
            try {
                if(sb.tb_bookInfo.Text == "" || sb.tb_bookInfo.Text == "") {
                    MessageBox.Show("Selecciona todos los elementos pes.");
                    return;
                }
                SkLogic.database.RegisterBorrow(st.tb_stuInfo.Text, sb.tb_bookInfo.Text, (DateTime)dp_idBook.SelectedDate!);
                NavigationService.Navigate(new BorrowList());
            } catch(Exception ex) {
                MessageBox.Show(ex.Message, "Error");
            }
        }
    }
}
