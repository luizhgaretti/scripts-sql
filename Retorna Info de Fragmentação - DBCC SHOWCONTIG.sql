/*
========================================
= Executando o comando DBCC SHOWCONTIG =
========================================
*/

-- Exibe informa��es de fragmenta��o para os dados e �ndices da tabela ou exibi��o especificada

--OBS:
-- Esse recurso ser� removido em uma vers�o futura do Microsoft SQL Server. N�o utilize esse recurso em desenvolvimentos novos e modifique, 
   -- assim que poss�vel, os aplicativos que atualmente o utilizam. Use sys.dm_db_index_physical_stats.
-- No SQL Server 2012 ainda Funciona

Declare @Table_id int
SET @Table_id = OBJECT_ID('TB1')

DBCC SHOWCONTIG(@Table_id)
