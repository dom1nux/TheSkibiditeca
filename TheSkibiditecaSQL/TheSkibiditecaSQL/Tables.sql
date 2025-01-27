-- Usar Base de Datos Creada
USE TheSkibiditeca;
GO

------------------------------------------------
-- TABLA: Bibliotecario
------------------------------------------------
CREATE TABLE Librarian (
    LibrarianID INT PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Address NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(15) NOT NULL,
    [Shift] NVARCHAR(6) NOT NULL
        CHECK ([Shift] IN ('Mañana', 'Tarde', 'Noche')),
    EnrollmentDate DATE NOT NULL,
    [Status] NVARCHAR(10) NOT NULL
        CHECK ([Status] IN ('Activo', 'Retirado'))
);
GO

------------------------------------------------
-- TABLA: Usuario
------------------------------------------------
CREATE TABLE [User] (
    UserID INT PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Gender CHAR(1) NOT NULL
        CHECK (Gender IN ('V', 'M')),
    Major NVARCHAR(50) NULL,
    Semester TINYINT NULL
        CHECK (Semester BETWEEN 1 AND 10),
    RegisteredBy INT NULL,  -- FK referencing Librarian
    CONSTRAINT FK_Users_Librarian
        FOREIGN KEY (RegisteredBy)
        REFERENCES Librarian(LibrarianID)
        ON DELETE SET NULL
);
GO

------------------------------------------------
-- TABLA: Autor
------------------------------------------------
CREATE TABLE Author (
    AuthorID INT PRIMARY KEY IDENTITY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    BirthDate DATE NULL,
    Nationality NVARCHAR(100) NULL
);
GO

------------------------------------------------
-- TABLA: Editorial
------------------------------------------------
CREATE TABLE Publisher (
    PublisherID INT PRIMARY KEY IDENTITY,
    [Name] NVARCHAR(255) NOT NULL,
    [Address] NVARCHAR(255) NULL,
    PhoneNumber NVARCHAR(15) NULL,
    Email NVARCHAR(255) NULL
);
GO

------------------------------------------------
-- TABLA: Genero
------------------------------------------------
CREATE TABLE Genre (
    GenreID INT PRIMARY KEY IDENTITY,
    Name NVARCHAR(100) NOT NULL
);
GO

------------------------------------------------
-- TABLA: Libro
------------------------------------------------
CREATE TABLE Book (
    BookID INT PRIMARY KEY IDENTITY,
    Title NVARCHAR(255) NOT NULL,
    PublicationYear INT NOT NULL
        CHECK (PublicationYear > 0),
    GenreID INT NULL,
    ISBN CHAR(13) NOT NULL UNIQUE,
    PublisherID INT NULL,
    Pages INT NOT NULL
        CHECK (Pages > 0),
    [Language] NVARCHAR(50) NULL,
    CONSTRAINT FK_Book_Genre
        FOREIGN KEY (GenreID)
        REFERENCES Genre(GenreID)
        ON DELETE SET NULL,
    CONSTRAINT FK_Book_Publisher
        FOREIGN KEY (PublisherID)
        REFERENCES Publisher(PublisherID)
        ON DELETE SET NULL
);
GO

------------------------------------------------
-- TABLA: ListaLibro
------------------------------------------------
CREATE TABLE BookList (
    BookID INT NOT NULL,
    AuthorID INT NOT NULL,
    PRIMARY KEY (BookID, AuthorID),
    CONSTRAINT FK_BookList_Book
        FOREIGN KEY (BookID)
        REFERENCES Book(BookID)
        ON DELETE CASCADE,
    CONSTRAINT FK_BookList_Author
        FOREIGN KEY (AuthorID)
        REFERENCES Author(AuthorID)
        ON DELETE CASCADE
);
GO

------------------------------------------------
-- TABLA: Prestamo
------------------------------------------------
CREATE TABLE Borrow (
    BorrowID INT PRIMARY KEY IDENTITY,
    UserID INT NOT NULL,
    BookID INT NOT NULL,
    BorrowDate DATE NOT NULL,
    LibrarianID INT NULL,
    CONSTRAINT FK_Borrow_User
        FOREIGN KEY (UserID)
        REFERENCES [User](UserID)
        ON DELETE CASCADE,
    CONSTRAINT FK_Borrow_Book
        FOREIGN KEY (BookID)
        REFERENCES Book(BookID)
        ON DELETE CASCADE,
    CONSTRAINT FK_Borrow_Librarian
        FOREIGN KEY (LibrarianID)
        REFERENCES Librarian(LibrarianID)
        ON DELETE SET NULL
);
GO

------------------------------------------------
-- TABLA: Devolucion
------------------------------------------------
CREATE TABLE [Return] (
    ReturnID INT PRIMARY KEY IDENTITY,
    BorrowID INT NOT NULL,
    ReturnDate DATE NOT NULL,
    LibrarianID INT NOT NULL,
    CONSTRAINT FK_Return_Borrow
        FOREIGN KEY (BorrowID)
        REFERENCES Borrow(BorrowID)
        ON DELETE CASCADE,
    CONSTRAINT FK_Return_Librarian
        FOREIGN KEY (LibrarianID)
        REFERENCES Librarian(LibrarianID)
);
GO

-- Agregamos campo de "estado" a la tabla libro
ALTER TABLE Book
ADD [Status] NVARCHAR(10) NOT NULL
    CONSTRAINT DF_Book_Status DEFAULT ('Available');
GO

-- Agregamos verificacion al campo "estado" de la tabla libro
ALTER TABLE Book
ADD CONSTRAINT CK_Book_Status
CHECK ([Status] IN ('Available', 'Borrowed'));
GO