
--================================================================
-- FORMAT
--================================================================

Use TSQL2012
go

select productname, FORMAT(unitprice,'C','pt-BR') from Production.Products 


select orderid, FORMAT(orderdate,'dd/MMMM/yyyy','pt-BR') from Sales.Orders  