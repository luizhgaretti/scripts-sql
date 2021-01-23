-- Retorna o tempo total de todas Wait Stats
Select * from sys.dm_os_wait_stats


-- Reinicializando as Statistics
DBCC SQLPERF ('sys.dm_os_wait_stats', CLEAR);
GO