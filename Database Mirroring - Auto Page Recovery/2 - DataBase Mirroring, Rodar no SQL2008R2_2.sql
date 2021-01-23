/* Habilita o trace 1400 no Mirror Server */
DBCC TRACEON (1400, -1)

/* Cria EndPoint no Mirror Server / Rodar no Mirror Server */
IF EXISTS (SELECT name FROM sys.database_mirroring_endpoints WHERE name='Mirroring')
  DROP ENDPOINT Mirroring
GO
CREATE ENDPOINT Mirroring
    STATE = STARTED
    AS TCP ( LISTENER_PORT = 5023 )
    FOR DATABASE_MIRRORING (ROLE=PARTNER);
GO

/* Restaurar o Backup com NORECOVERY no Mirror Server */
--Rodar no Mirror Server
-- Caso exista um banco chamado DBMirroring, apaga ele.
IF (SELECT DB_ID('DBMirroring')) IS NOT NULL
BEGIN
  USE Master
  ALTER DATABASE DBMirroring SET SINGLE_USER WITH ROLLBACK IMMEDIATE
  DROP DATABASE DBMirroring
END
GO

RESTORE DATABASE DBMirroring FROM DISK = N'C:\DBMirroring_Data.bak' WITH  FILE = 1,  
MOVE N'DBMirroring' TO N'C:\DBMirroring.mdf',  
MOVE N'DBMirroring_Log'  TO N'C:\DBMirroring_1.ldf',  
NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 10
GO
RESTORE LOG [DBMirroring] FROM DISK = N'C:\DBMirroring_Log.bak' WITH  FILE = 1,
NORECOVERY,  NOUNLOAD,  STATS = 10
GO

/* Configurar o principal server como um PARTNER do mirror server. 
   Executar no mirror server
-------------------------------------------------
Onde "NB_Fabiano" é o nome físico do meu principal server
Também é possível usar o endereço IP do servidor.
*/
USE Master
GO
 ALTER DATABASE DBMirroring
   SET PARTNER = 'TCP://NB_Fabiano:5022'