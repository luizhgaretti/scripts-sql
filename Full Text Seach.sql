/******************************************************************
		CRIANDO INDEX FULL TEXT
Objetivo: Realizar pesquisa dentro de arquivos
*******************************************************************/

USE Master
GO

-- Criando Banco de Dados DB_FullText
CREATE DATABASE DB_FullText
GO

USE DB_FullText
GO


-- Criando Tabela Documento que será utilizada para armazenar os documentos
CREATE TABLE Documento
(
	ID_Documento INT IDENTITY,
	DC_Titulo	 VARCHAR(10),
	TP_Documento VARCHAR(10),
	DC_Documento VARBINARY(MAX)
)
GO

ALTER TABLE Documento
ADD CONSTRAINT PK_Documento PRIMARY KEY (ID_Documento)
GO


-- Inserindo arquivos na Tabela Documento
Declare @Doc1 VARBINARY(MAX),
		@Doc2 VARBINARY(MAX),
		@Doc3 VARBINARY(MAX)

SET @Doc1 = (SELECT bulkcolumn FROM OPENROWSET(BULK 'D:\Documento1.docx',SINGLE_BLOB) AS Document)
SET @Doc2 = (SELECT bulkcolumn FROM OPENROWSET(BULK 'D:\Documento2.docx',SINGLE_BLOB) AS Document)
SET @Doc3 = (SELECT bulkcolumn FROM OPENROWSET(BULK 'D:\Documento3.docx',SINGLE_BLOB) AS Document)

INSERT INTO Documento (DC_Titulo, Tp_Documento, DC_Documento)
VALUES ('Documento1', '.docx', @Doc1)

INSERT INTO Documento (DC_Titulo, Tp_Documento, DC_Documento)
VALUES ('Documento2', '.docx', @Doc2)

INSERT INTO Documento (DC_Titulo, Tp_Documento, DC_Documento)
VALUES ('Documento3', '.docx', @Doc3)



-- CRIANDO CATALOG
CREATE FULLTEXT CATALOG CatalogoDados
--AS DEFAULT



-- CRIANDO INDEX FULLTEXT
CREATE FULLTEXT INDEX ON dbo.Documento(DC_Documento TYPE COLUMN TP_Documento)
KEY INDEX [PK_Documento]
ON CatalogoDados
WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)
GO



-- SELECTS
SELECT * 
FROM Documento AS P 
WHERE CONTAINS(P.dc_Documento,'"Teste1"')
GO

SELECT * 
FROM Documento AS P 
WHERE CONTAINS(P.dc_Documento,'"Teste2"')
GO

SELECT * 
FROM Documento AS P 
WHERE CONTAINS(P.dc_Documento,'"Full Text"')
GO


-- Extensões do SQL Server
Select * from sys.fulltext_document_types


-- Para habilitar 
sp_fulltext_service 'load_os_resources', 1