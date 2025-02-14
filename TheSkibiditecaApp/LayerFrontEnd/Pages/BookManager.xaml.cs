﻿using System;
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
using LayerData;
using LayerData.Objects;
using LayerFrontEnd.Pages;

namespace TheSkibiditecaApp.Windows {
    /// <summary>
    /// Lógica de interacción para BookManager.xaml
    /// </summary>
    public partial class BookManager : Page {
        private Librarian librarian = SkLogic.librarian!;
        public BookManager() {
            InitializeComponent();
            img_profile.Source = librarian.profilePhoto;
            lab_user.Content = librarian.FirstName;
            SkLogic.actualWind.Title = "Administrador";
            if(SkLogic.librarian!.Role != "Admin") {
                sp_buttons.Children.Remove(but_users);
                sp_buttons.Children.Remove(but_registro);
            }
            fra_actPage.Navigate(new BorrowList());
        }

        private void but_borrow_Click(object sender, RoutedEventArgs e) {
            fra_actPage.Navigate(new BorrowList());
        }

        private void but_newbook_Click(object sender, RoutedEventArgs e) {
            fra_actPage.Navigate(new RegisterBook());
        }

        private void but_users_Click(object sender, RoutedEventArgs e) {
            fra_actPage.Navigate(new UsersList());
        }

        private void but_registro_Click(object sender, RoutedEventArgs e) {
            fra_actPage.Navigate(new OperationsLog());
        }

        private void but_closeSesion_Click(object sender, RoutedEventArgs e) {
            MessageBoxResult mb = MessageBox.Show("¿Seguro que deseas cerrar sesión?", "Confirmar", MessageBoxButton.YesNo);
            if(mb == MessageBoxResult.No) return;
            SkLogic.librarian = null;
            NavigationService.Navigate(new Login());
        }

        private void but_credits_Click(object sender, RoutedEventArgs e) {
            fra_actPage.Navigate(new Credits());
        }
    }
}
