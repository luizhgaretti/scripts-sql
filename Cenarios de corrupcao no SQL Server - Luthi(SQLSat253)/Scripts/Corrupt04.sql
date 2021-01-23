/****************************************************************************************
*****************************************************************************************

	Autor: Luciano Moreira
	Sessão: Cenários de corrupção com SQL Server
	Evento: SQL Saturday #253 - Brasília

	Descrição: Demo04 - Corrupção diferente

*****************************************************************************************
****************************************************************************************/

USE master
go

-- DROP DATABASE DBCorrupt04
-- DROP DATABASE DBC04

IF NOT EXISTS (SELECT database_id FROM sys.databases WHERE name = 'DBCorrupt04')
BEGIN
	CREATE DATABASE DBCorrupt04
	ON (NAME = DBCorrupt04_Data
		, FILENAME = 'C:\Temp\SQLSat\Data\DBCorrupt04_Primary.mdf'
		, SIZE = 15MB
		, MAXSIZE = UNLIMITED
		, FILEGROWTH = 10MB)
	, FILEGROUP FG01 DEFAULT
		(NAME = DBCorrupt04_Data_FG01
		, FILENAME = 'C:\Temp\SQLSat\Data\DBCorrupt04_FG01.mdf'
		, SIZE = 10MB
		, MAXSIZE = UNLIMITED
		, FILEGROWTH = 10MB) 
	LOG ON (NAME = DBCorrupt04_Log
		, FILENAME = 'C:\Temp\SQLSat\Data\DBCorrupt04_Log.mdf'
		, SIZE = 10MB
		, MAXSIZE = UNLIMITED
		, FILEGROWTH = 10MB);
END
go

USE DBCorrupt04
GO

IF (SELECT OBJECT_ID('dbo.TblA', 'U')) IS NOT NULL
BEGIN
	DROP TABLE dbo.TblA
END

CREATE TABLE dbo.TblA (
	ID INT IDENTITY NOT NULL CONSTRAINT PK_TblA PRIMARY KEY 
	, Texto CHAR(200) NULL
	, DataHora DATETIME2 NOT NULL DEFAULT (SYSDATETIME())
);
go

INSERT INTO TblA (Texto) VALUES ('SQLSat #253 - ID:XXXXX')
GO 1000

BACKUP DATABASE DBCorrupt04
TO DISK = 'C:\Temp\SQLSat\DBCorrupt04.bkp'
WITH INIT, CHECKSUM
go

UPDATE TblA
	SET Texto = 'SQLSat #253 - ID:' + CAST(ID AS CHAR(5))
		, DataHora = getdate() - 60
GO

BACKUP LOG DBCorrupt04
TO DISK = 'C:\Temp\SQLSat\DBCorrupt04_log1.trn'
WITH INIT, CHECKSUM
go

--BACKUP LOG DBCorrupt04
--TO DISK = 'null'
--go

INSERT INTO TblA (Texto) VALUES ('SQLSat #253 - ID:XXXXX')
GO 1000

BACKUP LOG DBCorrupt04
TO DISK = 'C:\Temp\SQLSat\DBCorrupt04_log2.trn'
WITH INIT, CHECKSUM
go

INSERT INTO TblA (Texto) VALUES ('SQLSat #253 - ID:XXXXX')
GO 1000

BACKUP LOG DBCorrupt04
TO DISK = 'C:\Temp\SQLSat\DBCorrupt04_log3.trn'
WITH INIT, CHECKSUM
go

CREATE NONCLUSTERED INDEX idxNCL_TblA_Data
ON dbo.TblA (DataHora);

-- Comando tem que executar
SELECT * FROM dbo.TblA;

DBCC IND ('DBCorrupt04', 'dbo.TblA', 1)
GO

DBCC TRACEON(3604)
DBCC PAGE ('DBCorrupt04', 3, 11, 2)

CHECKPOINT
SHUTDOWN

-- Corromper backup log2 e segunda página de dados do índice cluster


-- DROP DATABASE DBC04
-- Testes para validar se backup de log está corrompido

RESTORE FILELISTONLY
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt04.bkp'

RESTORE DATABASE DBC04
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt04.bkp'
WITH MOVE 'DBCorrupt04_Data' TO 'C:\Temp\SQLSat\Data\DBCorrupt04_Primary2.mdf'
	, MOVE 'DBCorrupt04_Data_FG01' TO 'C:\Temp\SQLSat\Data\DBCorrupt04_FG012.mdf'
	, MOVE 'DBCorrupt04_Log' TO 'C:\Temp\SQLSat\Data\DBCorrupt04_Log2.mdf'
	, REPLACE
	, NORECOVERY;

RESTORE LOG DBC04
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt04_log1.trn'
WITH NORECOVERY;

RESTORE LOG DBC04
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt04_log2.trn'
WITH NORECOVERY;

-- Ue?!!

RESTORE VERIFYONLY
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt04_log2.trn';

-- Arquivo corrompido!







/*************************************
	DEMO *COMEÇA* AQUI
*************************************/

USE DBCorrupt04
go

SELECT * FROM TblA
go

DBCC CHECKDB('DBCorrupt04') WITH NO_INFOMSGS, ALL_ERRORMSGS
GO

/*
BACKUPS...

DBCorrupt04.bkp
DBCorrupt04_log1.trn
DBCorrupt04_log2.trn
DBCorrupt04_log3.trn
*/

BACKUP LOG DBCorrupt04
TO DISK = 'C:\Temp\SQLSat\DBCorrupt04_log4.trn'
WITH INIT, CHECKSUM
go

--BACKUP LOG DBCorrupt04
--TO DISK = 'C:\Temp\SQLSat\DBCorrupt04_Corrupt.bkp'
--WITH INIT
--go

USE master
go

-- Resolvendo o problema
RESTORE DATABASE DBCorrupt04
PAGE = '3:11'
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt04.bkp'
WITH NORECOVERY;

RESTORE LOG DBCorrupt04
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt04_log1.trn'
WITH NORECOVERY;

RESTORE LOG DBCorrupt04
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt04_log2.trn'
WITH NORECOVERY;

RESTORE LOG DBCorrupt04
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt04_log3.trn'
WITH NORECOVERY;

RESTORE LOG DBCorrupt04
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt04_log4.trn'
WITH RECOVERY;

DBCC CHECKDB('DBCorrupt04') WITH NO_INFOMSGS, ALL_ERRORMSGS;

RESTORE VERIFYONLY
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt04_log2.trn';

-- Lambou tudo

RESTORE DATABASE DBCorrupt04
WITH RECOVERY;
GO

DBCC CHECKDB('DBCorrupt04') WITH NO_INFOMSGS, ALL_ERRORMSGS;

SELECT *
FROM DBCorrupt04.dbo.TblA;

-- E isso?
SELECT DataHora, ID
FROM DBCorrupt04.dbo.TblA


SELECT DataHora, ID
INTO #SalvandoDados
FROM DBCorrupt04.dbo.TblA
go

ALTER DATABASE DBCorrupt04
SET SINGLE_USER

DBCC CHECKDB('DBCorrupt04', REPAIR_ALLOW_DATA_LOSS) WITH NO_INFOMSGS, ALL_ERRORMSGS;

DBCC CHECKDB('DBCorrupt04') WITH NO_INFOMSGS, ALL_ERRORMSGS;

SELECT *
FROM DBCorrupt04.dbo.TblA;

-- E isso?
SELECT DataHora, ID
FROM DBCorrupt04.dbo.TblA

SELECT *
FROM #SalvandoDados AS S
WHERE S.ID NOT IN (SELECT ID FROM DBCorrupt04.dbo.TblA);


RESTORE FILELISTONLY
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt04.bkp'

RESTORE DATABASE DBC04
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt04.bkp'
WITH MOVE 'DBCorrupt04_Data' TO 'C:\Temp\SQLSat\Data\DBCorrupt04_Primary2.mdf'
	, MOVE 'DBCorrupt04_Data_FG01' TO 'C:\Temp\SQLSat\Data\DBCorrupt04_FG012.mdf'
	, MOVE 'DBCorrupt04_Log' TO 'C:\Temp\SQLSat\Data\DBCorrupt04_Log2.mdf'
	, REPLACE
	, NORECOVERY;

RESTORE LOG DBC04
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt04_log1.trn'
WITH NORECOVERY;

RESTORE LOG DBC04
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt04_log2.trn'
WITH NORECOVERY;

RESTORE DATABASE DBC04
WITH RECOVERY;

-- Nosa melhor aposta são os dados do backup antigo
-- Se o dado é histórico, excelente
SELECT *
FROM #SalvandoDados AS S
INNER JOIN DBC04.dbo.tblA AS T
ON S.ID = T.ID
WHERE S.ID NOT IN (SELECT ID FROM DBCorrupt04.dbo.TblA);

USE DBCorrupt04
go

SET IDENTITY_INSERT dbo.tblA ON

INSERT INTO dbo.TblA (ID, Texto, DataHora)
SELECT T.*
FROM #SalvandoDados AS S
INNER JOIN DBC04.dbo.tblA AS T
ON S.ID = T.ID
WHERE S.ID NOT IN (SELECT ID FROM DBCorrupt04.dbo.TblA);

SET IDENTITY_INSERT dbo.tblA OFF

SELECT *
FROM DBCorrupt04.dbo.TblA;

