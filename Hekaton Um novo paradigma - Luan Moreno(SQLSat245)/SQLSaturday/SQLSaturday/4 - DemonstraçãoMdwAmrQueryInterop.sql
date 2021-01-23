--Amr - Analysis, Migration and Reporting Tool

--QueryInterop
USE SQLSaturday
go

--	DROP TABLE InMemoryDadosVendas
--	DELETE FROM InMemoryDadosVendas

--In-Memory Table
CREATE TABLE InMemoryDadosVendas
(
	ID INT NOT NULL PRIMARY KEY NONCLUSTERED HASH WITH (BUCKET_COUNT = 2000000),
	DataVenda DATETIME NOT NULL,
	OrdemVenda TINYINT NOT NULL
)
WITH (MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_AND_DATA);

SELECT name, is_memory_optimized, durability_desc
FROM sys.tables	
WHERE type = 'U'
	AND name = 'InMemoryDadosVendas'

DELETE FROM InMemoryDadosVendas

BEGIN TRANSACTION

DECLARE @ID INT = 1, @OrdemVenda TINYINT = 1
WHILE @ID < 500000
BEGIN
	INSERT INTO dbo.InMemoryDadosVendas (ID, DataVenda, OrdemVenda)
	VALUES (@ID, GETDATE(),@OrdemVenda)
	SET @ID += 1
END

COMMIT

--	DROP TABLE DiskTableDadosVendas
--	DELETE FROM DiskTableDadosVendas

--Disk-Table
CREATE TABLE DiskTableDadosVendas
(
	ID INT NOT NULL,
	DataVenda DATETIME NOT NULL,
	OrdemVenda TINYINT NOT NULL
)
go

CREATE UNIQUE NONCLUSTERED INDEX idxNCL_DiskTableDadosVendas_ID
ON DiskTableDadosVendas (ID)

SELECT name, is_memory_optimized, durability_desc
FROM sys.tables	
WHERE type = 'U'
	AND name = 'DiskTableDadosVendas'

BEGIN TRANSACTION

DECLARE @ID INT = 1, @OrdemVenda TINYINT = 1
WHILE @ID < 500000
BEGIN
	INSERT INTO dbo.DiskTableDadosVendas (ID, DataVenda, OrdemVenda)
	VALUES (@ID, GETDATE(),@OrdemVenda)
	SET @ID += 1
END

COMMIT

