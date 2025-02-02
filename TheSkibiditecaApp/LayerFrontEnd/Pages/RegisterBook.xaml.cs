using LayerData;
using LayerData.Objects;
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
using static System.Runtime.CompilerServices.RuntimeHelpers;

namespace LayerFrontEnd.Pages {
    /// <summary>
    /// Lógica de interacción para RegisterBook.xaml
    /// </summary>
    public partial class RegisterBook : Page {
        private bool fraAuthorNew = false;
        private bool fraPublNew = false;
        private SelectAuthor sa = new();
        private SelectPublisher sp = new();
        public RegisterBook() {
            InitializeComponent();
            fra_author.Navigate(sa);
            fra_publisher.Navigate(sp);
        }

        private void bt_authorFrame_Click(object sender, RoutedEventArgs e) {
            if(fraAuthorNew) {
                fra_author.Navigate(sa);
                bt_authorFrame.Content = "Nuevo";
            }else {
                RegisterAuthor ra = new();
                ra.Finished += (sender, e) => {
                    fra_author.Navigate(sa);
                    sa.UpdateDataSource();
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
                fra_publisher.Navigate(sp);
                bt_publisherFrame.Content = "Nuevo";
            } else {
                RegisterPublisher rp = new();
                rp.Finished += (sender, e) => {
                    fra_publisher.Navigate(sp);
                    sp.UpdateDataSource();
                    bt_publisherFrame.Content = "Nuevo";
                    fraPublNew = !fraPublNew;
                };
                fra_publisher.Navigate(rp);
                bt_publisherFrame.Content = "Existente";
            }

            fraPublNew = !fraPublNew;
        }

        private void bt_registerConfirm_Click(object sender, RoutedEventArgs e) {
            TextBox[] texboxes = { tb_yearBook, tb_pages, tb_genre, tb_yearISBN, tb_languaje, tb_title, sp.tb_pubInfo };
            foreach(TextBox texbox in texboxes) {
                if(texbox.Text == "") {
                    MessageBox.Show("Los campos no deben estar vacios");
                    return;
                }
            }

            try {
                int.Parse(tb_pages.Text);
            }catch {
                MessageBox.Show("La cantidad de páginas debe ser un número.");
                return;
            }

            Book b = new() {
                AgePub = tb_yearBook.Text,
                cantPages = int.Parse(tb_pages.Text),
                Genre = tb_genre.Text,
                ISBN = tb_yearISBN.Text,
                Languaje = tb_languaje.Text,
                Title = tb_title.Text,
                PublisherID = sp.tb_pubInfo.Text
            };

            string[] aIds = sa.tb_authorInfo.Text.Split(", ");
            try {
                SkLogic.database.RegisterBook(b, aIds);
                MessageBox.Show("Libro añadido correctamente.", "Éxito");
                NavigationService.Navigate(new RegisterBook());
            } catch(Exception ex) {
                MessageBox.Show(ex.Message, "Error");
            }
        }
    }
}
