-- Using uspGetWeeklySalesSummary to Load SalesPersonProductWeeklySummary
USE AdventureWorks
GO
INSERT INTO Sales.SalesPersonProductWeeklySummary
	(SalesPersonID
	,SalesPersonFirstName
	,SalesPersonLastName
	,OrderWeekOfYear
	,OrderYear
	,ProductID
	,ProductName
	,WeeklyOrderQty
	,WeeklyLineTotal
	)
EXEC Sales.uspGetSalesWeeklySummary @StartOfWeek = '1/1/2004 00:00:00', @EndOfWeek = '1/7/2004 11:59:59';
GO
