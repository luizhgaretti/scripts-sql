Select substring(ProdNome, 5,3) From Produto

Select Nullif(Str(ProdCod),ProdNome), * From Produto
Where ProdCod >1

WITH Sales_CTE (SalesPersonID, NumberOfOrders, MaxDate)
AS
(
    SELECT SalesPersonID, COUNT(*), MAX(OrderDate)
    FROM Sales.SalesOrderHeader
    GROUP BY SalesPersonID
)
SELECT E.BusinessEntityID, OS.NumberOfOrders, OS.MaxDate
FROM HumanResources.Employee AS E
    JOIN Sales_CTE AS OS
    ON E.BusinessEntityID = OS.SalesPersonID
ORDER BY E. BusinessEntityID;


Create View TEste
AS
	Select * From Produto
	
Select * From TEste

