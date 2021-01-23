/*
  Author: Fabiano Neves Amorim
  E-Mail: famorim@solidq.com
  Empresa: SolidQ
  http://blogs.solidq.com/fabianosqlserver/Home.aspx
  http://www.simple-talk.com/author/fabiano-amorim/
*/

USE SolidQVirtualConference
GO
SET NOCOUNT ON
GO

-- ****************************************************** --
-- Atenção comandos não documentados devem ser utilizados --
-- com extrema precaução e devem ser observados durante   --
-- atualização de versões do SQL Server                   --
-- ****************************************************** --

-- DROP INDEX PedidosBig.ix_Data_Pedido
CREATE INDEX ix_Data_Pedido on PedidosBig (Data_Pedido)
GO

/*
  DBCC TRACEON(2388)
  Muda o resultado do DBCC SHOW_STATISTICS para exibir 
  se a estatística é "ascendente"
  DBCC TRACEOFF(2388)
*/
DBCC SHOW_STATISTICS (PedidosBig, [ix_Data_Pedido])
GO

-- A partir do terceiro UPDATE com dados ascendentes a estatística é marcada como 
-- "Ascending" 

-- Inserir 10 linhas ascendentes
INSERT INTO PedidosBig (ID_Cliente, Data_Pedido, Valor)
VALUES  (106,
         (SELECT MAX(Data_Pedido) + 1 FROM PedidosBig),
         ABS(CONVERT(Numeric(18,2), (CheckSUM(NEWID()) / 1000000.5))))
GO 10
-- Atualizar a estatística
UPDATE STATISTICS PedidosBig [ix_Data_Pedido] WITH FULLSCAN
GO
-- Verificar se a estatística é "ascendente"
DBCC SHOW_STATISTICS (PedidosBig, [ix_Data_Pedido])
GO



-- Exibindo o problema

-- Inserir 5 mil linhas ascendentes para testar o traceflag
INSERT INTO PedidosBig (ID_Cliente, Data_Pedido, Valor)
VALUES  (106,
         (SELECT MAX(Data_Pedido) + 1 FROM PedidosBig),
         ABS(CONVERT(Numeric(18,2), (CheckSUM(NEWID()) / 1000000.5))))
GO 5000

-- Estimativa incorreta pois as estatísticas estão desatualizadas
-- e não atingiram o número suficiente de alterações para disparar 
-- o auto update
SET STATISTICS IO ON
SELECT * 
  FROM PedidosBig
 WHERE Data_Pedido > '20200101'
OPTION(RECOMPILE)
SET STATISTICS IO OFF
GO
-- O ideal seria fazer um Scan
SET STATISTICS IO ON
SELECT * 
  FROM PedidosBig WITH(index=0)
 WHERE Data_Pedido > '20200101'
OPTION(RECOMPILE)
SET STATISTICS IO OFF
GO


-- Utiizando os Trace Flags

/*
  DBCC TRACEON(2389)  
  Caso a estatística esteja marcada como ascendente adiciona 
  um novo passo no histograma com o maior valor da tabela.

  DBCC TRACEON(2390)
  Mesmo comportamento do trace flag 2389 porém não requer que a 
  estatística esteja marcada como ascendente
  
  HINT QUERYTRACEON para usar o traceflag apenas para uma 
  determinada consulta
  https://connect.microsoft.com/SQLServer/feedback/ViewFeedback.aspx?FeedbackID=338129
  http://connect.microsoft.com/SQLServer/feedback/details/361334/the-querytraceon-option-is-not-documented
*/

SELECT * 
  FROM PedidosBig
 WHERE Data_Pedido > '20200101'
OPTION(QUERYTRACEON 2390, QUERYTRACEON 2389, RECOMPILE)
GO