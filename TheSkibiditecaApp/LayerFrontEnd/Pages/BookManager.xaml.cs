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

namespace TheSkibiditecaApp.Windows {
    /// <summary>
    /// Lógica de interacción para BookManager.xaml
    /// </summary>
    public partial class BookManager : Page {
        public BookManager() {
            InitializeComponent();
        }

        private void but_borrow_Click(object sender, RoutedEventArgs e) {
            Uri path = new(@"./BorrowList.xaml", UriKind.Relative);
            fra_actPage.Source = path;
        }

        private void but_newbook_Click(object sender, RoutedEventArgs e) {
            Uri path = new(@"./RegisterBook.xaml", UriKind.Relative);
            fra_actPage.Source = path;
        }
    }
}
