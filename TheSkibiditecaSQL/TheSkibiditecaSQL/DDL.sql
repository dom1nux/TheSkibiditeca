-- Descartar base de datos si existe
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'TheSkibiditeca')
BEGIN
    USE master;
    ALTER DATABASE TheSkibiditeca SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TheSkibiditeca;
END
GO

-- Crear base de datos
CREATE DATABASE TheSkibiditeca;
GO

-- Usar base de datos
USE TheSkibiditeca;
GO

-- Tabla Bibliotecario
CREATE TABLE Librarian (
    librarianID INT PRIMARY KEY IDENTITY, -- ID bibliotecario
    firstName NVARCHAR(100) NOT NULL, -- Nombres
    lastName NVARCHAR(100) NOT NULL, -- Apellidos
	[address] NVARCHAR(255) NOT NULL, -- Direccion del bibliotecario
	phoneNumber CHAR(9) NOT NULL, -- Telefono del bibliotecario
    [shift] NVARCHAR(6) CHECK ([shift] IN ('Mañana', 'Tarde', 'Noche')) NOT NULL, -- Turno bibliotecario
    enrollmentDate DATE NOT NULL, -- Fecha de contratacion del bibliotecario
    [status] NVARCHAR(10) CHECK ([status] IN ('Activo', 'Retirado')) NOT NULL -- Estado del bibliotecario
);
GO

-- Tabla Usuario
CREATE TABLE [User] (
    userID INT PRIMARY KEY IDENTITY, -- ID usuario
    firstName NVARCHAR(100) NOT NULL, -- Nombres
    lastName NVARCHAR(100) NOT NULL, -- Apellidos
    gender CHAR(1) CHECK (gender IN ('V', 'M')) NOT NULL, -- Sexo del usuario (V para varones y M para mujeres)
    major NVARCHAR(50), -- Carrera del usuario
    semester TINYINT CHECK (semester BETWEEN 1 AND 10), -- Ciclo del usuario (entre 1 a 10)
    registeredBy INT, -- Clave foranea al Bibliotecario
    FOREIGN KEY (registeredBy) REFERENCES Librarian(librarianID) ON DELETE SET NULL -- Restriccion de clave foranea
);
GO

-- Tabla Autor
CREATE TABLE Author (
    authorID INT PRIMARY KEY IDENTITY, -- ID autor
    firstName NVARCHAR(100) NOT NULL, -- Nombres
    lastName NVARCHAR(100) NOT NULL, -- Apellidos
    birthDate DATE, -- Facha nacimiento del autor
    nationality NVARCHAR(100) -- Nacionalidad del autor
);
GO

-- Tabla Editorial
CREATE TABLE Publisher (
    publisherID INT PRIMARY KEY IDENTITY, -- ID de la Editorial
    [name] NVARCHAR(255) NOT NULL, -- Razon social de la editorial
    [address] NVARCHAR(255), -- Direccion de la editorial
    phoneNumber NVARCHAR(15), -- Numero de telefono de la editorial
	email NVARCHAR(255) -- Correo de la editorial
);
GO

-- Tabla Genero
CREATE TABLE Genre (
    genreID INT PRIMARY KEY IDENTITY, -- ID del genero de un libro
    [name] NVARCHAR(100) NOT NULL -- Nombre del genero
);
GO

-- Tabla Libro
CREATE TABLE Book (
    bookID INT PRIMARY KEY IDENTITY, -- ID del libro
    title NVARCHAR(255) NOT NULL, -- Titulo del libro
    publicationYear INT CHECK (publicationYear > 0), -- Año de publicacion del libro
    genreID INT, -- FK a la tabla Genero
    isbn CHAR(13) UNIQUE NOT NULL, -- Código ISBN
    publisherID INT, -- FK a la tabla editorial
    pages INT CHECK (pages > 0), -- Numero del páginas del libro
    [language] NVARCHAR(50), -- Idioma del libro
    FOREIGN KEY (genreID) REFERENCES Genre(genreID) ON DELETE SET NULL, -- Restriccion de clave forane a la tabla Genero
    FOREIGN KEY (publisherID) REFERENCES Publisher(publisherID) ON DELETE SET NULL -- Restriccion de clave forane a la tabla Editorial
);
GO

-- Tabla ListaLibros
CREATE TABLE BookList (
    bookID INT NOT NULL, -- Clave foranea a la tabla Libro
    authorID INT NOT NULL, -- Clave foranea a la tabla Autor
    PRIMARY KEY (bookID, authorID), -- Clave primaria compuesta por las FK de Autor y Libro
    FOREIGN KEY (bookID) REFERENCES Book(bookID) ON DELETE CASCADE, -- Restriccion de clave forane a la tabla Libro
    FOREIGN KEY (authorID) REFERENCES Author(authorID) ON DELETE CASCADE -- Restriccion de clave forane a la tabla Autor
);
GO

-- Tabla Prestamo
CREATE TABLE Borrow (
    borrowID INT PRIMARY KEY IDENTITY, -- ID de un prestamo
    userID INT NOT NULL, -- Clave foranea a la tabla Usuario
    bookID INT NOT NULL, -- Clave foranea a la tabla Libro
    borrowDate DATE NOT NULL, -- Fecha de prestamo del libro
    librarianID INT, -- Clave foranea a la tabla Bibliotecario
    FOREIGN KEY (userID) REFERENCES [User](userID) ON DELETE CASCADE, -- Restriccion de clave foranea a la tabla Usuario
    FOREIGN KEY (bookID) REFERENCES Book(bookID) ON DELETE CASCADE, -- Restriccion de clave foranea a la tabla Libro
    FOREIGN KEY (librarianID) REFERENCES Librarian(librarianID) ON DELETE SET NULL -- Restriccion de clave foranea a la tabla Bibliotecario
);
GO

-- Tabla Devolucion
CREATE TABLE [Return] (
    returnID INT PRIMARY KEY IDENTITY, -- ID una devolucion
    borrowID INT NOT NULL, -- Clave foranea a la tabla Prestamo
    returnDate DATE NOT NULL, --  Fecha de devolucion del libro
    librarianID INT NOT NULL, -- lave foranea a la tabla Bibliotecario
    FOREIGN KEY (borrowID) REFERENCES Borrow(borrowID) ON DELETE CASCADE, -- Restriccion de clave foranea a la tabla Prestamo
    FOREIGN KEY (librarianID) REFERENCES Librarian(librarianID) -- Restriccion de clave forane a la tabla Bibliotecario
);
GO