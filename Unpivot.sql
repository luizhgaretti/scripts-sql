USE TSQL2012;
IF OBJECT_ID('Sales.FreightTotals') IS NOT NULL DROP TABLE Sales.FreightTotals;
GO
WITH PivotData AS
(
SELECT
custid , -- grouping column
shipperid, -- spreading column
freight -- aggregation column
FROM Sales.Orders
)
SELECT *
INTO Sales.FreightTotals
FROM PivotData
PIVOT( SUM(freight) FOR shipperid IN ([1],[2],[3]) ) AS P;
SELECT * FROM Sales.FreightTotals;

--

SELECT custid, shipperid, freight
FROM Sales.FreightTotals
UNPIVOT( freight FOR shipperid IN([1],[2],[3]) ) AS U;