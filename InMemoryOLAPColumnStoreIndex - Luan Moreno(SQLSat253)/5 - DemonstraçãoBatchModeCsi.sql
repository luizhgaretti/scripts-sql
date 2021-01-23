USE [ColumnStoreIndexGlimpse]
go

SELECT DC.Sk_ID, COUNT(FVI.QuantidadePedido) AS Quantidade
FROM dbo.FatoVendasInternet AS FVI
LEFT OUTER JOIN dbo.DimCliente AS DC
ON FVI.Sk_IDCliente = DC.Sk_ID
GROUP BY DC.Sk_ID
ORDER BY COUNT(FVI.QuantidadePedido) DESC

SELECT DC.Sk_ID, COUNT(FVI.QuantidadePedido) AS Quantidade
FROM dbo.FatoVendasInternet AS FVI
RIGHT OUTER JOIN dbo.DimCliente AS DC
ON FVI.Sk_IDCliente = DC.Sk_ID
GROUP BY DC.Sk_ID
ORDER BY COUNT(FVI.QuantidadePedido) DESC

--DROP TABLE tempdb.dbo.FatoVendasInternetParte1

SELECT TOP 1000000 *
INTO tempdb.dbo.FatoVendasInternetParte1
FROM FatoVendasInternet

SELECT FVI.Sk_IDCliente, COUNT(FVI.QuantidadePedido) AS Quantidade
FROM FatoVendasInternet AS FVI
WHERE Sk_ID IN (SELECT Sk_ID FROM tempdb.dbo.FatoVendasInternetParte1)
GROUP BY FVI.Sk_IDCliente 
ORDER BY FVI.Sk_IDCliente

GO

--DROP TABLE tempdb.dbo.FatoVendasInternetParte2

SELECT TOP 50000 *
INTO tempdb.dbo.FatoVendasInternetParte2
FROM FatoVendasInternet

SELECT FVI.Sk_IDCliente, COUNT(FVI.QuantidadePedido) AS Quantidade
FROM FatoVendasInternet AS FVI
WHERE Sk_ID IN (SELECT Sk_ID FROM tempdb.dbo.FatoVendasInternetParte2)
GROUP BY FVI.Sk_IDCliente 
ORDER BY FVI.Sk_IDCliente

GO
go

-----------------------------------
-----------------------------------
USE SQLSaturdayColumnStoreIndex
go

SELECT TOP 10 *
FROM dbo.FatoAtendimento

SELECT SUM(vlReclamado) AS Valor1, SUM(vlRecuperado) AS Valor2, COUNT(*) AS Quantidade
FROM dbo.FatoAtendimento AS FA
INNER JOIN dbo.DimDetalheAtendimento AS A
ON FA.idAtendimento = A.idAtendimento
WHERE coStatusAtendimento = 'B'
	AND FA.idAtendimento > 8570703 


SELECT idPosto, SUM(vlReclamado) AS Valor1, SUM(vlRecuperado) AS Valor2, COUNT(*) AS Quantidade, 
	   AVG(vlReclamado) AS Media1,  AVG(vlRecuperado) AS Media2 
FROM dbo.FatoAtendimento AS FA
INNER JOIN dbo.DimDetalheAtendimento AS A
ON FA.idAtendimento = A.idAtendimento
WHERE coStatusAtendimento = 'B'
GROUP BY idPosto


