USE TheSkibiditeca;
GO

-- Trigger para registrar prestamo de un libro
CREATE OR ALTER TRIGGER trg_LogLending
ON Borrow
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO OperationLog (TableName, Operation, ChangeInfo)
    SELECT 
        'Borrow' AS TableName,
        'Lend Book' AS Operation,
        CONCAT('Lending operation for BorrowID: ', CAST(BorrowID AS NVARCHAR(20))) AS ChangeInfo
    FROM inserted;
END;
GO

-- Trigger para registar la devolución de un libro
CREATE OR ALTER TRIGGER trg_LogReturn
ON [Return]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO OperationLog (TableName, Operation, ChangeInfo)
    SELECT 
        'Return' AS TableName,
        'Return Book' AS Operation,
        CONCAT('Return operation for BorrowID: ', CAST(BorrowID AS NVARCHAR(20))) AS ChangeInfo
    FROM inserted;
END;
GO

-- Trigger para registar la adición de un usuario nuevo en el sistema
CREATE OR ALTER TRIGGER trg_LogUserInsert
ON [User]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO OperationLog (TableName, Operation, ChangeInfo)
    SELECT 
        '[User]' AS TableName,
        'Add User' AS Operation,
        CONCAT('New user added with UserID: ', CAST(UserID AS NVARCHAR(20))) AS ChangeInfo
    FROM inserted;
END;
GO

-- Trigger para registrar la addición de un libro en el sistema
CREATE OR ALTER TRIGGER trg_LogBookInsert
ON Book
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO OperationLog (TableName, Operation, ChangeInfo)
    SELECT 
        'Book' AS TableName,
        'Add Book' AS Operation,
        CONCAT('New book added with BookID: ', CAST(BookID AS NVARCHAR(20))) AS ChangeInfo
    FROM inserted;
END;
GO