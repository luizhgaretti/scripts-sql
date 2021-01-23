----------------------------------------
------- Common Table Expressions -------
----------------------------------------

-- Teste 1
-- Quais os 3 países que mais geraram pedidos em 1997?

-- Opção 1
SELECT TOP 3 ShipCountry, 
       YEAR(OrderDate) AS Ano, 
       COUNT(*) AS PedidosNoAno
  FROM Orders
 WHERE YEAR(OrderDate) = 1997
 GROUP BY ShipCountry, YEAR(OrderDate)
 ORDER BY COUNT(*) DESC
GO

-- Opção 2
WITH VendasPorPais AS
(
	 SELECT ShipCountry, YEAR(OrderDate) AS Ano, COUNT(*) AS PedidosNoAno
	   FROM Orders 
	  GROUP BY ShipCountry, YEAR(OrderDate)
)
SELECT TOP 3 *
  FROM VendasPorPais
 WHERE Ano = 1997
 ORDER BY PedidosNoAno DESC

-- Obs.: Custo entre consultas é um pouquinho diferente... QO é ou não é uma maravilha? :-)

-- Teste 2
-- Evitando acesso a functions mais de uma vez com CTEs
IF OBJECT_ID('fn_QtdePedidosPorCliente') IS NOT NULL 
  DROP FUNCTION dbo.fn_QtdePedidosPorCliente
GO
CREATE FUNCTION dbo.fn_QtdePedidosPorCliente(@CustomerID Int) 
RETURNS Int
AS 
BEGIN 
  DECLARE @Total Int
  
  SELECT @Total = Count(OrdersBig.OrderID)
    FROM OrdersBig
   WHERE CustomerID = @CustomerID
  
  RETURN @Total 
END
GO
-- DROP INDEX ixCustomerID ON OrdersBig
CREATE INDEX ixCustomerID ON OrdersBig(CustomerID) 
GO


-- Consulta 1
SELECT TOP 5000
       CASE 
         WHEN dbo.fn_QtdePedidosPorCliente(CustomerID) BETWEEN 40 AND 50 THEN 'A'
         WHEN dbo.fn_QtdePedidosPorCliente(CustomerID) BETWEEN 51 AND 60 THEN 'B'
         WHEN dbo.fn_QtdePedidosPorCliente(CustomerID) BETWEEN 61 AND 70 THEN 'C'
         WHEN dbo.fn_QtdePedidosPorCliente(CustomerID) BETWEEN 71 AND 80 THEN 'D'
         ELSE 'E'
       END AS Status,
       *
  FROM CustomersBig
GO

-- Consulta 2
WITH CTE_1
AS
(
  SELECT *, dbo.fn_QtdePedidosPorCliente(CustomerID) AS fn_QtdePedidosPorCliente
    FROM CustomersBig
)
SELECT TOP 5000 
       CASE 
         WHEN fn_QtdePedidosPorCliente BETWEEN 40 AND 50 THEN 'A'
         WHEN fn_QtdePedidosPorCliente BETWEEN 51 AND 60 THEN 'B'
         WHEN fn_QtdePedidosPorCliente BETWEEN 61 AND 70 THEN 'C'
         WHEN fn_QtdePedidosPorCliente BETWEEN 71 AND 80 THEN 'D'
         ELSE 'E'
       END AS Status,
       *
  FROM CTE_1
GO

-- Teste 3
-- Recursividade
WITH Hierarquia AS
(
  -- 1º SELECT: âncora – início da recursão
  SELECT EmployeeID, 
         CONVERT(VarChar(MAX), FirstName + ' ' + LastName) AS Nome, 
         NivelHierarquico = 1
    FROM Employees
   WHERE ReportsTo IS NULL	
   UNION ALL	
  -- 2º SELECT: recursivo – gera linhas a partir da linha âncora, e 
  -- depois gera linhas para cada linha gerada na execução anterior
  SELECT E.EmployeeID, 
         CONVERT(VarChar(MAX), REPLICATE('----', NivelHierarquico + 1) + FirstName + ' ' + LastName) AS Nome,
         NivelHierarquico + 1
    FROM Hierarquia H 
   INNER JOIN Employees E
      ON H.EmployeeID = E.ReportsTo
)
SELECT * FROM Hierarquia

-- Teste 4
-- Criando uma tabela de sequencial usando recursividade
WITH Sequencial AS
(
  SELECT 1 as ID
   UNION ALL
  SELECT ID + 1
    FROM Sequencial
   WHERE ID < 100
)
SELECT * 
  FROM Sequencial
--OPTION (MAXRECURSION 32767)