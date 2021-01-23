USE master
go

--	DROP DATABASE InMemoryDB

CREATE DATABASE InMemoryDB
ON PRIMARY
(
	NAME = 'InMemoryDBSQLSaturdaySQL',
	FILENAME = 'C:\BaseDados\mdf\InMemoryDBSQLSaturdaySQL.mdf',
	SIZE = 800MB
),
FILEGROUP InMemoryDB CONTAINS MEMORY_OPTIMIZED_DATA
(
	NAME = InMemoryDB1SQL,
	FILENAME = 'C:\BaseDados\mdf\InMemoryDB1SQL'
),
(
	NAME = InMemoryDB2SQL,
	FILENAME = 'C:\BaseDados\mdf\InMemoryDB2SQL'
)
LOG ON 
(
	NAME = InMemoryDBSQLSaturdaySQL_log,
	FILENAME = 'C:\BaseDados\ldf\InMemoryDBSQLSaturdaySQL_log.ldf',
	SIZE = 500MB
)

--Propriedades do Banco de Dados
--Pasta de Criação do Banco de Dados

--Criação Tabelas In-Memory
USE InMemoryDB
go

--	DROP TABLE dbo.CargaDadosInMemory

CREATE TABLE dbo.CargaDadosInMemory
(
	[ID] INT NOT NULL  PRIMARY KEY NONCLUSTERED HASH WITH (BUCKET_COUNT = 1000000),
	[CodigoAtendimento] INT NOT NULL,
	[CodigoCarga] INT NOT NULL,
	[CodigoEmpresa] INT NOT NULL,
	[NomeEmpresa] VARCHAR(200) NOT NULL,
	[Arquivado] BIT NULL
) 
WITH (MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_ONLY);

INSERT INTO dbo.CargaDadosInMemory (ID, CodigoAtendimento, CodigoCarga, CodigoEmpresa, NomeEmpresa, Arquivado)
VALUES (1,1301,1,4,'SQLServer1',0),
	   (3,9139,5,4,'SQLServer1',1),
	   (4,896,55,4,'SQLServer1',0),
	   (6,1010,14,4,'SQLServer1',0),
	   (2,143,3,331,'SQLServer2',0),
	   (10,1423,124,4,'SQLServer3',1),
	   (101,24,501,1,'SQLServer3',0),
	   (23,222,1531,5,'SQLServer1',1),
	   (45,2,124,2,'SQLServer1',1),
	   (1341,1,5123,5,'SQLServer1',0),
	   (401,13,3512,1,'SQLServer2',0)

SELECT *
FROM dbo.CargaDadosInMemory

--NET STOP MSSQLSERVER
--NET START MSSQLSERVER

SELECT *
FROM dbo.CargaDadosInMemory

--	DROP TABLE dbo.DadosAtendimentoInMemory

CREATE TABLE dbo.DadosAtendimentoInMemory 
(
	[ID] INT NOT NULL  PRIMARY KEY NONCLUSTERED HASH WITH (BUCKET_COUNT = 1000000),
	[CodigoAtendimento] INT NOT NULL,
	[Nome] VARCHAR(200) COLLATE Latin1_General_100_BIN2 INDEX idxNome HASH WITH (BUCKET_COUNT = 1000000) NOT NULL,
	[CPF] CHAR(11) NOT NULL,
	[Cidade] VARCHAR(50) COLLATE Latin1_General_100_BIN2 INDEX idxCidade HASH WITH (BUCKET_COUNT = 1000000) NOT NULL,
	[Arquivado] BIT NOT NULL
) 
WITH (MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_AND_DATA);

--Memory Usage By Memory Optimized Objects

BEGIN TRANSACTION

DECLARE @Dados INT
SET @Dados = 1
WHILE @Dados < 300
BEGIN 

	SET @Dados = @Dados + 1
	SET NOCOUNT ON;
	
	INSERT INTO dbo.DadosAtendimentoInMemory (ID, CodigoAtendimento, Nome, CPF, Cidade, Arquivado)
	VALUES (@Dados,130,'Luan Moreno M. Maciel','02236655177','Brasília',0)

END

COMMIT TRANSACTION 

SELECT *
FROM dbo.DadosAtendimentoInMemory

--Memory Usage By Memory Optimized Objects
