-- Usar Base de Datos Creada
USE TheSkibiditeca;
GO

------------------------------------------------
-- TABLA: Usuario
------------------------------------------------
CREATE TABLE [User] (
	UserID INT PRIMARY KEY IDENTITY,
	Username NVARCHAR(50) NOT NULL,
	PasswordHash VARBINARY(64) NOT NULL,
	[Role] NVARCHAR(10) NOT NULL DEFAULT 'Student'
		CHECK (Role IN ('Admin', 'Librarian', 'Student')) 
);
GO

------------------------------------------------
-- TABLA: Bibliotecario
------------------------------------------------
CREATE TABLE Librarian (
    LibrarianID INT PRIMARY KEY IDENTITY,
	UserID INT NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    [Address] NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(15) NOT NULL,
    [Shift] NVARCHAR(6) NOT NULL
        CHECK ([Shift] IN ('Mañana', 'Tarde', 'Noche')),
    EnrollmentDate DATE NOT NULL,
    [Status] NVARCHAR(10) NOT NULL
        CHECK ([Status] IN ('Activo', 'Retirado')),
	CONSTRAINT FK_User_Librarian
        FOREIGN KEY (UserID)
        REFERENCES [User](UserID)
        ON DELETE CASCADE
);
GO

------------------------------------------------
-- TABLA: Estudiante
------------------------------------------------
CREATE TABLE Student (
    StudentID INT PRIMARY KEY IDENTITY,
	UserID INT NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Gender CHAR(1) NOT NULL
        CHECK (Gender IN ('V', 'M')),
    Major NVARCHAR(50) NULL,
    Semester TINYINT NULL
        CHECK (Semester BETWEEN 1 AND 10),
	CONSTRAINT FK_User_Student
        FOREIGN KEY (UserID)
        REFERENCES [User](UserID)
        ON DELETE CASCADE
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
	Cover VARBINARY(MAX) NULL,
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
-- TABLA: Escrito
------------------------------------------------
CREATE TABLE Authored (
    BookID INT NOT NULL,
    AuthorID INT NOT NULL,
    PRIMARY KEY (BookID, AuthorID),
    CONSTRAINT FK_Authored_Book
        FOREIGN KEY (BookID)
        REFERENCES Book(BookID)
        ON DELETE CASCADE,
    CONSTRAINT FK_Authored_Author
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
    StudentID INT NOT NULL,
    BookID INT NOT NULL,
    BorrowDate DATE NOT NULL,
	BorrowStatus NVARCHAR(12) NOT NULL DEFAULT ('Por Devolver'),
    CONSTRAINT FK_Borrow_User
        FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID)
        ON DELETE CASCADE,
    CONSTRAINT FK_Borrow_Book
        FOREIGN KEY (BookID)
        REFERENCES Book(BookID)
        ON DELETE CASCADE,
	CONSTRAINT CK_Borrow_Status
		CHECK (BorrowStatus IN ('Por Devolver', 'Devuelto'))
);
GO

------------------------------------------------
-- TABLA: Devolucion
------------------------------------------------
CREATE TABLE [Return] (
    ReturnID INT PRIMARY KEY IDENTITY,
    BorrowID INT NOT NULL,
	BookState NVARCHAR(50) NOT NULL,
	Observation TEXT NULL,
    CONSTRAINT FK_Return_Borrow
        FOREIGN KEY (BorrowID)
        REFERENCES Borrow(BorrowID)
        ON DELETE CASCADE,
	CONSTRAINT CK_Book_State
        CHECK(BookState IN ('Bueno', 'Regular', 'Malo')),
);
GO

------------------------------------------------
-- TABLE: RegistroOperaciones
------------------------------------------------
CREATE TABLE OperationLog (
    LogID INT IDENTITY PRIMARY KEY,
    TableName NVARCHAR(50),
    Operation NVARCHAR(50),
    ChangeInfo NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO