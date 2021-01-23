/****************************************************************************************
*****************************************************************************************

	Autor: Luciano Moreira
	Sessão: Cenários de corrupção com SQL Server
	Evento: SQL Saturday #253 - Brasília

	Descrição: Demo02 - Corrupção do índice cluster

*****************************************************************************************
****************************************************************************************/

USE master
go

-- DROP DATABASE DBCorrupt01

IF NOT EXISTS (SELECT database_id FROM sys.databases WHERE name = 'DBCorrupt02')
BEGIN
	CREATE DATABASE DBCorrupt02
	ON (NAME = DBCorrupt02_Data
		, FILENAME = 'C:\Temp\SQLSat\Data\DBCorrupt02_Primary.mdf'
		, SIZE = 15MB
		, MAXSIZE = UNLIMITED
		, FILEGROWTH = 10MB)
	, FILEGROUP FG01 DEFAULT
		(NAME = DBCorrupt02_Data_FG01
		, FILENAME = 'C:\Temp\SQLSat\Data\DBCorrupt02_FG01.mdf'
		, SIZE = 10MB
		, MAXSIZE = UNLIMITED
		, FILEGROWTH = 10MB) 
	LOG ON (NAME = DBCorrupt02_Log
		, FILENAME = 'C:\Temp\SQLSat\Data\DBCorrupt02_Log.mdf'
		, SIZE = 10MB
		, MAXSIZE = UNLIMITED
		, FILEGROWTH = 10MB);
END
go

USE DBCorrupt02
GO

IF (SELECT OBJECT_ID('dbo.TblA', 'U')) IS NOT NULL
BEGIN
	DROP TABLE dbo.TblA
END

CREATE TABLE dbo.TblA (
	ID INT IDENTITY NOT NULL CONSTRAINT PK_TblA PRIMARY KEY 
	, Texto VARCHAR(100) NULL
	, DataHora DATETIME2 NOT NULL DEFAULT (SYSDATETIME())
);
go

INSERT INTO TblA (Texto) VALUES ('SQLSat #253 - ID:XXXXX')
GO 10000

BACKUP DATABASE DBCorrupt02
TO DISK = 'C:\Temp\SQLSat\DBCorrupt02.bkp'
WITH INIT, CHECKSUM
go

UPDATE TblA
	SET Texto = 'SQLSat #253 - ID:' + CAST(ID AS CHAR(5))
GO

BACKUP LOG DBCorrupt02
TO DISK = 'C:\Temp\SQLSat\DBCorrupt02_log1.trn'
WITH INIT, CHECKSUM
go

SELECT * FROM TblA
go

SELECT D.page_verify_option_desc, *
FROM SYS.DATABASES as D
WHERE name = 'DBCorrupt02';

DBCC IND ('DBCorrupt02', 'dbo.TblA', 1)
GO

SELECT *, sys.fn_PhysLocFormatter(%%PHYSLOC%%)
FROM dbo.TblA

SELECT *, sys.fn_PhysLocFormatter(%%PHYSLOC%%)
FROM dbo.TblA
WHERE sys.fn_PhysLocFormatter(%%PHYSLOC%%) LIKE '(3:11:%)'

-- ID 173 a 344

DBCC TRACEON(3604)
DBCC PAGE ('DBCorrupt02', 3, 11, 2)
GO

/*
000000000B5FA078:   514c5361 74202332 3533202d 2049443a 31373320  QLSat #253 - ID:173 
000000000B5FA08C:   20300010 00ae0000 0097fd61 505ea137 0b030000   0...®...ýaP^¡7....
000000000B5FA0A0:   01002d00 53514c53 61742023 32353320 2d204944  ..-.SQLSat #253 - ID
*/

CHECKPOINT
SHUTDOWN

-- Corromper página ??? e restart




-- Alternativa 01
USE DBCorrupt02
GO

-- Pagina corrompida entre as páginas
DBCC IND ('DBCorrupt02', 'dbo.TblA', 1)
GO

-- E agora?
SELECT *
FROM dbo.TblA
go

DBCC CHECKDB('DBCorrupt02') WITH NO_INFOMSGS, ALL_ERRORMSGS
GO

-- Ver descrição do minimum repair level

ALTER DATABASE DBCorrupt02
SET SINGLE_USER

DBCC CHECKDB('DBCorrupt02', REPAIR_ALLOW_DATA_LOSS) WITH NO_INFOMSGS, ALL_ERRORMSGS
GO
-- Analisar output

DBCC CHECKDB('DBCorrupt02') WITH NO_INFOMSGS, ALL_ERRORMSGS
GO

-- SHOW!!

ALTER DATABASE DBCorrupt02
SET MULTI_USER
GO

SELECT * FROM TblA
go




-- *********************************************************** --
-- Qual abordagem correta?
-- Refazer corrupção procedimento

USE master
GO

DBCC CHECKDB('DBCorrupt02') WITH NO_INFOMSGS, ALL_ERRORMSGS;

BACKUP LOG DBCorrupt02
TO DISK = 'C:\Temp\SQLSat\DBCorrupt02_log2.trn'
WITH INIT, CHECKSUM
go

-- Inconsistent state
RESTORE DATABASE DBCorrupt02
PAGE = '3:11'
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt02.bkp'
WITH RECOVERY;

RESTORE LOG DBCorrupt02
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt02_log1.trn'
WITH RECOVERY;

RESTORE LOG DBCorrupt02
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt02_log2.trn'
WITH RECOVERY;

DBCC CHECKDB('DBCorrupt02') WITH NO_INFOMSGS, ALL_ERRORMSGS;
