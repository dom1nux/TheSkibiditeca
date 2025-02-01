USE TheSkibiditeca;
GO

-- =============================================
-- Descripci�n: Autentica a un usuario verificando 
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
        -- Declaramos las variables que contienen la informaci�n
        DECLARE @StoredPasswordHash VARBINARY(64);
        DECLARE @Role NVARCHAR(15);
        DECLARE @InputPasswordHash VARBINARY(64);

        -- Recuperamos el hash de la contrase�a y rol del usuario
        SELECT 
            @StoredPasswordHash = PasswordHash,
            @Role = [Role]
        FROM [User]
        WHERE Username = @Username;

        -- Verificamos si el rol existe
        IF @StoredPasswordHash IS NULL
        BEGIN
            SET @ReturnCode = 1;
            SET @Message = 'Autenticaci�n Fallida: Nombre de usuario o contrase�a invalidos.';
            RETURN;
        END

        -- Calculamos el hash de la contrase�a ingresada
        SET @InputPasswordHash = HASHBYTES('SHA2_512', @Password);

        -- Se compara los hash de l contrase�a ingresada y de la contrase�a almacenada
        IF @InputPasswordHash = @StoredPasswordHash
        BEGIN
            SET @ReturnCode = 0;
            SET @Message = 'Autenticaci�n exitosa.';

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
            SET @Message = 'Autenticaci�n Fallida: Nombre de usuario o contrase�a invalidos.';
        END
    END TRY
    BEGIN CATCH
        -- Manejo de errores no esperados
        SET @ReturnCode = -1;
        SET @Message = ERROR_MESSAGE();
    END CATCH
END;
GO

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

	SET @PasswordHash = HASHBYTES('SHA_512', @Password);
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

-- =============================================
-- Descripci�n: Registra un usuario pe 
-- =============================================
CREATE OR ALTER PROCEDURE spRegisterUser
    @Username NVARCHAR(50),
    @Password NVARCHAR(255),
    @Role NVARCHAR(10),
    @FirstName NVARCHAR(100),
    @LastName NVARCHAR(100),
    @Adress NVARCHAR(255),
    @PhoneNumber NVARCHAR(15),
    @Shift NVARCHAR(6)
AS
BEGIN
    DECLARE @PasswordHash VARBINARY(64);
    DECLARE @UserID INT;

    SET @PasswordHash = HASHBYTES('SHA2_512', @Password);
    INSERT INTO [User] (Username, PasswordHash, [Role])
    VALUES (@Username, @PassWordHash, @Role);

    SET @UserID = (SELECT UserID FROM [User] WHERE Username = @Username);
    INSERT INTO Librarian (UserID, FirstName, LastName, [Address], PhoneNumber, [Shift], EnrollmentDate, [Status])
    VALUES (@UserID, @FirstName, @LastName, @Adress, @PhoneNumber, @Shift, GETDATE(), 'Activo')
END;

-- =============================================
-- Descripci�n: Crea el login y usuario para la aplicacion
--              y establece los permisos correspondientes.
-- =============================================
CREATE LOGIN AppLogin
WITH PASSWORD = 'YourSecurePassword!123';
GO

CREATE USER AppUser
FOR LOGIN AppLogin;
GO

DENY SELECT, INSERT, UPDATE, DELETE ON SCHEMA :: dbo TO AppUser;
GO

GRANT EXECUTE ON OBJECT::spAuthenticateUser TO AppUser;
GRANT EXECUTE ON OBJECT::spRegisterUser TO AppUser;
GO

-- =============================================
-- Descripci�n: Usuario de prueba para probar la autenticacion
-- =============================================
DECLARE @Username NVARCHAR(50) = 'defaultUser';
DECLARE @Password NVARCHAR(255) = 'Test@1234';
DECLARE @Role NVARCHAR(15) = 'Admin';

DECLARE @PasswordHash VARBINARY(64);
SET @PasswordHash = HASHBYTES('SHA2_512', @Password);

INSERT INTO [User] (Username, PasswordHash, [Role])
VALUES (@Username, @PasswordHash, @Role);
