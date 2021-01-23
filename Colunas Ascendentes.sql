/*
  Sr.Nimbus - OnDemand
  http://www.srnimbus.com.br
  fabiano.amorim@snimbus.com.br
*/

USE Northwind
GO

-- Colunas ascendentes


-- Criar tablea de 1 milhão para efetuar os testes
IF OBJECT_ID('OrdersBig') IS NOT NULL
BEGIN
  DROP TABLE OrdersBig
END
GO
SELECT TOP 1000000 IDENTITY(Int, 1,1) AS OrderID,
       A.CustomerID,
       CONVERT(Date, GETDATE() - (CheckSUM(NEWID()) / 1000000)) AS OrderDate,
       ISNULL(ABS(CONVERT(Numeric(18,2), (CheckSUM(NEWID()) / 1000000.5))),0) AS Value
  INTO OrdersBig
  FROM Orders A
 CROSS JOIN Orders B
 CROSS JOIN Orders C
 CROSS JOIN Orders D
GO
ALTER TABLE OrdersBig ADD CONSTRAINT xpk_OrdersBig PRIMARY KEY(OrderID)
GO


-- DELETE FROM OrdersBig WHERE OrderDate > GetDate()
-- DROP INDEX OrdersBig.ix_OrderDate
CREATE INDEX ix_OrderDate on OrdersBig(OrderDate)
GO

-- Visualizar fim do histograma
DBCC SHOW_STATISTICS (OrdersBig, [ix_OrderDate]) WITH HISTOGRAM
GO

-- Consultar últimos pedidos inseridos
-- seek + lookup para retornar poucas linhas, melhor plano
SELECT *
  FROM OrdersBig
 WHERE OrderDate > '20190717'
OPTION(RECOMPILE, QueryTraceON 9481) -- TF 9481 desabilita o novo cardinatlity estimator
GO

-- Consultar pedidos que estão fora do range
-- seek + lookup para retornar 0 linhas, melhor plano
SELECT * 
  FROM OrdersBig
 WHERE OrderDate > '20200101'
OPTION(RECOMPILE, QueryTraceON 9481) -- TF 9481 desabilita o novo cardinatlity estimator




-- Exibindo o problema

-- Inserir 100 mil linhas ascendentes
-- 30 segundos para rodar
INSERT INTO OrdersBig (CustomerID, OrderDate, Value)
SELECT 10,
       GetDate(),
       ABS(CONVERT(Numeric(18,2), (CheckSUM(NEWID()) / 1000000.5)))
GO
INSERT INTO OrdersBig (CustomerID, OrderDate, Value)
VALUES  (10,
         (SELECT DateAdd(d, 1, MAX(OrderDate)) FROM OrdersBig),
         ABS(CONVERT(Numeric(18,2), (CheckSUM(NEWID()) / 1000000.5))))
GO 100000


-- Estimativa incorreta pois as estatísticas estão desatualizadas
-- e não atingiram o número suficiente de alterações para disparar 
-- o auto update 
SELECT *
  FROM OrdersBig
 WHERE OrderDate > '20200101'
OPTION(RECOMPILE, QueryTraceON 9481) -- TF 9481 desabilita o novo cardinatlity estimator
GO

-- Por que errou na estimativa? 
-- Porque não tem no histograma vendas com data maior que 2020
DBCC SHOW_STATISTICS (OrdersBig, [ix_OrderDate]) WITH HISTOGRAM
GO

-- Com o novo cardinality estimator sempre estima que os valores existem
SELECT *
  FROM OrdersBig
 WHERE OrderDate > '20200101' -- para o > estima 30%
OPTION(RECOMPILE, QueryTraceON 2312) -- TF 2312 habilita o novo cardinality estimator
GO

-- Aaa, mas o tempo está igual... Correto?
-- E o número de páginas? E 100 pessoas rodando ao mesmo tempo? (sqlquerystress)