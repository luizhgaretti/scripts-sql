/*
========================================
= Executando o comando DBCC SHOWCONTIG =
========================================
*/

-- Exibe informações de fragmentação para os dados e índices da tabela ou exibição especificada

--OBS:
-- Esse recurso será removido em uma versão futura do Microsoft SQL Server. Não utilize esse recurso em desenvolvimentos novos e modifique, 
   -- assim que possível, os aplicativos que atualmente o utilizam. Use sys.dm_db_index_physical_stats.
-- No SQL Server 2012 ainda Funciona

Declare @Table_id int
SET @Table_id = OBJECT_ID('TB1')

DBCC SHOWCONTIG(@Table_id)
