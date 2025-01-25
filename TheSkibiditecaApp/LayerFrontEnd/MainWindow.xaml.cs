using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using TheSkibiditecaApp.Windows;

namespace TheSkibiditecaApp {
    public partial class MainWindow : Window {
        public MainWindow() {
            InitializeComponent();
            this.Title = "Iniciar Sesión";
            Uri path = new(@"./Pages/Login.xaml", UriKind.Relative);
            fra_main.Source = path;
        }

        private void Window_Closed(object sender, EventArgs e) {
            Application.Current.Shutdown();
        }
    }
}