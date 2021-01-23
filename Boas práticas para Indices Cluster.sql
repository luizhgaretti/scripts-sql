USE Master

-- Caso exista um banco chamado Teste, apaga ele.
IF (SELECT DB_ID('Teste')) IS NOT NULL
BEGIN
  USE Master
  ALTER DATABASE Teste SET SINGLE_USER WITH ROLLBACK IMMEDIATE
  DROP DATABASE Teste
END
GO

-- Criar um banco de dados chamado Teste no C:\
IF (SELECT DB_ID('Teste')) IS NULL
BEGIN
  CREATE DATABASE Teste ON PRIMARY 
  (NAME = N'teste', FILENAME = N'C:\teste.mdf' , SIZE = 51200KB , FILEGROWTH = 1024KB)
   LOG ON 
  (NAME = N'teste_log', FILENAME = N'C:\teste_log.ldf' , SIZE = 51200KB , FILEGROWTH = 10%)
END
GO

USE Teste

-- Cria uma tabela de teste com uma chave composta colunas ID Int, CPF Char(11) Primary Key
CREATE TABLE Teste (ID        Int Identity(1,1), 
                    CPF       Char(11),
                    Nome      VarChar(200),
                    Sobrenome VarChar(200),
                    Endereco  VarChar(200),
                    Bairro    VarChar(200),
                    Cidade    VarChar(200),
                    Primary Key(ID, CPF, Nome))

-- Cria uma tabela de teste com uma coluna ID Identity e Primary Key
CREATE TABLE TesteIdentity (ID   Int Identity(1,1) Primary Key, 
                            CPF  Char(11),
                            Nome VarChar(200),
                            Sobrenome VarChar(200),
                            Endereco  VarChar(200),
                            Bairro    VarChar(200),
                            Cidade    VarChar(200))

SET NOCOUNT ON
-- Inclui 50000 mil de linhas nas tabelas
INSERT INTO Teste(CPF, Nome, SobreNome, Endereco, Bairro, Cidade) 
            VALUES('11111111111', NEWID(), 'Neves Amorim', NEWID(), NEWID(), NEWID())
GO 50000

INSERT INTO TesteIdentity(CPF, Nome, SobreNome, Endereco, Bairro, Cidade)
SELECT CPF, Nome, SobreNome, Endereco, Bairro, Cidade
  FROM Teste

-- Vamos criar alguns indices nonclustered para cada tabela
CREATE NONCLUSTERED INDEX ix_NomeSobrenome ON Teste(Nome, SobreNome)
CREATE NONCLUSTERED INDEX ix_Sobrenome     ON Teste(SobreNome)
CREATE NONCLUSTERED INDEX ix_Endereco      ON Teste(Endereco)
CREATE NONCLUSTERED INDEX ix_NomeSobrenome ON TesteIdentity(Nome, SobreNome)
CREATE NONCLUSTERED INDEX ix_Sobrenome     ON TesteIdentity(SobreNome)
CREATE NONCLUSTERED INDEX ix_Endereco      ON TesteIdentity(Endereco)

-- PEQUENO
-- Ao comparar o tamanho das tabelas já podemos observar que a tabela Teste 
-- é maior que a tabela TesteIdentity justamente por causa do index_size.
sp_spaceUsed Teste
GO
sp_spaceUsed TesteIdentity

-- A tabela teste é maior porque nos indices non-cluster é incluido os dados do indice cluster
-- para comprovar isso podemos utilizar o comando abaixo. 
-- Repare que é exibida a informação das colunas Endereco, ID, CPF e Nome
DBCC SHOW_STATISTICS('Teste', ix_Endereco)

-- ESTÁTICOS
-- Agora vamos ver quantas leituras de páginas são necessárias para atualizar 
-- 2000 linhas das tabelas, Vamos ligar as estatiscitas de IO para ver o resultado
-- se você exibir o Plano de execução repare que o update na tabela Teste
-- irá atualizar os indices non-cluster da tabela.
SET STATISTICS IO ON

update Teste set Nome = 'Fabio'
where ID < 2000
/*
Table 'Teste'. Scan count 1, logical reads 50377, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
Table 'Worktable'. Scan count 4, logical reads 12544, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
*/
GO
update TesteIdentity set Nome = 'Fabio'
where ID < 2000
/*
Table 'TesteIdentity'. Scan count 1, logical reads 51, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
*/
SET STATISTICS IO OFF

/*
  Para vizualizar a funcionalidade de incluir mais um valor de 4 bytes nos registros duplicados afim
  de torná-los únicos vamos alterar a primary key da tabela teste.
*/

-- Pega o nome da primary key
exec sp_pkeys Teste

-- Apaga a primary key para recria-la como não cluster.
ALTER TABLE Teste DROP CONSTRAINT PK__Teste__3E52440B
-- Recria a primary key como não cluster
ALTER TABLE Teste ADD CONSTRAINT PK__Teste PRIMARY KEY NONCLUSTERED(ID, CPF, Nome)
-- Cria um indice cluster com base na coluna CPF
CREATE CLUSTERED INDEX ix_CPF ON Teste(CPF)

/*
  Para vizualizar o valor que o SQL incluiu em cada valor duplicado vamos utilizar o comando
  DBCC PAGE
*/
-- Pega o endereço físico do Nivel raiz do indice coluna Root da tabela SysIndexes
SELECT *
  FROM SysIndexes
 WHERE ID = Object_id('Teste') 
   AND Name = 'ix_CPF'
-- Resultado 0x300D00000100
-- 0x0D30

-- Transforma o HexaDecimal em Inteiro
SELECT CAST(0x0D30 AS INT)

-- Pega o ID do banco
SELECT DB_ID(DB_Name())

DBCC TRACEON(3604)
GO
DBCC PAGE(8,1,3376,3)

/*  Resultado
FileId	|PageId	|Row	|Level	|ChildFileId	|ChildPageId	|CPF (key)	  |UNIQUIFIER (key)	|KeyHashValue
1	     |2738	  |0	  |2	    |1	          |2736	       |NULL	       |NULL	            |(1d0151a9cf2f)
1	     |2738	  |1	  |2	    |1	          |2737	       |11111111111	|11894	           |(930152642c7b)
1	     |2738	  |2	  |2	    |1	          |2739	       |11111111111	|23454	           |(bd0117b642ad)
1	     |2738	  |3	  |2	    |1	          |2740	       |11111111111	|35014	           |(e601bd2493e9)
1	     |2738	  |4	  |2	    |1	          |2741	       |11111111111	|46574	           |(0f021bded106)
*/

-- Podemos ver que foi gerada uma coluna "UNIQUIFIER (key)", Bunito esse nome né? Uniquifier :-)