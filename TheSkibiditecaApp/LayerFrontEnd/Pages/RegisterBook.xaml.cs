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
        private bool fraAuthorNew = false;
        private bool fraPublNew = false;
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
                RegisterAuthor ra = new();
                ra.Finished += (sender, e) => {
                    fra_author.Navigate(new SelectAuthor());
                    bt_authorFrame.Content = "Nuevo";
                    fraAuthorNew = !fraAuthorNew;
                };
                fra_author.Navigate(ra);
                bt_authorFrame.Content = "Existente";
            }

            fraAuthorNew = !fraAuthorNew;
        }

        private void bt_publisherFrame_Click(object sender, RoutedEventArgs e) {
            if(fraPublNew) {
                fra_publisher.Navigate(new SelectPublisher());
                bt_publisherFrame.Content = "Nuevo";
            } else {
                RegisterPublisher rp = new();
                rp.Finished += (sender, e) => {
                    fra_publisher.Navigate(new SelectPublisher());
                    bt_publisherFrame.Content = "Nuevo";
                    fraPublNew = !fraPublNew;
                };
                fra_publisher.Navigate(rp);
                bt_publisherFrame.Content = "Existente";
            }

            fraPublNew = !fraPublNew;
        }
    }
}
