using System;
using System.Collections.Generic;
using System.IO;
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
using LayerData;
using LayerData.Objects;

namespace TheSkibiditecaApp.Windows {
    /// <summary>
    /// Lógica de interacción para Login.xaml
    /// </summary>
    public partial class Login : Page {
        public Login() {
            InitializeComponent();
            RandomProfile();
        }

        public void RandomProfile() {
            string[] images = ["AA.jpeg", "baca.jpeg", "caballo.jpg", "cangrejo.jpeg", "chad.png", "cocodrilo.jpeg", "dog_aur.jpeg", "flor.jpeg", "gato.png", "gatosandia.jpg", "gato_sorpr.jpeg", "girasol.png", "nerd_dog.jpg", "pato.jpeg", "pedrocraft.png", "peru.png", "rana.jpeg", "raul.jpeg", "slungus.png", "xina.png"];
            Random rnd = new();
            Uri pathIm = new($"../Images/Profiles/" + images[rnd.Next(images.Length)], UriKind.Relative);
            BitmapImage imgProf = new(pathIm);
            img_profile.Source = imgProf;
        }

        private void but_login_Click(object sender, RoutedEventArgs e) {
            string role = SkLogic.database.CheckLogin(tb_user.Text, pb_password.Password);
            if(string.IsNullOrEmpty(role)) MessageBox.Show("Usuario o contraseña incorrectos.");
            else {
                SkLogic.librarian = new Librarian() { 
                    LibID = -1, 
                    FirstName = tb_user.Text, 
                    LastName = "",
                    profilePhoto = img_profile.Source
                };
                MainWindow wind = (MainWindow)App.Current.MainWindow;
                wind.fra_main.Navigate(new BookManager());
            }
        }

        private void bt_updatePhoto_Click(object sender, RoutedEventArgs e) {
            RandomProfile();
        }
    }
}
