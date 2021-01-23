USE [ColumnStoreIndexGlimpse]
go

--RS - Row-Store Mode
SELECT *
FROM sys.tables
WHERE OBJECT_ID = OBJECT_ID('FatoVendasInternet')

SELECT * 
FROM sys.indexes
WHERE OBJECT_ID = OBJECT_ID('FatoVendasInternet')
	AND type = 0

SELECT *
FROM sys.system_internals_allocation_units AS sa, sys.partitions AS sp
WHERE sa.container_id = sp.partition_id
	AND sp.object_id = OBJECT_ID('FatoVendasInternet')
	AND type = 1

SELECT DB_ID()
--21

SELECT *
FROM sys.sysfiles
-- 0001 = 1

--0x25010000 
-- 00 00 01 25 = 293

DBCC TRACEON(3604)
DBCC PAGE (21,1,293,3)


------------------------------------
------------------------------------
--CS - Column-Store Mode
SELECT * 
FROM sys.tables
WHERE OBJECT_ID = OBJECT_ID('FatoVendasInternetClusteredColumnStore')

SELECT * 
FROM sys.indexes
WHERE OBJECT_ID = OBJECT_ID('FatoVendasInternetClusteredColumnStore')

SELECT *
FROM sys.system_internals_allocation_units AS sa, sys.partitions AS sp
WHERE sa.container_id = sp.partition_id
	AND sp.object_id = OBJECT_ID('FatoVendasInternetClusteredColumnStore')

SELECT DB_ID()
--21

SELECT *
FROM sys.sysfiles
-- 0001 = 1

--0x697F0900
-- 00 09 7F 69 = 622441

DBCC TRACEON(3604)
DBCC PAGE (21,1,622441,3)

---------------
---------------

SELECT hobt_id, *
FROM sys.system_internals_allocation_units AS sa, sys.partitions AS sp
WHERE sa.container_id = sp.partition_id
	AND sp.object_id = OBJECT_ID('FatoVendasInternetClusteredColumnStore')

SELECT TOP 10 *
FROM FatoVendasInternetClusteredColumnStore

SELECT COUNT(*)
FROM FatoVendasInternetClusteredColumnStore

SELECT *
FROM sys.column_store_dictionaries
WHERE hobt_id = 72057594040287232

SELECT *
FROM sys.column_store_segments
WHERE hobt_id = 72057594040287232

