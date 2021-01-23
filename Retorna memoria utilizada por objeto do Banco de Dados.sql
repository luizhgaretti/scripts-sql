/************************************************************************
	Script: Retorna Quantidade de Memoria que cada Objeto do BD está utilizando (Buffer)
	Data: 07/05/2014
	Autor: Luiz Henrique Garetti
************************************************************************/

Select
	DB_NAME(db_id()) DatabaseName,
	Result.ObjectName,
	COUNT(*) AS cached_pages_count,
	index_id
 FROM sys.dm_os_buffer_descriptors A
Inner Join
(	Select 
		OBJECT_NAME(object_id) as ObjectName,
		A.allocation_unit_id,
		type_desc,
		index_id,
		rows
	From sys.allocation_units A, sys.partitions B
	Where A.container_id = B.hobt_id
	AND (A.type = 1 or A.type = 3)

	Union all

	SELECT
		OBJECT_NAME(object_id) as ObjectName,
		allocation_unit_id,
		type_desc,
		index_id,
		rows
	FROM sys.allocation_units AS au
		INNER JOIN sys.partitions AS p
			ON au.container_id = p.partition_id
			AND au.type = 2
			) as Result
On A.allocation_unit_id = Result.allocation_unit_id
Where database_id = db_id()
GROUP BY
	Result.ObjectName,
	index_id
Order by cached_pages_count desc
