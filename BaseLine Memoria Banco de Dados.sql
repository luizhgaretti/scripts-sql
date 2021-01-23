USE master
GO

WITH DB_Buffer_Pages 
AS
(
	SELECT
		database_id,
		BuffersPorPagina = COUNT_BIG(*)
	FROM sys.dm_os_buffer_descriptors
	GROUP BY database_id
)

INSERT [SERV-DBPRODCL04].[ADM_DBAMonitoria].[dbo].[BaseLineMemBanco]
SELECT
	@@SERVERNAME,
	database_id as DatabaseID,
	CASE [database_id] WHEN 32767 
		THEN 'RECURSO SQL SERVER' 
		ELSE DB_NAME(database_id) END AS DatabaseName,
	BuffersPorPagina,
	(CONVERT(NUMERIC(10,2),BuffersPorPagina*8)/1024) AS BuffersPorMB,
	GETDATE() AS Data
FROM DB_Buffer_Pages
ORDER BY BuffersPorPagina DESC, BuffersPorMB DESC
GO