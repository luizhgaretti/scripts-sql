USE AdventureWorks;

SELECT NAME, COL_NAME ( s.object_id , column_id ) as CNAME
FROM sys.stats s INNER JOIN sys.stats_columns sc
ON s.stats_id = sc.stats_id
AND s.object_id = sc.object_id
WHERE s.object_id = OBJECT_ID('dbo.OrderDetails')
ORDER BY NAME;

GO
DBCC SHOW_STATISTICS(N'dbo.OrderDetails', 'NCL_OrderDetail_LineTotal')