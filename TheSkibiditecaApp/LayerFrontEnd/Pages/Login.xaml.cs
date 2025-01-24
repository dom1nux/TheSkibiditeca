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

namespace TheSkibiditecaApp.Windows {
    /// <summary>
    /// Lógica de interacción para Login.xaml
    /// </summary>
    public partial class Login : Page {
        public Window parentWindow;
        public Login(Window parent) {
            InitializeComponent();
            RandomProfile();
            this.parentWindow = parent;
        }

        public void RandomProfile() {
            string[] images = { "pedrocraft.png", "girasol.png", "chad.png", "xina.png", "peru.png" };
            Random rnd = new();
            Uri pathIm = new($"../Images/" + images[rnd.Next(images.Length)], UriKind.Relative);
            BitmapImage imgProf = new(pathIm);
            img_profile.Source = imgProf;
        }

        private void but_login_Click(object sender, RoutedEventArgs e) {
            parentWindow.Content = new BookManager().Content;
            parentWindow.Title = "Administrador";
        }
    }
}
