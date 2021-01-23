-- DBCC DROPCLEANBUFFERS

/************************************************************************
	Script: Retorna Quantidade de Memoria que cada BD está utilizando (Buffer)
	Data: 06/05/2014
	Autor: Luiz Henrique Garetti
************************************************************************/
WITH DB_Buffer_Pages 
AS
(
	SELECT
		database_id,
		BuffersPorPagina = COUNT_BIG(*)
	FROM sys.dm_os_buffer_descriptors
	GROUP BY database_id
)

SELECT
	database_id as DatabaseID,
	CASE [database_id] WHEN 32767 
		THEN 'Recurso do SQL SERVER' 
		ELSE DB_NAME(database_id) END AS DatabaseName,
	BuffersPorPagina,
	(CONVERT(NUMERIC(10,2),BuffersPorPagina*8)/1024) AS BuffersPorMB
FROM DB_Buffer_Pages
ORDER BY BuffersPorPagina DESC, BuffersPorMB DESC
GO
