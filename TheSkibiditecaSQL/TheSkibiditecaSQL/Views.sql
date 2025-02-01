USE TheSkibiditeca;
GO

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

CREATE OR ALTER VIEW vwReturnedBorrows AS
SELECT 
    b.BorrowID,
    bk.Title,
    s.FirstName + ' ' + s.LastName AS StudentName,
    b.BorrowDate,
    b.BorrowStatus
FROM Borrow b
JOIN Book bk ON b.BookID = bk.BookID
JOIN Student s ON b.StudentID = s.StudentID
WHERE b.BorrowStatus = 'Devuelto';
GO

CREATE OR ALTER VIEW vwAllBorrows AS
SELECT * FROM vwPendingBorrows
UNION ALL
SELECT * FROM vwReturnedBorrows;
GO

SELECT *
FROM vwBorrowedBooks;
GO