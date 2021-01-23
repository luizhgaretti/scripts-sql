USE [ColumnStoreIndexGlimpse]
GO

SELECT COUNT(*)
FROM [ColumnStoreIndexGlimpse].[dbo].[FatoVendasInternetClusteredColumnStore]
--48.301.600

SELECT TOP 10 *
FROM [ColumnStoreIndexGlimpse].[dbo].[FatoVendasInternetClusteredColumnStore] 

SELECT TOP 10 *
FROM [ColumnStoreIndexGlimpse].[dbo].[FatoVendasInternet] 

GO
SP_HELP '[FatoVendasInternetClusteredColumnStore]'
GO

SET STATISTICS TIME ON
SET STATISTICS IO ON

SELECT DC.Sk_ID, COUNT(FVI.QuantidadePedido) AS Quantidade
FROM [dbo].[FatoVendasInternet] AS FVI WITH(INDEX(0)) --ignore_clustered_column_store_index
INNER JOIN dbo.DimCliente AS DC
ON FVI.Sk_IDCliente = DC.Sk_ID
GROUP BY DC.Sk_ID
ORDER BY COUNT(FVI.QuantidadePedido) DESC

--(18484 row(s) affected)
--Table 'FatoVendasInternet'. Scan count 3, logical reads 619.467, physical reads 0, read-ahead reads 619227, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'DimCliente'. Scan count 2, logical reads 10, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'Workfile'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

SELECT DC.Sk_ID, COUNT(FVI.QuantidadePedido) AS Quantidade
FROM dbo.[FatoVendasInternetClusteredColumnStore] AS FVI WITH(INDEX(1))
INNER JOIN dbo.DimCliente AS DC
ON FVI.Sk_IDCliente = DC.Sk_ID
GROUP BY DC.Sk_ID
ORDER BY COUNT(FVI.QuantidadePedido) DESC

--(18484 row(s) affected)
--Table 'FatoVendasInternetClusteredColumnStore'. Scan count 2, logical reads 33.088, physical reads 1, read-ahead reads 8606, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'DimCliente'. Scan count 2, logical reads 10, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'Worktable'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.
--Table 'Workfile'. Scan count 0, logical reads 0, physical reads 0, read-ahead reads 0, lob logical reads 0, lob physical reads 0, lob read-ahead reads 0.

