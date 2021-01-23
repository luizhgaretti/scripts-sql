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
  Seek � utilizado quando � poss�vel navegar pela �rvore
  balanceada do �ndice
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
  Quando um Index Seek � na verdade um Index Scan
*/
-- Aqui o SQL utiliza o �ndice corretamente
SELECT * 
  FROM ProdutosBig
 WHERE Descricao LIKE 'CORSA WIND 1.0 2P D%'
OPTION (RECOMPILE, MAXDOP 1)
GO

-- J� quando utilizamos o % no come�o da string o 
-- SQL n�o faz o seek
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

-- Utiliza o �ndice
EXEC dbo.st_RetornaProdutosBig 'CORSA WIND 1.0 D%'
GO

-- Continua usando �ndice e fazendo o seek
EXEC dbo.st_RetornaProdutosBig '%CORSA%'
GO

-- Mas est� fazendo um scan nas p�ginas do �ndice, compare a quantidade de 
-- p�ginas para fazer o scan vs o seek do comando abaixo
SET STATISTICS IO ON
EXEC dbo.st_RetornaProdutosBig '%CORSA%'
GO
SELECT * 
  FROM ProdutosBig
 WHERE Descricao LIKE '%CORSA%'
OPTION (RECOMPILE, MAXDOP 1)
SET STATISTICS IO OFF