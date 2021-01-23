USE Master

-- Caso exista um banco chamado SemDBMirroring, apaga ele.
IF (SELECT DB_ID('SemDBMirroring')) IS NOT NULL
BEGIN
  USE Master
  ALTER DATABASE SemDBMirroring SET SINGLE_USER WITH ROLLBACK IMMEDIATE
  DROP DATABASE SemDBMirroring
END
GO

-- Criar um banco de dados chamado DBMirroring
IF (SELECT DB_ID('SemDBMirroring')) IS NULL
BEGIN
  CREATE DATABASE SemDBMirroring
END
GO

-- Altera o banco para utilizar CHECKSUM no Page_Verify
ALTER DATABASE [SemDBMirroring] SET PAGE_VERIFY CHECKSUM
GO

USE SemDBMirroring

-- Vamos criar uma tabela para utilizar nos testes.
CREATE TABLE TesteMirror(ID   Int IDENTITY(1,1) PRIMARY KEY,
                         Nome Char(250))
GO

-- Vamos inserir uma linha na tabela
INSERT INTO TesteMirror(Nome) VALUES('Fabiano Neves Amorim')
GO

SELECT * FROM TesteMirror
GO

CHECKPOINT
GO

-- Vamos verificar qual é o nº da Página que contem os dados da tabela.

SELECT Root FROM SysIndexes
WHERE ID = OBJECT_ID('TesteMirror')
-- Root = 0x004E00000100

-- Convertendo o Hexadecimal para Int
SELECT CAST(0x15 AS INT) -- = 15

-- Pegando o ID do Banco de dados
SELECT DB_ID()

--DBCC IND(5,2137058649,1)

DBCC TRACEON(3604)
GO
DBCC PAGE(SemDBMirroring,1,21,3)

-- Abrir outra sessão e simular uma queda no Banco
-- 3 - Shut Down.sql

-- Abrir o XVI32 e editar o arquivo .mdf

-- Subir o Banco

-- Testar o select para verificar os dados na tabela.
USE SemDBMirroring
GO
SELECT * FROM TesteMirror

-- Vamos verificar se a página foi marcada como Suspect
SELECT * FROM msdb.dbo.suspect_pages


-- Tenta recuperar o Banco
ALTER DATABASE SemDBMirroring SET SINGLE_USER WITH ROLLBACK IMMEDIATE

DBCC CHECKDB('SemDBMirroring', REPAIR_ALLOW_DATA_LOSS) WITH NO_INFOMSGS;

ALTER DATABASE SemDBMirroring SET MULTI_USER

-- Já elvis meus registro :-(
SELECT * FROM TesteMirror