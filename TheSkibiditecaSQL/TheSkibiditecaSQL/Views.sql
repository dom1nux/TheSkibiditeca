USE TheSkibiditeca;
GO

-- ================================================
-- Vistas para prestamos con devolución pendiente
-- ================================================
CREATE OR ALTER VIEW vwPendingBorrows AS
SELECT 
    b.BorrowID,
    bk.Title,
    s.FirstName + ' ' + s.LastName AS StudentName,
    b.BorrowDate,
    b.BorrowStatus
FROM Borrow b
JOIN Book bk ON b.BookID = bk.BookID
JOIN Student s ON b.StudentID = s.StudentID
WHERE b.BorrowStatus = 'Por Devolver';
GO

-- =================================================
-- Vistas para prestamos con devolución completada
-- =================================================
CREATE OR ALTER VIEW vwReturnedBorrows AS
SELECT 
    b.BorrowID,
    bk.Title,
    s.FirstName + ' ' + s.LastName AS 'Student Name',
    b.BorrowDate,
    b.BorrowStatus
FROM Borrow b
JOIN Book bk ON b.BookID = bk.BookID
JOIN Student s ON b.StudentID = s.StudentID
WHERE b.BorrowStatus = 'Devuelto';
GO

-- =====================================================
-- Vista para prestamos con devolución fuera de tiempo
-- =====================================================
CREATE OR ALTER VIEW vwOverdueBorrows AS
SELECT 
    b.BorrowID,
    bk.Title,
    s.FirstName + ' ' + s.LastName AS StudentName,
    b.BorrowDate,
    DATEADD(DAY, 30, b.BorrowDate) AS DueDate,
    b.BorrowStatus
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
    s.StudentID,
    s.FirstName + ' ' + s.LastName AS StudentName,
    b.BorrowID,
    bk.Title,
    b.BorrowDate,
    b.BorrowStatus
FROM Student s
JOIN Borrow b ON s.StudentID = b.StudentID
JOIN Book bk ON b.BookID = bk.BookID;
GO

-- ============================
-- Vista de detalle de libros
-- ============================
CREATE OR ALTER VIEW vwBookDetails AS
SELECT 
    b.BookID,
    b.Title,
    b.PublicationYear,
    b.ISBN,
    b.Pages,
    b.[Language],
    b.PublisherID,
    STRING_AGG(CONCAT(a.FirstName, ' ', a.LastName), ', ') AS Authors
FROM Book b
LEFT JOIN Authored au ON b.BookID = au.BookID
LEFT JOIN Author a ON au.AuthorID = a.AuthorID
GROUP BY 
    b.BookID,
    b.Title,
    b.PublicationYear,
    b.ISBN,
    b.Pages,
    b.[Language],
    b.PublisherID;
GO

-- ==================================
-- Vista de registro de operaciones
-- ==================================
CREATE OR ALTER VIEW vwOperationLog AS
SELECT 
    LogID,
    TableName,
    Operation,
    ChangeInfo,
    CreatedAt
FROM OperationLog;
GO

-- ===========================
-- Vista para bibliotecarios
-- ===========================
CREATE OR ALTER VIEW vwLibrarians AS
SELECT 
    l.LibrarianID,
    l.UserID,
    u.Username,
    l.FirstName,
    l.LastName,
    l.Address,
    l.PhoneNumber, 
    l.[Shift],
    l.EnrollmentDate,            
    l.[Status]                   
FROM Librarian l
JOIN [User] u ON l.UserID = u.UserID;
GO

-- ========================
-- Vista para estudiantes
-- ========================
CREATE OR ALTER VIEW vwStudents AS
SELECT 
    s.StudentID,
    s.UserID,
    u.Username,
    s.FirstName,
    s.LastName,
    s.Gender,
    s.Major
FROM Student s
LEFT JOIN [User] u ON s.UserID = u.UserID;
GO