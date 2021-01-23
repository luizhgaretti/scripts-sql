-- Identificar quantas paginas de dados a tabela está ocupando
Select rows as QtdLinhas, data_pages Paginas8k, index_id
From sys.partitions P
Inner Join sys.allocation_units A
	on p.hobt_id = A.container_id
Where p.object_id = object_id('Tabela1')
and index_id in (0,1)