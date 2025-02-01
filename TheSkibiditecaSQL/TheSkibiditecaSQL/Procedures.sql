USE TheSkibiditeca;
GO

-- =============================================
-- Descripción: Autentica a un usuario verificando 
--              si sus credenciales estan presentes
--              en la tabla Usuario (User) y retorna
--              el rol correspondiente
-- =============================================
CREATE OR ALTER PROCEDURE spAuthenticateUser
    @Username NVARCHAR(50),
    @Password NVARCHAR(255),
    @ReturnCode INT OUTPUT,
    @Message NVARCHAR(255) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Declaramos las variables que contienen la información
        DECLARE @StoredPasswordHash VARBINARY(64);
        DECLARE @Role NVARCHAR(15);
        DECLARE @InputPasswordHash VARBINARY(64);

        -- Recuperamos el hash de la contraseña y rol del usuario
        SELECT 
            @StoredPasswordHash = PasswordHash,
            @Role = [Role]
        FROM [User]
        WHERE Username = @Username;

        -- Verificamos si el rol existe
        IF @StoredPasswordHash IS NULL
        BEGIN
            SET @ReturnCode = 1;
            SET @Message = 'Autenticación Fallida: Nombre de usuario o contraseña invalidos.';
            RETURN;
        END

        -- Calculamos el hash de la contraseña ingresada
        SET @InputPasswordHash = HASHBYTES('SHA2_512', @Password);

        -- Se compara los hash de l contraseña ingresada y de la contrase�a almacenada
        IF @InputPasswordHash = @StoredPasswordHash
        BEGIN
            SET @ReturnCode = 0;
            SET @Message = 'Autenticación exitosa.';

            -- Optional: Return user details if needed
            SELECT 
                UserID,
                Username,
                [Role]
            FROM [User]
            WHERE Username = @Username;
        END
        ELSE
        BEGIN
            SET @ReturnCode = 1;
            SET @Message = 'Autenticación Fallida: Nombre de usuario o contraseña invalidos.';
        END
    END TRY
    BEGIN CATCH
        -- Manejo de errores no esperados
        SET @ReturnCode = -1;
        SET @Message = ERROR_MESSAGE();
    END CATCH
END;
GO

-- ====================================
-- Descripción: Registra a un usuario
-- ====================================
CREATE OR ALTER PROCEDURE spRegisterUser
	@Username NVARCHAR(50),
	@Password NVARCHAR(255),
	@Role NVARCHAR(10),
	@FirstName NVARCHAR(100),
	@LastName NVARCHAR(100),
	@Address NVARCHAR(255),
	@PhoneNumber NVARCHAR(15),
	@Shift NVARCHAR(9)
AS
BEGIN
	DECLARE @PasswordHash VARBINARY(64);
	DECLARE @UserID INT;

	SET @PasswordHash = HASHBYTES('SHA2_512', @Password);
	INSERT INTO [User]
		(Username, PasswordHash, [Role])
	VALUES
		(@Username, @PasswordHash, @Role);

	SET @UserID = (
		SELECT UserID
		FROM [User]
		WHERE Username = @Username);
	INSERT INTO Librarian
		(UserID, FirstName, LastName, [Address], PhoneNumber, [Shift], EnrollmentDate, [Status])
	VALUES
		(@UserID, @FirstName, @LastName, @Address, @PhoneNumber, @Shift, GETDATE(), 'Activo')
END;
GO

-- =============================================================================
-- Descripción: Procesa los prestamos de libros en la tabla prestamos (Borrow) 
-- =============================================================================
CREATE OR ALTER PROCEDURE spProcessLending
    @StudentID INT,
    @BookID INT,
    @BorrowDate DATE = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    IF @BorrowDate IS NULL
        SET @BorrowDate = GETDATE();

    BEGIN TRY
        BEGIN TRANSACTION;
        
        INSERT INTO Borrow (StudentID, BookID, BorrowDate, BorrowStatus)
        VALUES (@StudentID, @BookID, @BorrowDate, 'Por Devolver');
        
        DECLARE @NewBorrowID INT = SCOPE_IDENTITY();
        
        COMMIT TRANSACTION;
        
        SELECT @NewBorrowID AS BorrowID;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO

-- =============================================================================
-- Descripción: Procesa los retornos de libros en la tabla devolucion (Return) 
--              previamente registrados en la tabla prestamos (Borrow).
-- =============================================================================
CREATE OR ALTER PROCEDURE spProcessReturn
    @BorrowID INT
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        IF NOT EXISTS (
            SELECT 1 
            FROM Borrow 
            WHERE BorrowID = @BorrowID 
              AND BorrowStatus = 'Por Devolver'
        )
        BEGIN
            RAISERROR('Borrow record not found or already processed.', 16, 1);
            ROLLBACK TRANSACTION;
            RETURN;
        END;
        
        INSERT INTO [Return](BorrowID, ReturnDate)
        VALUES (@BorrowID, GETDATE());
        
        UPDATE Borrow
        SET BorrowStatus = 'Devuelto'
        WHERE BorrowID = @BorrowID;
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        DECLARE @ErrorMessage NVARCHAR(MAX) = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
    END CATCH
END;
GO
