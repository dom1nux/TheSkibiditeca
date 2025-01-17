-- Descartar base de datos si existe
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'my_database')
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
