USE TheSkibiditeca;
GO
-- Definimos ruta para guardar el backup en el contenedor de la base de datos
BACKUP DATABASE TheSkibiditeca
TO DISK = '/var/opt/mssql/bkp/backup.bak';
GO

-- Se tiene que usar `docker exec -it mssql-server bash` para acceder a la shell del contenedor
-- navegamos a ` cd /var/opt/mssql`, ahi creamos un directorio para el backup con `mkdir bkp/`
-- luego ejecutamos este query para crear el backup
-- después copiamos el backup.bak al host con `docker cp mssql-server:/var/opt/mssql/bkp/backup.bak ~/backup.bak`
-- finalmente, copiamos el .bak al cliente a la carpeta escritorio via ssh con `scp scp -r prod:~/backup.bak C:\Users\$USER\Desktop\`