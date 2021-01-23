/****************************************************************************************
*****************************************************************************************

	Autor: Luciano Moreira
	Sessão: Cenários de corrupção com SQL Server
	Evento: SQL Saturday #253 - Brasília

	Descrição: Demo03 - Corrupção do ????

*****************************************************************************************
****************************************************************************************/

USE master
go

-- DROP DATABASE DBCorrupt03

IF NOT EXISTS (SELECT database_id FROM sys.databases WHERE name = 'DBCorrupt03')
BEGIN
	CREATE DATABASE DBCorrupt03
	ON (NAME = DBCorrupt03_Data
		, FILENAME = 'C:\Temp\SQLSat\Data\DBCorrupt03_Primary.mdf'
		, SIZE = 15MB
		, MAXSIZE = UNLIMITED
		, FILEGROWTH = 10MB)
	, FILEGROUP FG01 DEFAULT
		(NAME = DBCorrupt03_Data_FG01
		, FILENAME = 'C:\Temp\SQLSat\Data\DBCorrupt03_FG01.mdf'
		, SIZE = 10MB
		, MAXSIZE = UNLIMITED
		, FILEGROWTH = 10MB) 
	LOG ON (NAME = DBCorrupt03_Log
		, FILENAME = 'C:\Temp\SQLSat\Data\DBCorrupt03_Log.mdf'
		, SIZE = 10MB
		, MAXSIZE = UNLIMITED
		, FILEGROWTH = 10MB);
END
go

USE DBCorrupt03
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

BACKUP DATABASE DBCorrupt03
TO DISK = 'C:\Temp\SQLSat\DBCorrupt03.bkp'
WITH INIT, CHECKSUM
go

UPDATE TblA
	SET Texto = 'SQLSat #253 - ID:' + CAST(ID AS CHAR(5))
GO

BACKUP LOG DBCorrupt03
TO DISK = 'C:\Temp\SQLSat\DBCorrupt03_log1.trn'
WITH INIT, CHECKSUM
go

SELECT * FROM TblA
go

SELECT D.page_verify_option_desc, *
FROM SYS.DATABASES as D
WHERE name = 'DBCorrupt03';

CHECKPOINT
SHUTDOWN

-- Corromper página: (1:0) - File header do MDF
--









/***************************************
	DEMO COMEÇA AQUI
***************************************/
/*
DBCorrupt03.bkp
DBCorrupt03_log1.trn
*/
USE DBCorrupt03
GO

exec sp_readerrorlog

DBCC CHECKDB('DBCorrupt03') WITH NO_INFOMSGS, ALL_ERRORMSGS
GO

-- Qual o primeiro passo?






BACKUP LOG DBCorrupt03
TO DISK = 'C:\Temp\SQLSat\DBCorrupt03_log2.trn'
WITH INIT, CHECKSUM
go


-- E agora?


BACKUP LOG DBCorrupt03
TO DISK = 'C:\Temp\SQLSat\DBCorrupt03_log2.trn'
WITH INIT, CHECKSUM, NO_TRUNCATE
go

-- Tail do log






-- Corrigindo o File Header
RESTORE DATABASE DBCorrupt03
PAGE = '1:0'
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt03.bkp'
WITH RECOVERY;

-- O SQL Server é brother ou não?!




RESTORE FILELISTONLY
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt03.bkp'

RESTORE DATABASE DBCorrupt03
FILE = 'DBCorrupt03_Data'
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt03.bkp'
WITH REPLACE, NORECOVERY;

RESTORE LOG DBCorrupt03
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt03_log1.trn'
WITH NORECOVERY;

RESTORE LOG DBCorrupt03
FROM DISK = 'C:\Temp\SQLSat\DBCorrupt03_log2.trn'
WITH NORECOVERY;
GO

RESTORE DATABASE DBCorrupt03
WITH RECOVERY;
GO

DBCC CHECKDB('DBCorrupt03') WITH NO_INFOMSGS, ALL_ERRORMSGS;






/*
-- Corromper página 0 -- file header
*/