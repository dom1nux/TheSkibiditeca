using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Media;

namespace LayerData.Objects {
    public class Librarian {
        public int LibID;
        public required string FirstName;
        public required string LastName;
        public required string Role;
        public required string Shift;
        public required string Address;
        public required string Phone;
        public ImageSource? profilePhoto;
    }
}
