/*
  Author: Fabiano Neves Amorim
  E-Mail: famorim@solidq.com
  Empresa: SolidQ
  http://blogs.solidq.com/fabianosqlserver/Home.aspx
  http://www.simple-talk.com/author/fabiano-amorim/
*/


USE SolidQVirtualConference
GO
-- Preparando os dados
IF EXISTS(SELECT * FROM sysindexes WHERE name ='ix_Descricao' and id = object_id('ProdutosBig'))
  DROP INDEX ix_Descricao ON ProdutosBig
GO
CREATE INDEX ix_Descricao ON ProdutosBig(Descricao)
GO

-- ALTER TABLE PedidosBig DROP COLUMN Col1
ALTER TABLE PedidosBig ADD Col1 Int
GO
UPDATE PedidosBig SET Col1 = ID_Pedido
GO
IF EXISTS(SELECT * FROM sysindexes WHERE name ='ix_Col1' and id = object_id('PedidosBig'))
  DROP INDEX ix_Col1 ON PedidosBig
GO
CREATE NONCLUSTERED INDEX ix_Col1 ON PedidosBig(Col1)
GO


-- Retornar 1 pedido da tabela PedidosBig utilizando o índice ix_Col1
SELECT * FROM PedidosBig
 WHERE Col1 = 10
OPTION (RECOMPILE)
/*
  Quão seletiva a coluna precisa ser para compensar fazer o lookup
  utilizando o índice ix_Data_Pedido?
  50% ? 500000
  40% ? 400000
  30% ? 300000
  20% ? 200000
  10% ? 100000
*/
SELECT *
  FROM PedidosBig
 WHERE Col1 <= 500000 -- 50%
OPTION (RECOMPILE)
GO
SELECT *
  FROM PedidosBig
 WHERE Col1 <= 400000 -- 40%
OPTION (RECOMPILE)
GO
SELECT *
  FROM PedidosBig
 WHERE Col1 <= 300000 -- 30%
OPTION (RECOMPILE)
GO
SELECT *
  FROM PedidosBig
 WHERE Col1 <= 200000 -- 20%
OPTION (RECOMPILE)
GO
SELECT *
  FROM PedidosBig
 WHERE Col1 <= 100000 -- 10%
OPTION (RECOMPILE)
GO
SELECT *
  FROM PedidosBig
 WHERE Col1 <= 50000 -- 5%
OPTION (RECOMPILE)
GO
SELECT *
  FROM PedidosBig
 WHERE Col1 <= 10000 -- 1%
OPTION (RECOMPILE)
GO
SELECT *
  FROM PedidosBig
 WHERE Col1 <= 5000 -- 0.5%
OPTION (RECOMPILE)
GO
SELECT *
  FROM PedidosBig
 WHERE Col1 <= 2000 -- 0.2%
OPTION (RECOMPILE)
GO

/*
  Proc sp_TestLookup
*/
EXEC dbo.sp_TestLookup @Table_Name   = 'PedidosBig',
                       @Lookup_Index = 'ix_Col1',
                       @Trace_Path   = 'C:\TesteTrace.trc'
GO
EXEC dbo.sp_TestLookup @Table_Name   = 'ProdutosBig',
                       @Lookup_Index = 'ix_Descricao',
                       @Trace_Path   = 'C:\TesteTrace.trc'
GO
                       
/*
  EXEC sp_configure 'show advanced options', 1
  GO
  RECONFIGURE
  GO
  EXEC sp_configure 'xp_cmdshell', 1
  GO
  RECONFIGURE
  GO 
*/