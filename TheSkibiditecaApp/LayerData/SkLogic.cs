
using LayerData.Database;
using LayerData.Objects;
using System.Windows;
using System.Windows.Media;

namespace LayerData {
    public static class SkLogic {
        public static DBConnection database = new DBConnection();
        public static Librarian? librarian;
        public static Window actualWind = Application.Current.MainWindow;
    }
}
