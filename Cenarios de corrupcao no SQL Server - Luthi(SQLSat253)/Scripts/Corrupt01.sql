/****************************************************************************************
*****************************************************************************************

	Autor: Luciano Moreira
	Sessão: Cenários de corrupção com SQL Server
	Evento: SQL Saturday #253 - Brasília

	Descrição: Demo01 - Corrupção de índice não cluster

*****************************************************************************************
****************************************************************************************/
USE master
go

-- DROP DATABASE DBCorrupt01

IF NOT EXISTS (SELECT database_id FROM sys.databases WHERE name = 'DBCorrupt01')
BEGIN
	CREATE DATABASE DBCorrupt01
	ON (NAME = DBCorrupt01_Data
		, FILENAME = 'C:\Temp\SQLSat\Data\DBCorrupt01_Primary.mdf'
		, SIZE = 15MB
		, MAXSIZE = UNLIMITED
		, FILEGROWTH = 10MB)
	, FILEGROUP FG01 DEFAULT
		(NAME = DBCorrupt01_Data_FG01
		, FILENAME = 'C:\Temp\SQLSat\Data\DBCorrupt01_FG01.mdf'
		, SIZE = 10MB
		, MAXSIZE = UNLIMITED
		, FILEGROWTH = 10MB) 
	LOG ON (NAME = DBCorrupt01_Log
		, FILENAME = 'C:\Temp\SQLSat\Data\DBCorrupt01_Log.mdf'
		, SIZE = 10MB
		, MAXSIZE = UNLIMITED
		, FILEGROWTH = 10MB);
END
go

USE DBCorrupt01
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

INSERT INTO TblA DEFAULT VALUES
GO 10000

UPDATE TblA
	SET Texto = 'SQLSat #253 - ID:' + CAST(ID AS VARCHAR)
GO

Select * from TblA
go

CREATE NONCLUSTERED INDEX idxNCL_TblA_Texto
ON dbo.TblA (Texto)
go

-- Mostrar execution plan
SELECT Texto
FROM dbo.TblA
ORDER BY Texto
go

SELECT *
FROM sys.partitions AS P
INNER JOIN SYS.system_internals_allocation_units AS AU
ON P.partition_id = AU.container_id
WHERE P.object_id = OBJECT_ID('dbo.TblA')
go

DBCC IND ('DBCorrupt01', 'dbo.TblA', 2)
GO

DBCC TRACEON(3604)
DBCC PAGE ('DBCorrupt01', 3, 128, 3)
GO

SELECT D.page_verify_option_desc
FROM SYS.DATABASES as D
WHERE name = 'DBCorrupt01';

CHECKPOINT
SHUTDOWN

-- Corromper página 128 e restart

USE DBCorrupt01
GO

sp_readerrorlog

-- E agora?
SELECT *
FROM dbo.TblA
go

SELECT Texto
FROM dbo.TblA
ORDER BY Texto
go

DBCC CHECKDB('DBCorrupt01') WITH NO_INFOMSGS, ALL_ERRORMSGS
GO

-- Analisando o erro. Na verdade, 4 erros?

DBCC IND ('DBCorrupt01', 'dbo.TblA', 2)
GO

SELECT * FROM MSDB.dbo.suspect_pages;

-- Como corrigir essa corrupção?

ALTER INDEX idxNCL_TblA_Texto
ON dbo.TblA
REBUILD
go

-- E agora?
DROP INDEX dbo.TblA.idxNCL_TblA_Texto
go

CREATE NONCLUSTERED INDEX idxNCL_TblA_Texto
ON dbo.TblA (Texto)
go

DBCC CHECKDB('DBCorrupt01') WITH NO_INFOMSGS, ALL_ERRORMSGS
GO

-- E o suspect_pages
SELECT * FROM MSDB.dbo.suspect_pages;

-- Pronto
DELETE FROM MSDB.dbo.suspect_pages;

USE master
GO