USE SQLSaturday
go


SET STATISTICS TIME ON
SET STATISTICS IO ON

SELECT COUNT(*) AS DiskTables
FROM [DadosAtendimento]

SELECT COUNT(*) AS InMemoryTables
FROM [dbo].[InMemoryDadosAtendimento]

SELECT *
FROM [DadosAtendimento]
go
SELECT *
FROM [InMemoryDadosAtendimento]

SELECT *
FROM [DadosAtendimento]
WHERE ID = 102957
go
SELECT *
FROM [InMemoryDadosAtendimento]
WHERE ID = 102957