USE TheSkibiditeca;
GO

-- =============================================
-- Descripción: Autentica a un usuario verificando 
--              si sus credenciales estan presentes
--              en la tabla Usuario (User) y retorna
--              el rol correspondiente
-- =============================================
CREATE PROCEDURE spAuthenticateUser
    @Username NVARCHAR(50),
    @Password NVARCHAR(255),
    @ReturnCode INT OUTPUT,    -- 0 for success, non-zero for errors
    @Message NVARCHAR(255) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Declare variables to hold retrieved data
        DECLARE @StoredPasswordHash VARBINARY(64);
        DECLARE @Role NVARCHAR(15);
        DECLARE @InputPasswordHash VARBINARY(64);

        -- Retrieve the stored password hash and role for the given username
        SELECT 
            @StoredPasswordHash = PasswordHash,
            @Role = [Role]
        FROM [User]
        WHERE Username = @Username;

        -- Check if the user exists
        IF @StoredPasswordHash IS NULL
        BEGIN
            -- Authentication failed: User does not exist
            SET @ReturnCode = 1;    -- Error Code 1: User not found
            SET @Message = 'Authentication failed: Invalid username or password.';
            RETURN;
        END

        -- Hash the input password using the same hashing algorithm
        SET @InputPasswordHash = HASHBYTES('SHA2_512', @Password);

        -- Compare the hashed passwords
        IF @InputPasswordHash = @StoredPasswordHash
        BEGIN
            -- Authentication successful
            SET @ReturnCode = 0;    -- Success
            SET @Message = 'Authentication successful.';

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
            -- Authentication failed: Incorrect password
            SET @ReturnCode = 2;    -- Error Code 2: Incorrect password
            SET @Message = 'Authentication failed: Invalid username or password.';
        END
    END TRY
    BEGIN CATCH
        -- Handle unexpected errors
        SET @ReturnCode = 99;       -- Error Code 99: Unexpected error
        SET @Message = ERROR_MESSAGE();
    END CATCH
END;
GO

-- =============================================
-- Descripción: Crea el login y usuario para la aplicacion
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
GO

-- =============================================
-- Descripción: Usuario de prueba para probar la autenticacion
-- =============================================
DECLARE @Username NVARCHAR(50) = 'defaultUser';
DECLARE @Password NVARCHAR(255) = 'Test@1234';
DECLARE @Role NVARCHAR(15) = 'Admin';

DECLARE @PasswordHash VARBINARY(64);
SET @PasswordHash = HASHBYTES('SHA2_512', @Password);

INSERT INTO [User] (Username, PasswordHash, [Role])
VALUES (@Username, @PasswordHash, @Role);