-- Elimina la Base de Datos si Existe
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'TheSkibiditeca')
BEGIN
    USE master;
    ALTER DATABASE TheSkibiditeca SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TheSkibiditeca;
END;
GO

-- Crea la Base de Datos
CREATE DATABASE TheSkibiditeca;
GO

-- Usa la Base de Datos Creada
USE TheSkibiditeca;
GO