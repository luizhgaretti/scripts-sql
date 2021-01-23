INSERT INTO  [SERV-DBPRODCL04].[ADM_DBAMonitoria].[dbo].[BaseLineCPU]
SELECT
	@@SERVERNAME AS ServerName,
	SUM(signal_wait_time_ms)	AS SignalWaitTime_ms,
	CAST(100.0*SUM(signal_wait_time_ms)/SUM(wait_time_ms) AS NUMERIC(20,2)) AS PercentSignalCPUWaits,
	SUM(wait_time_ms - signal_wait_time_ms) AS ResourceWaitTime_ms,
	CAST(100.0*SUM(wait_time_ms-signal_wait_time_ms)/SUM(wait_time_ms) AS NUMERIC(20,2)) AS PercentResourceWaits,
	GETDATE() AS DataHora
	FROM sys.dm_os_wait_stats 
GO
