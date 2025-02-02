USE TheSkibiditeca;
GO
-- =============================================
-- Creacion de el login y usario para la aplicación
-- =============================================
CREATE LOGIN AppLogin
    WITH PASSWORD = 'YourSecurePassword!123';
GO

CREATE USER AppUser
    FOR LOGIN AppLogin;
GO

-- Denegar control directo de la base de datos al usuario
DENY SELECT, INSERT, UPDATE, DELETE ON SCHEMA :: dbo TO AppUser;
GO

-- =============================================
-- Creacion de roles para gestionar permisos
-- =============================================
-- Rol para ejecutar procedimientos almacenados
CREATE ROLE spExecutorRole;
-- Rol para consultar vistas
CREATE ROLE viewReaderRole;
GO

-- Agregar los roles al usuario AppUser
EXEC sp_addrolemember 'spExecutorRole', 'AppUser';
EXEC sp_addrolemember 'viewReaderRole', 'AppUser';
GO

-- ===========================================
-- Dar permisos a los roles correspondientes
-- ===========================================
GRANT EXECUTE ON OBJECT::spAuthenticateUser TO spExecutorRole;
GRANT EXECUTE ON OBJECT::spRegisterUser TO spExecutorRole;
GRANT EXECUTE ON OBJECT::spProcessLending TO spExecutorRole;
GRANT EXECUTE ON OBJECT::spProcessReturn TO spExecutorRole;
GRANT EXECUTE ON OBJECT::spAddBook TO spExecutorRole;
GRANT EXECUTE ON OBJECT::spAddAuthor TO spExecutorRole;
GRANT EXECUTE ON OBJECT::spAddPublisher TO spExecutorRole;
GRANT EXECUTE ON OBJECT::spAddStudent TO spExecutorRole;
GO

GRANT SELECT ON OBJECT::vwPendingBorrows TO viewReaderRole;
GRANT SELECT ON OBJECT::vwReturnedBorrows TO viewReaderRole;
GRANT SELECT ON OBJECT::vwOverdueBorrows TO viewReaderRole;
GRANT SELECT ON OBJECT::vwAllBorrows TO viewReaderRole;
GRANT SELECT ON OBJECT::vwStudentBorrowHistory TO viewReaderRole;
GRANT SELECT ON OBJECT::vwBookDetails TO viewReaderRole;
GRANT SELECT ON OBJECT::vwLibrarianInfo TO viewReaderRole;
GRANT SELECT ON OBJECT::vwStudentInfo TO viewReaderRole;
GRANT SELECT ON OBJECT::vwPublisherInfo TO viewReaderRole;
GRANT SELECT ON OBJECT::vwAuthorInfo TO viewReaderRole;
GRANT SELECT ON OBJECT::vwOperationLog TO viewReaderRole;
GRANT SELECT ON OBJECT::vwAvailableBooks TO viewReaderRole;
GO

-- =============================================
-- Creación de usuario de prueba
-- =============================================
DECLARE @Username NVARCHAR(50) = 'defaultUser';
DECLARE @Password NVARCHAR(255) = 'Test@1234';
DECLARE @Role NVARCHAR(15) = 'Admin';

-- Calcular el hash de la contraseña
DECLARE @PasswordHash VARBINARY(64) = HASHBYTES('SHA2_512', @Password);

INSERT INTO [User] (Username, PasswordHash, [Role])
VALUES (@Username, @PasswordHash, @Role);
GO
