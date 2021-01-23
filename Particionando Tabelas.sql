-- Particionamento de Tabelas

USE MASTER
GO

CREATE DATABASE TesteParticionamento
ON PRIMARY 
	(NAME = N'TesteParticionamento01',
	 FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL11.SQL2012\MSSQL\Data\TesteParticionamento01.mdf',
	 SIZE = 4096KB,
	 FILEGROWTH = 1024KB
	),
FILEGROUP Secundario01
	(NAME = N'TesteParticionamento02',
	 FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL11.SQL2012\MSSQL\Data\TesteParticionamento02.ndf',
	 SIZE = 4096KB,
	 FILEGROWTH = 1024KB
	 ),
FILEGROUP Secundario02
	(NAME = N'TesteParticionamento03',
	 FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL11.SQL2012\MSSQL\Data\TesteParticionamento03.ndf',
	 SIZE = 4096KB,
	 FILEGROWTH = 1024KB
	 )
LOG ON
	(NAME = N'TesteParticionamento_log',
	 FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL11.SQL2012\MSSQL\Data\TesteParticionamento_log.ldf',
	 SIZE = 1024KB,
	 FILEGROWTH = 10%
	 )
GO

USE TesteParticionamento
GO

-- Criando a Função de Partição (Partition Function)
CREATE PARTITION FUNCTION PatitionFunction (INT)
AS RANGE RIGHT FOR VALUES (1000, 2000)
GO

-- Criando o Esquema de Partição (Schema Partition)
CREATE PARTITION SCHEME SchemaFunction
AS PARTITION PatitionFunction TO ([Primary], Secundario01, Secundario02)
GO

-- Criando Tabela Particionada
Create Table Tb1
(
	ID		INT PRIMARY KEY,
	Nome	Varchar(50)
)
ON SchemaFunction(ID)
GO

-- Inserindo Dados 
Declare @aux int
Set @aux = 10

While (@aux < 999)
Begin
	INSERT TB1
	Values (@aux, 'Luiz Henrique')
	Set @aux = (@aux + 1)
End
GO