
/*************************************************************************************
GROUPING
**************************************************************************************/

--#1 Uma função agregada simples
USE TSQL2012;
SELECT COUNT(*) AS numorders
FROM Sales.Orders;


--#2 Um grouping pelo Shipperid 
SELECT shipperid, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY shipperid;


--#3 Funções agregadas trabalham com cálculos
-- YEAR não calcula nada.

-- Ao criar grupos com duas ou mais colunas, essas colunas tornam o grupo distinto

-- NULLs podem ocorrer, pois nem todos os produtos foram entregues ainda (shippeddate)
SELECT shipperid, YEAR(shippeddate) AS shippedyear,
COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY shipperid, YEAR(shippeddate);


--#3.1 Eliminando os NULLs
SELECT shipperid, YEAR(shippeddate) AS shippedyear,
COUNT(*) AS numorders
FROM Sales.Orders
WHERE shippeddate IS NOT NULL
GROUP BY shipperid, YEAR(shippeddate)
-- HAVING COUNT(*) < 100;












---#5 GROUPING SETs
select country, city, count(*) 
from Sales.Customers 
group by grouping sets
(
(country,city),
(country),
()
)




-- #5.1 
SELECT shipperid, YEAR(shippeddate) AS shipyear, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY GROUPING SETS
(
( shipperid, YEAR(shippeddate) ),
( shipperid ),
( YEAR(shippeddate) ),
( )
);


--#6 CUBE  -- Parte do GROUPING SET
SELECT shipperid, YEAR(shippeddate) AS shipyear, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY CUBE( shipperid, YEAR(shippeddate) );
/*
1. ( shipperid, YEAR(shippeddate) )
2. ( shipperid )
3. ( YEAR(shippeddate) )
4. ( )
*/


-- #7 ROLLUP -- Parte do GROUPING SET, mas para uma hierarquia definida
SELECT shipcountry, shipregion, shipcity, COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY ROLLUP( shipcountry, shipregion, shipcity );
/*
1. ( shipcountry, shipregion, shipcity )
2. ( shipcountry, shipregion )
3. ( shipcountry )
4. ( )

*/

--#8 identifica se o NULL é um grupo ou um NULL real
SELECT
shipcountry, GROUPING(shipcountry) AS grpcountry,
shipregion , GROUPING(shipregion) AS grpregion,
shipcity , GROUPING(shipcity) AS grpcIty,
COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY ROLLUP( shipcountry, shipregion, shipcity );


--#9 GROUPING_ID para criar níveis do grupo

-- GROUPING_ID( shipcountry, shipregion, shipcity ) = GROPPING(shipcountry) + GROPPING(shipregion) + GROPPING(shipcity)
Use TSQL2012
SELECT GROUPING_ID( shipcountry, shipregion, shipcity ) AS grp_id,
shipcountry, shipregion, shipcity,
COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY ROLLUP( shipcountry, shipregion, shipcity );


Use TSQL2012
SELECT GROUPING_ID( shipcountry, shipregion, shipcity ) AS grp_id,
shipcountry, shipregion, shipcity,
COUNT(*) AS numorders
FROM Sales.Orders
GROUP BY CUBE( shipcountry, shipregion, shipcity );




-- shipcountry = 100
-- shipregion = 010
-- shipcity = 001

--shipcountry shipregion = 110
--shipcountry shipcity = 101

-- shipregion shipcity = 011

-- shipcountry shipregion shipcity = 111

SELECT CASE WHEN GROUPING_ID( shipcountry, shipregion, shipcity )  = 4 THEN shipcountry
 WHEN GROUPING_ID( shipcountry, shipregion, shipcity )  = 2 THEN shipregion
 WHEN GROUPING_ID( shipcountry, shipregion, shipcity )  = 6 THEN 'Country - Region'
 WHEN GROUPING_ID( shipcountry, shipregion, shipcity )  = 5 THEN 'Country - City'
 WHEN GROUPING_ID( shipcountry, shipregion, shipcity )  = 3 THEN 'Region - City'
 WHEN GROUPING_ID( shipcountry, shipregion, shipcity )  = 1 THEN shipcity
 ELSE 'Geral'
 END, count(*)
 FROM Sales.Orders
GROUP BY ROLLUP(shipcountry, shipregion, shipcity );





USE AdventureWorks2008;
GO
SELECT D.Name
    ,CASE 
    WHEN GROUPING_ID(D.Name, E.JobTitle) = 0 THEN E.JobTitle
    WHEN GROUPING_ID(D.Name, E.JobTitle) = 1 THEN N'Total: ' + D.Name 
    WHEN GROUPING_ID(D.Name, E.JobTitle) = 3 THEN N'Company Total:'
        ELSE N'Unknown'
    END AS N'Job Title'
    ,COUNT(E.BusinessEntityID) AS N'Employee Count'
FROM HumanResources.Employee E
    INNER JOIN HumanResources.EmployeeDepartmentHistory DH
        ON E.BusinessEntityID = DH.BusinessEntityID
    INNER JOIN HumanResources.Department D
        ON D.DepartmentID = DH.DepartmentID     
WHERE DH.EndDate IS NULL
    AND D.DepartmentID IN (12,14)
GROUP BY ROLLUP(D.Name, E.JobTitle);
-------------------------------------------------

USE AdventureWorks2008;
GO
DECLARE @Grouping nvarchar(50);
DECLARE @GroupingLevel smallint;
SET @Grouping = N'CountryRegionCode Total';

SELECT @GroupingLevel = (
    CASE @Grouping
        WHEN N'Grand Total'             THEN 15
        WHEN N'SalesPerson Total'       THEN 14
        WHEN N'Store Total'             THEN 13
        WHEN N'Store SalesPerson Total' THEN 12
        WHEN N'CountryRegionCode Total' THEN 11
        WHEN N'Group Total'             THEN 7
        ELSE N'Unknown'
    END);

SELECT 
    T.[Group]
    ,T.CountryRegionCode
    ,S.Name AS N'Store'
    ,(SELECT P.FirstName + ' ' + P.LastName 
        FROM Person.Person AS P 
        WHERE P.BusinessEntityID = H.SalesPersonID)
        AS N'Sales Person'
    ,SUM(TotalDue)AS N'TotalSold'
    ,CAST(GROUPING(T.[Group])AS char(1)) + 
        CAST(GROUPING(T.CountryRegionCode)AS char(1)) + 
        CAST(GROUPING(S.Name)AS char(1)) + 
        CAST(GROUPING(H.SalesPersonID)AS char(1)) 
        AS N'GROUPING base-2'
    ,GROUPING_ID((T.[Group])
        ,(T.CountryRegionCode),(S.Name),(H.SalesPersonID)
        ) AS N'GROUPING_ID'
    ,CASE 
        WHEN GROUPING_ID(
            (T.[Group]),(T.CountryRegionCode)
            ,(S.Name),(H.SalesPersonID)
            ) = 15 THEN N'Grand Total'
        WHEN GROUPING_ID(
            (T.[Group]),(T.CountryRegionCode)
            ,(S.Name),(H.SalesPersonID)
            ) = 14 THEN N'SalesPerson Total'
        WHEN GROUPING_ID(
            (T.[Group]),(T.CountryRegionCode)
            ,(S.Name),(H.SalesPersonID)
            ) = 13 THEN N'Store Total'
        WHEN GROUPING_ID(
            (T.[Group]),(T.CountryRegionCode)
            ,(S.Name),(H.SalesPersonID)
            ) = 12 THEN N'Store SalesPerson Total'
        WHEN GROUPING_ID(
            (T.[Group]),(T.CountryRegionCode)
            ,(S.Name),(H.SalesPersonID)
            ) = 11 THEN N'CountryRegionCode Total'
        WHEN GROUPING_ID(
            (T.[Group]),(T.CountryRegionCode)
            ,(S.Name),(H.SalesPersonID)
            ) =  7 THEN N'Group Total'
        ELSE N'Error'
        END AS N'Level'
FROM Sales.Customer AS C
    INNER JOIN Sales.Store AS S
        ON C.StoreID  = S.BusinessEntityID 
    INNER JOIN Sales.SalesTerritory AS T
        ON C.TerritoryID  = T.TerritoryID 
    INNER JOIN Sales.SalesOrderHeader AS H
        ON C.CustomerID = H.CustomerID
GROUP BY GROUPING SETS ((S.Name,H.SalesPersonID)
    ,(H.SalesPersonID),(S.Name)
    ,(T.[Group]),(T.CountryRegionCode),()
    )
HAVING GROUPING_ID(
    (T.[Group]),(T.CountryRegionCode),(S.Name),(H.SalesPersonID)
    ) = @GroupingLevel
ORDER BY 
    GROUPING_ID(S.Name,H.SalesPersonID),GROUPING_ID((T.[Group])
    ,(T.CountryRegionCode)
    ,(S.Name)
    ,(H.SalesPersonID))ASC;
