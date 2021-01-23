use AdventureWorksDW

GO
EXEC usp_getshipdate @firstname = 'Cole', @lastname ='Torres'

---
alter proc usp_getshipdate
@firstname varchar(30),
@lastname varchar(30)
AS
declare @customerid int

SELECT @customerid= CustomerKey FROM DimCustomer 
where FirstName = @firstname AND LastName =@lastname
--sp_helpindex [dbo.DimCustomer]

SELECT dc.FirstName, dc.LastName,fis.SalesOrderNumber,fis.ShipDateKey 
from [DimCustomer] dc
inner join [dbo].[FactInternetSales] fis
ON dc.CustomerKey = fis.CustomerKey 
WHERE dc.CustomerKey = @customerid 
GO

---
SET SHOWPLAN_TEXT ON
GO
EXEC usp_getshipdate @firstname = 'Cole', @lastname ='Torres'
GO
SET SHOWPLAN_TEXT OFF


---
SET SHOWPLAN_ALL ON
GO
EXEC usp_getshipdate @firstname = 'Cole', @lastname ='Torres'
GO
SET SHOWPLAN_ALL OFF


SET STATISTICS PROFILE ON
EXEC usp_getshipdate @firstname = 'Cole', @lastname ='Torres'
SET STATISTICS PROFILE OFF


SET STATISTICS IO ON
SET STATISTICS TIME ON

EXEC usp_getshipdate @firstname = 'Cole', @lastname ='Torres'

SET STATISTICS IO OFF
SET STATISTICS TIME OFF




--sp_helpindex [dbo.FactInternetSales]

drop index [FactInternetSales].IX_FactInternetSales_CustomerKeyss

CREATE NONCLUSTERED INDEX IX_FactInternetSales_CustomerKeyss 
ON [FactInternetSales] (CustomerKey)

CREATE NONCLUSTERED INDEX idxteste
ON [dbo].[DimCustomer] ([FirstName])

drop index [DimCustomer].idxteste
