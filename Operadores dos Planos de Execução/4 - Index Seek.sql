/*
  Author: Fabiano Neves Amorim
  E-Mail: famorim@solidq.com
  Empresa: SolidQ
  http://blogs.solidq.com/fabianosqlserver/Home.aspx
  http://www.simple-talk.com/author/fabiano-amorim/
*/

USE SolidQVirtualConference
GO
/*
  Index Seek
*/

/*
  Seek é utilizado quando é possível navegar pela árvore
  balanceada do índice
*/
IF EXISTS(SELECT * FROM sysindexes WHERE name = 'ix_Descricao_Produto' and id = OBJECT_ID('ProdutosBig'))
  DROP INDEX ix_Descricao_Produto ON ProdutosBig
GO
CREATE INDEX ix_Descricao_Produto ON ProdutosBig(Descricao) INCLUDE(Col1)
GO

-- Apaga a coluna ColTest criada no exemplo do Sort
ALTER TABLE ProdutosBig DROP COLUMN ColTest
GO

-- Ex: Non-Clustered Index Seek
SELECT * 
  FROM ProdutosBig
 WHERE Descricao LIKE 'CORSA WIND 1.0 2P D%'
OPTION (RECOMPILE, MAXDOP 1)

/*
  Quando um Index Seek é na verdade um Index Scan
*/
-- Aqui o SQL utiliza o índice corretamente
SELECT * 
  FROM ProdutosBig
 WHERE Descricao LIKE 'CORSA WIND 1.0 2P D%'
OPTION (RECOMPILE, MAXDOP 1)
GO

-- Já quando utilizamos o % no começo da string o 
-- SQL não faz o seek
SELECT * 
  FROM ProdutosBig
 WHERE Descricao LIKE '%CORSA%'
OPTION (RECOMPILE, MAXDOP 1)
GO

IF OBJECT_ID('st_RetornaProdutosBig', 'P') IS NOT NULL
  DROP PROC st_RetornaProdutosBig
GO
CREATE PROC st_RetornaProdutosBig @vDescricao VarChar(250)
WITH RECOMPILE
AS
BEGIN
  SELECT * 
    FROM ProdutosBig
   WHERE Descricao LIKE @vDescricao
END
GO

-- Utiliza o índice
EXEC dbo.st_RetornaProdutosBig 'CORSA WIND 1.0 D%'
GO

-- Continua usando índice e fazendo o seek
EXEC dbo.st_RetornaProdutosBig '%CORSA%'
GO

-- Mas está fazendo um scan nas páginas do índice, compare a quantidade de 
-- páginas para fazer o scan vs o seek do comando abaixo
SET STATISTICS IO ON
EXEC dbo.st_RetornaProdutosBig '%CORSA%'
GO
SELECT * 
  FROM ProdutosBig
 WHERE Descricao LIKE '%CORSA%'
OPTION (RECOMPILE, MAXDOP 1)
SET STATISTICS IO OFF