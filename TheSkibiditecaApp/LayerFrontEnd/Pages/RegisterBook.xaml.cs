using LayerFrontEnd.Controls.Components;
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
    /// Lógica de interacción para RegisterBook.xaml
    /// </summary>
    public partial class RegisterBook : Page {
        public bool fraAuthorNew = false;
        public bool fraPublNew = false;
        public RegisterBook() {
            InitializeComponent();
            fra_author.Navigate(new SelectAuthor());
            fra_publisher.Navigate(new SelectPublisher());
        }

        private void bt_authorFrame_Click(object sender, RoutedEventArgs e) {
            if(fraAuthorNew) {
                fra_author.Navigate(new SelectAuthor());
                bt_authorFrame.Content = "Nuevo";
            }else {
                fra_author.Navigate(new RegisterAuthor());
                bt_authorFrame.Content = "Existente";
            }

            fraAuthorNew = !fraAuthorNew;
        }

        private void bt_publisherFrame_Click(object sender, RoutedEventArgs e) {
            if(fraPublNew) {
                fra_publisher.Navigate(new SelectPublisher());
                bt_publisherFrame.Content = "Nuevo";
            } else {
                fra_publisher.Navigate(new RegisterPublisher());
                bt_publisherFrame.Content = "Existente";
            }

            fraPublNew = !fraPublNew;
        }
    }
}
