-- Retorna data da ultima statistics
Select OBJECT_NAME(OBJECT_ID) Tabela, 
Name as Indice, STATS_DATE(OBJECT_ID, index_id) as DataAtualizado
From sys.indexes where is_hypothetical = 0
And OBJECT_NAME(OBJECT_ID) not like 'sys%'
Order by OBJECT_NAME(OBJECT_ID)