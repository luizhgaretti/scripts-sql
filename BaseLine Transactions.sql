INSERT [SERV-DBPRODCL04].[ADM_DBAMonitoria].[dbo].[BaseLineTransactions]
SELECT
	@@SERVERNAME										AS ServerName,
	pc.instance_name									AS DatabaseName,
	pc.cntr_value										AS QTDTransactions,
	CASE WHEN (pc.cntr_value - B.qtdtransactions) IS NULL
		THEN 0
		ELSE (pc.cntr_value - B.qtdtransactions) END Transactions_Hora,
	
	CASE WHEN ((CONVERT(NUMERIC(10,2),pc.cntr_value-B.qtdtransactions)/60)) IS NULL
		THEN 0
		ELSE ((CONVERT(NUMERIC(10,2),pc.cntr_value-B.qtdtransactions)/60)) END Transactions_Min,
	
	CASE WHEN ((CONVERT(NUMERIC(10,2),pc.cntr_value-B.qtdtransactions)/3600)) IS NULL
		THEN 0
		ELSE ((CONVERT(NUMERIC(10,2),pc.cntr_value-B.qtdtransactions)/3600)) END Transactions_Seg,
	GETDATE()											AS DataHora
FROM sys.dm_os_performance_counters pc
INNER JOIN [SERV-DBPRODCL04].[ADM_DBAMonitoria].[dbo].[BaseLineTransactions] b
	ON Pc.instance_name = B.DatabaseName
WHERE counter_name = 'transactions/sec'
AND ServerName = @@SERVERNAME
AND (B.DataHora = (SELECT MAX(DataHora) FROM [SERV-DBPRODCL04].[ADM_DBAMonitoria].[dbo].[BaseLineTransactions] WHERE ServerName = @@SERVERNAME) OR B.DataHora IS NULL)
ORDER BY pc.cntr_value
GO