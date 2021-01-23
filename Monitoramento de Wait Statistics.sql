/*
	Script: Monitoramento de Wait Statistics
	Data: 18/08/2014
	Regra: A logica desse script está configurada para enviar as informações no dia 1 do mes subsequente, ou seja,
		   os dados do mês 6 serão enviados no dia 1 do mês 7 e assim por diante.
		   A tabela WaitStats armazena informações de 3 meses como historico(Mes corrente e mais dois anteriores)
*/

USE MASTER
GO

IF EXISTS (SELECT 1 FROM sys.tables WHERE name LIKE 'WaitStats')
BEGIN
	DROP TABLE WaitStats
END
 
CREATE TABLE dbo.WaitStats
(
	WaitType	NVARCHAR(255),
    Wait_S		DECIMAL (16, 2),
    Resource_S	DECIMAL (16, 2),
    Signal_S	DECIMAL (16, 2),
    WaitCount	BIGINT,
    Percentage	DECIMAL (5, 2),
    AvgWait_S	DECIMAL (16, 4),
    AvgRes_S	DECIMAL (16, 4),
    AvgSig_S	DECIMAL (16, 4),
	Data		DATETIME
)

DECLARE @MinDate			DATETIME,
		@HTML_Parte1		VARCHAR(MAX),
		@HTML_TailParte1	VARCHAR(MAX),
		@HTML_BodyParte1	VARCHAR(MAX),
		@HTML_BodyFinal		VARCHAR(MAX),
		@HTML_BodyFinal2	VARCHAR(MAX),
		@HTML_Parte2		VARCHAR(MAX),
		@HTML_TailParte2	VARCHAR(MAX),
		@HTML_BodyParte2	VARCHAR(MAX),
		@HTML_Final			VARCHAR(MAX)

-- Coleta as Waits Statistics Atuais
WITH [Waits] AS
    (SELECT
        [wait_type]											AS [wait_type],
        [wait_time_ms] / 1000.0								AS [WaitS],
        ([wait_time_ms] - [signal_wait_time_ms]) / 1000.0	AS [ResourceS],
        [signal_wait_time_ms] / 1000.0						AS [SignalS],
        [waiting_tasks_count]								AS [WaitCount],
        100.0 * [wait_time_ms] / SUM ([wait_time_ms]) OVER() AS [Percentage], ROW_NUMBER() OVER(ORDER BY [wait_time_ms] DESC) AS [RowNum]
    FROM sys.dm_os_wait_stats
    WHERE [wait_type] NOT IN(
        N'BROKER_EVENTHANDLER',         N'BROKER_RECEIVE_WAITFOR',
        N'BROKER_TASK_STOP',            N'BROKER_TO_FLUSH',
        N'BROKER_TRANSMITTER',          N'CHECKPOINT_QUEUE',
        N'CHKPT',                       N'CLR_AUTO_EVENT',
        N'CLR_MANUAL_EVENT',            N'CLR_SEMAPHORE',
        N'DBMIRROR_DBM_EVENT',          N'DBMIRROR_EVENTS_QUEUE',
        N'DBMIRROR_WORKER_QUEUE',       N'DBMIRRORING_CMD',
        N'DIRTY_PAGE_POLL',             N'DISPATCHER_QUEUE_SEMAPHORE',
        N'EXECSYNC',                    N'FSAGENT',
        N'FT_IFTS_SCHEDULER_IDLE_WAIT', N'FT_IFTSHC_MUTEX',
        N'HADR_CLUSAPI_CALL',           N'HADR_FILESTREAM_IOMGR_IOCOMPLETION',
        N'HADR_LOGCAPTURE_WAIT',        N'HADR_NOTIFICATION_DEQUEUE',
        N'HADR_TIMER_TASK',             N'HADR_WORK_QUEUE',
        N'KSOURCE_WAKEUP',              N'LAZYWRITER_SLEEP',
        N'LOGMGR_QUEUE',                N'ONDEMAND_TASK_QUEUE',
        N'PWAIT_ALL_COMPONENTS_INITIALIZED',
        N'QDS_PERSIST_TASK_MAIN_LOOP_SLEEP',
        N'QDS_CLEANUP_STALE_QUERIES_TASK_MAIN_LOOP_SLEEP',
        N'REQUEST_FOR_DEADLOCK_SEARCH', N'RESOURCE_QUEUE',
        N'SERVER_IDLE_CHECK',           N'SLEEP_BPOOL_FLUSH',
        N'SLEEP_DBSTARTUP',             N'SLEEP_DCOMSTARTUP',
        N'SLEEP_MASTERDBREADY',         N'SLEEP_MASTERMDREADY',
        N'SLEEP_MASTERUPGRADED',        N'SLEEP_MSDBSTARTUP',
        N'SLEEP_SYSTEMTASK',            N'SLEEP_TASK',
        N'SLEEP_TEMPDBSTARTUP',         N'SNI_HTTP_ACCEPT',
        N'SP_SERVER_DIAGNOSTICS_SLEEP', N'SQLTRACE_BUFFER_FLUSH',
        N'SQLTRACE_INCREMENTAL_FLUSH_SLEEP',
        N'SQLTRACE_WAIT_ENTRIES',       N'WAIT_FOR_RESULTS',
        N'WAITFOR',                     N'WAITFOR_TASKSHUTDOWN',
        N'WAIT_XTP_HOST_WAIT',          N'WAIT_XTP_OFFLINE_CKPT_NEW_LOG',
        N'WAIT_XTP_CKPT_CLOSE',         N'XE_DISPATCHER_JOIN',
        N'XE_DISPATCHER_WAIT',          N'XE_TIMER_EVENT')
    )
	INSERT WaitStats (WaitType,Wait_S,Resource_S,Signal_S,WaitCount,Percentage,AvgWait_S,AvgRes_S,AvgSig_S,Data)
		SELECT
			[W1].[wait_type]												AS WaitType,
			CAST ([W1].[WaitS] AS DECIMAL (16, 2))							AS Wait_S,
			CAST ([W1].[ResourceS] AS DECIMAL (16, 2))						AS Resource_S,
			CAST ([W1].[SignalS] AS DECIMAL (16, 2))						AS Signal_S,
			[W1].[WaitCount]												AS WaitCount,
			CAST ([W1].[Percentage] AS DECIMAL (5, 2))						AS Percentage,
			CAST (([W1].[WaitS] / [W1].[WaitCount]) AS DECIMAL (16, 4))		AS AvgWait_S,
			CAST (([W1].[ResourceS] / [W1].[WaitCount]) AS DECIMAL (16, 4)) AS AvgRes_S,
			CAST (([W1].[SignalS] / [W1].[WaitCount]) AS DECIMAL (16, 4))	AS AvgSig_S,
			GETDATE()														AS Data
		FROM [Waits] AS [W1]
		INNER JOIN [Waits] AS [W2]
			ON [W2].[RowNum] <= [W1].[RowNum]
		GROUP BY [W1].[RowNum], [W1].[wait_type], [W1].[WaitS],
				 [W1].[ResourceS], [W1].[SignalS], [W1].[WaitCount], [W1].[Percentage]
		HAVING SUM ([W2].[Percentage]) - [W1].[Percentage] < 95; -- percentage threshold


IF DAY(GETDATE()) = 1
BEGIN
-- 1º ALERTA: Resumo Mensal Geral
	SET @HTML_Parte1 = '<html>'
	SET @HTML_Parte1 = @HTML_Parte1 + '<head>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte1 = @HTML_Parte1 + ' <style>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte1 = @HTML_Parte1 + ' body{font-family: arial; font-size: 13px;}table{font-family: arial; font-size: 13px; border-collapse: collapse;width:100%} td {padding: 2px;height:15px;border:solid 1px black;} th {padding: 2px;background-color:black;color:white;border:solid 1px black;}' + CHAR(13) + CHAR(10) ;
	SET @HTML_Parte1 = @HTML_Parte1 + ' </style>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte1 = @HTML_Parte1 + '</head>' + CHAR(13) + CHAR(10) ;
	SET @HTML_Parte1 = @HTML_Parte1 + '<br></br>' + CHAR(13) + CHAR(10); 
	SET @HTML_Parte1 = @HTML_Parte1 + '<body> <b>.:: Resumo Mensal Wait Statistics ::.</b><hr />' + CHAR(13) + CHAR(10) ;
	SET @HTML_Parte1 = @HTML_Parte1 + '<table>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte1 = @HTML_Parte1 + ' <tr>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte1 = @HTML_Parte1 + ' <th>WaitType</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte1 = @HTML_Parte1 + ' <th>Wait_S</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte1 = @HTML_Parte1 + ' <th>Resource_S</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte1 = @HTML_Parte1 + ' <th>Signal_S</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte1 = @HTML_Parte1 + ' <th>WaitCount</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte1 = @HTML_Parte1 + ' <th>Percentage</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte1 = @HTML_Parte1 + ' <th>AvgWait_S</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte1 = @HTML_Parte1 + ' <th>AvgRes_S</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte1 = @HTML_Parte1 + ' <th>Avgsig_S</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte1 = @HTML_Parte1 + ' <th>Data</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte1 = @HTML_Parte1 + ' </tr>' + CHAR(13) + CHAR(10);
	SET @HTML_TailParte1 = '</table></body></html>';

	SELECT @HTML_BodyParte1 = @HTML_Parte1 + (SELECT
												WaitType	AS [TD],
												Wait_S		AS [TD],
												Resource_S	AS [TD],
												Signal_S	AS [TD],
												WaitCount	AS [TD],
												Percentage	AS [TD],
												AvgWait_S	AS [TD],
												AvgRes_S	AS [TD],
												Avgsig_S	AS [TD],
												Data		AS [TD]
											   FROM WaitStats 
											   WHERE datediff(month,Data,getdate()) = 1
											   FOR XML RAW('tr') ,ELEMENTS) + @HTML_TailParte1

-- 2º ALERTA: Resumo mensal por Wait Statistics
	SET @HTML_Parte2 = '<html>'
	SET @HTML_Parte2 = @HTML_Parte2 + '<head>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte2 = @HTML_Parte2 + ' <style>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte2 = @HTML_Parte2 + ' </style>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte2 = @HTML_Parte2 + '</head>' + CHAR(13) + CHAR(10) ;
	SET @HTML_Parte2 = @HTML_Parte2 + '<br></br>' + CHAR(13) + CHAR(10); 
	SET @HTML_Parte2 = @HTML_Parte2 + '<body> <b>.:: Resumo Mensal Wait Statistics por WaitType ::.</b><hr />' + CHAR(13) + CHAR(10) ;
	SET @HTML_Parte2 = @HTML_Parte2 + '<table>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte2 = @HTML_Parte2 + ' <tr>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte2 = @HTML_Parte2 + ' <th>WaitType</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte2 = @HTML_Parte2 + ' <th>MediaMensalPorWaitType(%)</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Parte2 = @HTML_Parte2 + ' <th>Position</th>' + CHAR(13) + CHAR(10);
	SET @HTML_TailParte2 = '</table></body></html>';
	
	SELECT
		MONTH(data)			AS Data,
		WaitType			AS WaitType,
		(SUM(Percentage))	AS PercentageSUm
	INTO #temp2
	FROM WaitStats
	WHERE datediff(month,Data,getdate()) = 1
	GROUP BY WaitType,MONTH(data)

	SELECT
		Data		AS Data,
		WaitType	AS WaitType,
		100.0 * PercentageSUm/ SUM(PercentageSUm) OVER() AS PercentageSUm, ROW_NUMBER() OVER(ORDER BY PercentageSUm DESC) AS Position
	INTO #temp3
	FROM #temp2

	SELECT @HTML_BodyParte2 = @HTML_Parte2 + (SELECT
												WaitType		AS [TD],
												PercentageSUm	AS [TD],
												Position		AS [TD]
												FROM #temp3 
												FOR XML RAW('tr') ,ELEMENTS) + @HTML_TailParte2
						
	SET @HTML_Final =  @HTML_BodyParte1 + CHAR(10) +  CHAR(10) +  @HTML_BodyParte2 -- Monta corpo do email
		
	EXEC MSDB..SP_SEND_DBMAIL
	@profile_name = 'DBARGM',
	@RECIPIENTS = 'dba@rgm.com.br',
	@body = @HTML_Final,
	@body_format = 'HTML',
	@SUBJECT = 'Departamento de Banco de Dados - RGM',
	@importance= 'High'

	SET @MinDate = (SELECT MIN(data) FROM WaitStats)

	IF (DATEDIFF(MONTH,@MinDate,GETDATE())> 2)
	BEGIN
		DELETE FROM WaitStats
		WHERE MONTH(Data) <= MONTH(@MinDate)
		AND YEAR(data) <= YEAR(@MinDate)
	END
	DROP TABLE #temp2
	DROP TABLE #temp3
	END
GO