USE TheSkibiditeca;
GO

-- ================================================
-- Vistas para prestamos con devoluci�n pendiente
-- ================================================
CREATE OR ALTER VIEW vwPendingBorrows AS
SELECT
    bk.Title AS 'T�tulo',
    s.FirstName + ' ' + s.LastName AS 'Estudiante',
    b.BorrowDate AS 'Fecha de Prestamo',
    b.BorrowStatus AS 'Estado del Prestamo'
FROM Borrow b
JOIN Book bk ON b.BookID = bk.BookID
JOIN Student s ON b.StudentID = s.StudentID
WHERE b.BorrowStatus = 'Por Devolver';
GO

-- =================================================
-- Vistas para prestamos con devoluci�n completada
-- =================================================
CREATE OR ALTER VIEW vwReturnedBorrows AS
SELECT
    bk.Title AS 'T�tulo',
    s.FirstName + ' ' + s.LastName AS 'Estudiante',
    b.BorrowDate AS 'Fecha de Prestamo',
    b.BorrowStatus AS 'Estado de Prestamo'
FROM Borrow b
JOIN Book bk ON b.BookID = bk.BookID
JOIN Student s ON b.StudentID = s.StudentID
WHERE b.BorrowStatus = 'Devuelto';
GO

-- =====================================================
-- Vista para prestamos con devoluci�n fuera de tiempo
-- =====================================================
CREATE OR ALTER VIEW vwOverdueBorrows AS
SELECT
    bk.Title AS 'T�tulo',
    s.FirstName + ' ' + s.LastName AS 'Estudiante',
    b.BorrowDate AS 'Fecha de Prestamo',
    DATEADD(DAY, 30, b.BorrowDate) AS 'D�as Atrasados',
    b.BorrowStatus AS 'Estado de Prestamo'
FROM Borrow b
JOIN Book bk ON b.BookID = bk.BookID
JOIN Student s ON b.StudentID = s.StudentID
WHERE b.BorrowStatus = 'Por Devolver'
  AND DATEADD(DAY, 30, b.BorrowDate) < GETDATE(); -- Modificar fecha maxima de prestamo
GO

-- ================================
-- Vista para todos los prestamos
-- ================================
CREATE OR ALTER VIEW vwAllBorrows AS
SELECT * FROM vwPendingBorrows
UNION ALL
SELECT * FROM vwReturnedBorrows;
GO

SELECT *
FROM vwBorrowedBooks;
GO

-- ===============================================
-- Vista de historial de prestamo de estudiantes
-- ===============================================
CREATE OR ALTER VIEW vwStudentBorrowHistory AS
SELECT 
    s.StudentID AS 'ID',
    s.FirstName + ' ' + s.LastName AS 'Estudiante',
    bk.Title AS 'T�tulo',
    bk.ISBN AS 'ISBN',
    b.BorrowDate AS 'Fecha de Prestamo',
    CASE 
        WHEN rt.ReturnDate IS NULL THEN 'Pendiente'
        ELSE CONVERT(VARCHAR(10), rt.ReturnDate, 103)  -- dd/mm/yyyy format
    END AS 'Fecha de devoluci�n'
FROM Student s
JOIN Borrow b ON s.StudentID = b.StudentID
JOIN Book bk ON b.BookID = bk.BookID
LEFT JOIN [Return] rt ON b.BorrowID = rt.BorrowID;
GO

-- ============================
-- Vista de detalle de libros
-- ============================
CREATE OR ALTER VIEW vwBookDetails AS
SELECT 
    b.Title AS 'T�tulo',
    b.PublicationYear AS 'A�o de Publicaci�n',
    b.ISBN,
    b.Pages AS 'P�ginas',
    b.[Language] AS 'Idioma',
    p.[Name] AS 'Editorial',
    STRING_AGG(CONCAT(a.FirstName, ' ', a.LastName), ', ') AS 'Autores'
FROM Book b
LEFT JOIN Publisher p ON b.PublisherID = p.PublisherID
LEFT JOIN Authored au ON b.BookID = au.BookID
LEFT JOIN Author a ON au.AuthorID = a.AuthorID
GROUP BY 
    b.Title,
    b.PublicationYear,
    b.ISBN,
    b.Pages,
    b.[Language],
    p.[Name],
    b.PublisherID;
GO

-- ==================================
-- Vista de registro de operaciones
-- ==================================
CREATE OR ALTER VIEW vwOperationLog AS
SELECT 
    LogID AS 'ID',
    TableName AS 'Tabla',
    Operation AS 'Operacion ',
    ChangeInfo AS 'Informaci�n de Cambios',
    CreatedAt AS 'Fecha'
FROM OperationLog;
GO

-- ===========================
-- Vista para bibliotecarios
-- ===========================
CREATE OR ALTER VIEW vwLibrarianInfo AS
SELECT 
    --l.LibrarianID,
    --l.UserID,
    u.Username AS 'Usuario',
    l.FirstName AS 'Nombre',
    l.LastName AS 'Apellidos',
    l.Address AS 'Direcci�n',
    l.PhoneNumber AS 'Celular', 
    l.[Shift] AS 'Turno',
    CONVERT(VARCHAR(8), l.EnrollmentDate, 3) AS 'Fecha de Ingreso',            
    l.[Status] AS 'Estado de Empleo'
FROM Librarian l
JOIN [User] u ON l.UserID = u.UserID;
GO

-- ========================
-- Vista para estudiantes
-- ========================
CREATE OR ALTER VIEW vwStudentInfo AS
SELECT 
    s.StudentID AS 'ID',
    --u.Username,
    s.FirstName AS 'Nombre',
    s.LastName AS 'Apellidos',
    s.Gender AS 'Sexo',
    s.Major AS 'Carrera'
FROM Student s
LEFT JOIN [User] u ON s.UserID = u.UserID;
GO

-- ====================
-- Vista para autores
-- ====================
CREATE OR ALTER VIEW vwAuthorInfo AS
SELECT 
    FirstName + ' ' + LastName AS 'Nombre del Autor'
FROM Author;
GO

-- ====================
-- Vista para autores
-- ====================
CREATE OR ALTER VIEW vwPublisherInfo AS
SELECT 
    PublisherID,
    -- Combine Name, Address, PhoneNumber, and Email. 
    [Name] +
      ISNULL(', Email: ' + Email, '') AS 'Detalles de Editorial'
FROM Publisher;
GO