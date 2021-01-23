USE Master

-- Caso exista um banco chamado DBMirroring, apaga ele.
IF (SELECT DB_ID('DBMirroring')) IS NOT NULL
BEGIN
  ALTER DATABASE DBMirroring SET SINGLE_USER WITH ROLLBACK IMMEDIATE
  DROP DATABASE DBMirroring
END
GO

-- Criar um banco de dados chamado DBMirroring
IF (SELECT DB_ID('DBMirroring')) IS NULL
BEGIN
  CREATE DATABASE DBMirroring
END
GO

-- Altera o banco para utilizar CHECKSUM no Page_Verify
ALTER DATABASE DBMirroring SET PAGE_VERIFY CHECKSUM
GO

USE DBMirroring

-- Habilita o trace 1400 no Principal Server
DBCC TRACEON (1400, -1)

-- Altera o Recovery Model do Principal Server para FULL
ALTER DATABASE DBMirroring SET RECOVERY FULL

-- Faz o backup para restaurar no Mirror Server
BACKUP DATABASE DBMirroring TO  DISK = N'C:\DBMirroring_Data.bak'
WITH NOFORMAT, NOINIT,  NAME = N'DBMirroring-Full Database Backup', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
BACKUP LOG DBMirroring TO DISK = N'C:\DBMirroring_Log.bak'
WITH NOFORMAT, NOINIT,  NAME = N'DBMirroring-Full Log Backup', 
SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

/* Criar os endpoints nos servers principal, mirror e witness. 
Lembrando que a criação de um endpoint no witness server somente é 
necessária se pretende configurar o database mirroring como High Availability.
*/
--  Cria EndPoint no Principal Server
IF EXISTS (SELECT name FROM sys.database_mirroring_endpoints WHERE name='Mirroring')
  DROP ENDPOINT Mirroring
GO
CREATE ENDPOINT Mirroring
    STATE = STARTED
    AS TCP (LISTENER_PORT = 5022)
    FOR DATABASE_MIRRORING (ROLE = PARTNER);
GO

-- RODAR COMANDOS SCRIPT 2 NO SQL2008R2_2

-- Configurar o mirror server como um PARTNER do principal server
-- Executar no Principal Server
ALTER DATABASE DBMirroring 
  SET PARTNER = 'TCP://nb_fabiano:5023'
GO

USE DBMirroring
GO

-- Vamos criar uma tabela para utilizar nos testes.
CREATE TABLE TesteMirror(ID   Int IDENTITY(1,1) PRIMARY KEY,
                         Nome Char(250))
GO

-- Vamos inserir uma linha na tabela
INSERT INTO TesteMirror(Nome) VALUES('Fabiano Neves Amorim')
GO

CHECKPOINT
GO

SELECT * FROM TesteMirror

-- Vamos verificar qual é o nº da Página que contem os dados da tabela.

SELECT Root FROM SysIndexes
WHERE ID = OBJECT_ID('TesteMirror')
-- Root = 0x150000000100

-- Convertendo o Hexadecimal para Int
SELECT CAST(0x15 AS INT) -- = 80

-- Pegando o ID do Banco de dados
SELECT DB_ID()

--DBCC IND(5,2137058649,1)

DBCC TRACEON(3604)
GO
DBCC PAGE(DBMirroring,1,21,3)

-- Abrir outra sessão e simular uma queda no Banco
-- 3 - Shut Down.sql

-- Abrir o XVI32 e editar o arquivo .mdf

-- Subir o Banco

-- Testar o select para verificar os dados na tabela.
USE DBMirroring
GO
SELECT * FROM TesteMirror
/*

Msg 824, Level 24, State 2, Line 1
SQL Server detected a logical consistency-based I/O error: 
incorrect checksum (expected: 0xf2df8608; actual: 0x75530e8e). 
It occurred during a read of page (1:21) in database ID 5 at 
offset 0x0000000002a000 in file 
'C:\Arquivos de programas\Microsoft SQL Server\MSSQL10.SQL2008_1\MSSQL\DATA\DBMirroring.mdf'.  
Additional messages in the SQL Server error log or system event log may provide more detail. 
This is a severe error condition that threatens database integrity and 
must be corrected immediately. Complete a full database consistency check (DBCC CHECKDB). 
This error can be caused by many factors; for more information, see SQL Server Books Online.

*/

-- Página foi marcada como suspect
SELECT * FROM msdb.dbo.suspect_pages

-- Derrubar mirror
-- ALTER DATABASE DBMirroring SET PARTNER OFF