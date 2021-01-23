USE Northwind
GO

-- Código horrorozo
SELECT ContactName, 
       REPLACE(REPLACE(REPLACE(REPLACE(ContactName, 'a', 'A'), 'b', 'B'),'c', 'C'), 'd', 'D') ReplaceResult,
       CASE WHEN CustomerID < 10 THEN 0 ELSE 1 END AS CaseResult
  FROM Customers
GO

-- Trabalhando nas formatações...
SELECT ContactName, Replace3.Col, CaseResult.Col
  FROM Customers
 CROSS APPLY (SELECT REPLACE(ContactName, 'a', 'A')) Replace1(Col)
 CROSS APPLY (SELECT REPLACE(Replace1.Col, 'b', 'B')) Replace2(Col)
 CROSS APPLY (SELECT REPLACE(Replace2.Col, 'c', 'C')) Replace3(Col)
 CROSS APPLY (SELECT CASE WHEN CustomerID < 10 THEN 0 ELSE 1 END) AS CaseResult(Col)
GO


----------------------------------------
---- Ultimas 3 vendas por Empregado ----
----------------------------------------
-- Preparando base
ALTER TABLE OrdersBig ADD EmployeeID Int NULL
GO
UPDATE OrdersBig SET EmployeeID = ABS(CHECKSUM(NEWID())/ 100000000) + 1
GO
/*
  Escreva uma consulta que retorne as últimas 3 
  vendas por empregado. O resultado deverá ser ordenado por 
  FistName e OrderDate DESC

  Banco: NorthWind
  Tabela: Employees, OrdersBig
*/

-- Resultado esperado:
/*
  FirstName  OrderID     OrderDate
  ---------- ----------- -----------------------
  Andrew     11073       1998-05-05 00:00:00.000
  Andrew     11070       1998-05-05 00:00:00.000
  Andrew     11060       1998-04-30 00:00:00.000
  Anne       11058       1998-04-29 00:00:00.000
  Anne       11022       1998-04-14 00:00:00.000
  Anne       11017       1998-04-13 00:00:00.000
  Janet      11063       1998-04-30 00:00:00.000
  Janet      11057       1998-04-29 00:00:00.000
  Janet      11052       1998-04-27 00:00:00.000
  Laura      11075       1998-05-06 00:00:00.000
  ...
*/

-- Opção 1
SELECT Employees.FirstName, Tab_Orders.OrderID, Tab_Orders.OrderDate 
  FROM Employees
 INNER JOIN (SELECT ROW_NUMBER() OVER (PARTITION BY EmployeeID ORDER BY OrderDate DESC) AS rn, * 
               FROM OrdersBig) AS Tab_Orders
    ON Tab_Orders.EmployeeID = Employees.EmployeeID
   AND Tab_Orders.rn <= 3
 ORDER BY Employees.FirstName
GO

-- Opção 2, nice, fast and clean
SELECT Employees.FirstName, Tab_Orders.OrderID, Tab_Orders.OrderDate 
  FROM Employees
 CROSS APPLY(SELECT TOP 3 OrderID, OrderDate
               FROM OrdersBig
              WHERE OrdersBig.EmployeeID = Employees.EmployeeID
              ORDER BY OrderDate DESC) AS Tab_Orders
 ORDER BY Employees.FirstName

-- Criando índices para melhorar consulta e evitar sorts por OrderDate
-- e FirstName
-- DROP INDEX ixEmployeeID ON OrdersBig
-- DROP INDEX ixFirstName ON Employees
CREATE INDEX ixEmployeeID ON OrdersBig(EmployeeID, OrderDate)
CREATE INDEX ixFirstName ON Employees(FirstName)
GO


---------------------------------------
-- Qual a maior pontuação por Aluno? --
---------------------------------------
IF OBJECT_ID('tempdb.dbo.#TabPontuacao') IS NOT NULL
  DROP TABLE #TabPontuacao
GO
CREATE TABLE #TabPontuacao
(
   Nome varchar(15) PRIMARY KEY,
   Pontuacao1 tinyint,
   Pontuacao2 tinyint,
   Pontuacao3 tinyint
);

INSERT #TabPontuacao (Nome, Pontuacao1, Pontuacao2, Pontuacao3)
VALUES ('Fabiano', 3, 9, 10),
       ('Pedro', 16, 9, 8),
       ('Paulo', 8, 9, 8);

SELECT * FROM #TabPontuacao

-- Resultado esperado:
/*
  Nome            Maior_Pontuacao
  --------------- ---------------
  Fabiano                      10
  Paulo                         9
  Pedro                        16
*/

-- Opção 1
SELECT Nome, MAX(Nota)
  FROM #TabPontuacao
UNPIVOT(Nota FOR Pontuacao IN([Pontuacao1], [Pontuacao2], [Pontuacao3])) AS U
 GROUP BY Nome
GO

-- Opção 2
SELECT Tab1.Nome,
       MAX(Tab2.Pontuacao) AS Maior_Pontuacao
  FROM #TabPontuacao AS Tab1
 CROSS APPLY (VALUES (Tab1.Pontuacao1),
                     (Tab1.Pontuacao2),
                     (Tab1.Pontuacao3)) AS Tab2 (Pontuacao)
GROUP BY Tab1.Nome
ORDER BY Tab1.Nome;

-- Opção 3
-- Case + Agregação/GroupBy
-- Me recuso a escrever de tão feio que deve ficar...