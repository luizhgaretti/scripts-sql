USE SQLSaturdayHekaton
go

--	DROP TABLE dbo.DiskTableEmpregado
CREATE TABLE dbo.DiskTableEmpregado
(
	ID INT NOT NULL PRIMARY KEY,
	Nome VARCHAR(100) NOT NULL,
	CPF CHAR(14) NOT NULL,
	Sexo CHAR(1) NOT NULL,
	DataNascimento DATE NOT NULL
)
go

INSERT INTO dbo.DiskTableEmpregado (ID, Nome, CPF, Sexo, DataNascimento)
VALUES (1,'cassia.nunes','541.325.533-21','F','1991-01-05')
INSERT INTO dbo.DiskTableEmpregado (ID, Nome, CPF, Sexo, DataNascimento)
VALUES (2,'clenilson.santos','151.561.528-88','M','1993-03-20')

SELECT is_memory_optimized, name
FROM sys.tables
WHERE name = 'DiskTableEmpregado'

BEGIN TRANSACTION 

INSERT INTO dbo.DiskTableEmpregado (ID, Nome, CPF, Sexo, DataNascimento)
VALUES (3,'luan.moreno','022.366.551-77','M','1988-07-20')

SELECT resource_type, resource_database_id, resource_description, request_mode, 
	   request_type, request_status, request_owner_type
FROM sys.dm_tran_locks
WHERE request_session_id = @@SPID

ROLLBACK TRANSACTION
GO

-------------------------------------
-------------------------------------

--	DROP TABLE dbo.InMemoryEmpregado
CREATE TABLE dbo.InMemoryEmpregado
(
	ID INT NOT NULL PRIMARY KEY NONCLUSTERED HASH WITH (BUCKET_COUNT = 2000000),
	Nome VARCHAR(100) NOT NULL,
	CPF CHAR(14) NOT NULL,
	Sexo CHAR(1) NOT NULL,
	DataNascimento DATE NOT NULL
)
WITH (MEMORY_OPTIMIZED = ON , DURABILITY = SCHEMA_AND_DATA);
go

INSERT INTO dbo.InMemoryEmpregado (ID, Nome, CPF, Sexo, DataNascimento)
VALUES (1,'cassia.nunes','541.325.533-21','F','1991-01-05')
INSERT INTO dbo.InMemoryEmpregado (ID, Nome, CPF, Sexo, DataNascimento)
VALUES (2,'clenilson.santos','151.561.528-88','M','1993-03-20')

SELECT is_memory_optimized, name
FROM sys.tables
WHERE name = 'InMemoryEmpregado'

BEGIN TRANSACTION

INSERT INTO dbo.InMemoryEmpregado (ID, Nome, CPF, Sexo, DataNascimento)
VALUES (3,'luan.moreno','022.366.551-77','M','1988-07-20')

SELECT resource_type, resource_database_id, resource_description, request_mode, 
	   request_type, request_status, request_owner_type
FROM sys.dm_tran_locks
WHERE request_session_id = @@SPID

ROLLBACK TRANSACTION
GO

