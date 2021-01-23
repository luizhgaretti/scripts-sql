USE Master
GO

-- Caso exista um banco chamado TesteCompression, apaga ele.
IF (SELECT DB_ID('TesteCompression')) IS NOT NULL
BEGIN
  USE Master
  ALTER DATABASE TesteCompression SET SINGLE_USER WITH ROLLBACK IMMEDIATE
  DROP DATABASE TesteCompression
END
GO

-- Criar um banco de dados chamado TesteCompression
IF (SELECT DB_ID('TesteCompression')) IS NULL
BEGIN
  CREATE DATABASE TesteCompression
END
GO

USE TesteCompression
GO

IF OBJECT_ID('Tab_Teste') IS NOT NULL
BEGIN
  DROP TABLE  Tab_Teste
END

-- Tabela de Teste
CREATE TABLE Tab_Teste(ID INT IDENTITY(1,1) PRIMARY KEY, 
                       Nome    VarChar(200),
                       Nome2   Char(200)     DEFAULT NEWID(),
                       Nome3   Char(200)     DEFAULT NEWID(),
                       Data    DateTime      DEFAULT GetDate(),
                       Data1   DateTime      DEFAULT GetDate(),
                       Valor   Numeric(18,4) DEFAULT 10.5,
                       Inteiro BigInt        DEFAULT 10)
GO

SET NOCOUNT ON 
DECLARE @I INT
SET @I = 0 
WHILE @I < 10000
BEGIN
  INSERT INTO Tab_Teste (Nome) VALUES('Test de Compression')
  SET @I = @I + 1; 
END
GO

-- Verifica o tamanho do banco de dados
sp_helpdb TesteCompression

-- Efetuar backup no C:\ com Compression e sem Compression

BACKUP DATABASE [TesteCompression] 
    TO DISK = N'C:\Teste_Backup_Sem_Compression.bak' WITH NOFORMAT, 
    NOINIT, NAME = 'TesteCompression-Full', SKIP, NOREWIND, NOUNLOAD
GO

BACKUP DATABASE [TesteCompression] 
    TO DISK = N'C:\Teste_Backup_Com_Compression.bak' WITH NOFORMAT, 
    NOINIT, NAME = 'TesteCompression-Full', SKIP, NOREWIND, NOUNLOAD, COMPRESSION
GO
