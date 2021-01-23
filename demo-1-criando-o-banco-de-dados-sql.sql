-- Criando o Banco de Dados - FATEC --
CREATE DATABASE FATEC
ON PRIMARY
	(NAME = FATEC_Dados,
	  FILENAME = N'C:\Users\Junior Galvão\Desktop\Fatec\FATEC-Dados.mdf',
          SIZE = 5MB,
          MAXSIZE = 25MB,
          FILEGROWTH = 10%)	
LOG ON
	( NAME = FATEC_Log,
	  FILENAME = N'C:\Users\Junior Galvão\Desktop\Fatec\FATEC-Log.ldf',
          SIZE = 2MB,
          MAXSIZE = 40MB,
          FILEGROWTH = 10%)
GO

-- Alterando o Recovery Model para Simple - Descartando o Log de Transações --
ALTER DATABASE FATEC
 SET RECOVERY SIMPLE
Go

-- Alterando o Recovery Model para Simple - Mantendo o Log de Transações --
ALTER DATABASE FATEC
 SET RECOVERY FULL
Go

-- Consultando a System Table Sys.Databases --
SELECT * FROM SYS.Databases
Go

-- Consultando a System Table Sys.SysDatabases --
SELECT * FROM SYS.SysDatabases
Go

-- Utilizando a System Function DATABASEPROPERTYEX() --
SELECT DATABASEPROPERTYEX('FATEC', 'Status') As Status, 
             DATABASEPROPERTYEX('FATEC', 'Recovery') As 'Modelo de Recuperação',
             DATABASEPROPERTYEX('FATEC', 'UserAccess') As 'Forma de Acesso', 
             DATABASEPROPERTYEX('FATEC', 'Version') As 'Versão' 
Go
