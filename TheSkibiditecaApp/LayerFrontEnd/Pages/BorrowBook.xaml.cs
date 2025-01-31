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
        public BorrowBook() { 
            InitializeComponent();
            fra_student.Navigate(new SelectStudent());
        }

        private void bt_back_Click(object sender, RoutedEventArgs e) {
            NavigationService.Navigate(new BorrowList());
        }

        private void bt_sudentFrame_Click(object sender, RoutedEventArgs e) {
            if(fraStuNew) {
                fra_student.Navigate(new SelectStudent());
                bt_sudentFrame.Content = "Nuevo";
            } else {
                fra_student.Navigate(new RegisterStudent());
                bt_sudentFrame.Content = "Existente";
            }

            fraStuNew = !fraStuNew;
        }
    }
}
