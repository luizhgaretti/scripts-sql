/***********************************************************************************************************************
	SCRIPT: Cria Procedures e alertas utilizados no Monitoramento do Ambiente Alwayson.
			- Monitora:
				- Failover
				- Trocar de Status de todas as maquinas envolvidas no Alwayson
				- Perda de conexão entre (Principal => Secundária)
				- Perda de coñexão entre (Secundária => Principal)
	DATA: 06/08/2014

	OBSERVAÇÕES: SELECIONAR O PROFILE(SQLMAIL) CORRETO NA PROCEDURE

***********************************************************************************************************************/
USE MSDB
GO

IF EXISTS (SELECT 1 FROM dbo.sysoperators WHERE name like 'AdmAwayson')
BEGIN
	PRINT 'Operator "AdmAwayson" já existe'
END 
ELSE
BEGIN
	EXEC msdb.dbo.sp_add_operator @name=N'AdmAwayson', 
		@enabled=1, 
		@weekday_pager_start_time=80000, 
		@weekday_pager_end_time=180000, 
		@saturday_pager_start_time=80000, 
		@saturday_pager_end_time=180000, 
		@sunday_pager_start_time=80000, 
		@sunday_pager_end_time=180000, 
		@pager_days=0, 
		@email_address=N'dba@rgm.com.br', 
		@category_name=N'[Uncategorized]'
		PRINT 'Criando operator "AdmAwayson"...'
END
GO

/***********************************************************************************************************************
--													PROCEDURES
***********************************************************************************************************************/
/*
	PROCEDURE: AlertStatsDBAlwayson
	DATA: 28/07/2014
	OBJETIVO: Procedure coleta status dos banco de dados Participantes do Alwayson e enviar por E-mail.
			  Quando o Principal perder conexão com uma réplica, Um JOB é ativado e dispara e-mail com result dessa Proc.
			  Afim de avaliar Crecimento de LOG do BD Primário como outroas informações relevantes.
*/
USE MASTER
GO

IF EXISTS (SELECT 1 FROM sys.procedures WHERE name LIKE 'AlertStatsDBAlwayson')
BEGIN
	DROP PROCEDURE AlertStatsDBAlwayson
END
GO

CREATE PROCEDURE dbo.AlertStatsDBAlwayson
AS
	SET NOCOUNT ON

	DECLARE @HTML_Alwasyon		VARCHAR(MAX)
	DECLARE @HTML_TailAlwasyon	VARCHAR(MAX)
	DECLARE @HTML_BodyAlwasyon	VARCHAR(MAX)
	DECLARE @HTML_Log			VARCHAR(MAX)
	DECLARE @HTML_TailLog		VARCHAR(MAX)
	DECLARE @HTML_BodyLog		VARCHAR(MAX)
	DECLARE @HTML_BodyFinal		VARCHAR(MAX)

-- Parte Alwayson
	SELECT
		group_id,
		name
	INTO #tmpag_availability_groups
	FROM master.sys.availability_groups

	SELECT
		group_id,
		replica_id,
		replica_server_name,
		availability_mode_desc
		INTO #tmpdbr_availability_replicas
		FROM master.sys.availability_replicas
		
	SELECT
		replica_id,
		group_database_id,
		database_name
	INTO #tmpdbr_database_replica_cluster_states
	FROM master.sys.dm_hadr_database_replica_cluster_states

	SELECT
		*
	INTO #tmpdbr_database_replica_states
	FROM master.sys.dm_hadr_database_replica_states

	SELECT
		replica_id,
		role,
		role_desc
	INTO #tmpdbr_availability_replica_states
	FROM master.sys.dm_hadr_availability_replica_states

	SELECT
		ars.role,
		drs.database_id,
		drs.replica_id,
		drs.last_commit_time
	INTO #tmpdbr_database_replica_states_primary_LCT
	FROM #tmpdbr_database_replica_states as drs
	LEFT JOIN #tmpdbr_availability_replica_states ars
		ON drs.replica_id = ars.replica_id
	WHERE ars.role = 1
   
	-- Result1: Alwayson
	SELECT
		AG.name										AS GroupName,
		AR.replica_server_name						AS ServerName,
		dbcs.database_name							AS DatabaseName,
		arstates.role_desc							AS Role,
		ISNULL(dbr.last_commit_time, 0)				AS LastCommitTime,
		ISNULL(dbr.log_send_queue_size, -1)			AS LogSendQueueSizeKB,			-- Quantidade de Log do Primario não enviado ao Secundário
		ISNULL(dbr.log_send_rate, -1)				AS LogSendRateKB,					-- Taxa de log enviado aos secundários kb/s
		ISNULL(dbr.redo_queue_size, -1)				AS RedoQueueSizeKB,				-- A quantidade de registros de log nos arquivos de log da réplica secundária que ainda não foram refeitos, em KB.
		ISNULL(dbr.redo_rate, -1)					AS RedoRateKB,					-- A taxa na qual os registros de log estão sendo refeitos em um banco de dados secundário, em KB/segundo.
		availability_mode_desc						AS ReplicaAvailabilityMode,
		synchronization_state_desc					AS SynchronizationState
	INTO #Result
	FROM #tmpag_availability_groups AS AG
		INNER JOIN #tmpdbr_availability_replicas AS AR
			ON AR.group_id=AG.group_id
		INNER JOIN #tmpdbr_database_replica_cluster_states AS dbcs
			ON dbcs.replica_id = AR.replica_id
		LEFT OUTER JOIN #tmpdbr_database_replica_states AS dbr
			ON dbcs.replica_id = dbr.replica_id
			AND dbcs.group_database_id = dbr.group_database_id
		LEFT OUTER JOIN #tmpdbr_database_replica_states_primary_LCT AS dbrp
			ON dbr.database_id = dbrp.database_id
		INNER JOIN #tmpdbr_availability_replica_states AS arstates
			ON arstates.replica_id = AR.replica_id
	ORDER BY GroupName ASC, Role ASC

	SET @HTML_Alwasyon = '<html>'
	SET @HTML_Alwasyon = @HTML_Alwasyon + '<head>' + CHAR(13) + CHAR(10);
	SET @HTML_Alwasyon = @HTML_Alwasyon + ' <style>' + CHAR(13) + CHAR(10);
	SET @HTML_Alwasyon = @HTML_Alwasyon + ' body{font-family: arial; font-size: 13px;}table{font-family: arial; font-size: 13px; border-collapse: collapse;width:100%;text-align:center;} td {color:black;padding: 2px;height:15px;background-color:#F8F8FF;border:1px solid;} th {padding: 2px;background-color:#CDCDC1;color:black;border:1px solid;}' + CHAR(13) + CHAR(10);
	SET @HTML_Alwasyon = @HTML_Alwasyon + ' </style>' + CHAR(13) + CHAR(10);
	SET @HTML_Alwasyon = @HTML_Alwasyon + '</head>' + CHAR(13) + CHAR(10) ;
	SET @HTML_Alwasyon = @HTML_Alwasyon + '<br></br>' + CHAR(13) + CHAR(10); 
	SET @HTML_Alwasyon = @HTML_Alwasyon + '<body> <b>.:: Alwayson Group Stats ::.</b><hr/>' + CHAR(13) + CHAR(10) ;
	SET @HTML_Alwasyon = @HTML_Alwasyon + '<table>' + CHAR(13) + CHAR(10) ;
	SET @HTML_Alwasyon = @HTML_Alwasyon + ' <tr>' + CHAR(13) + CHAR(10) ;
	SET @HTML_Alwasyon = @HTML_Alwasyon + ' <th>GroupName</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Alwasyon = @HTML_Alwasyon + ' <th>ServerName</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Alwasyon = @HTML_Alwasyon + ' <th>DatabaseName</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Alwasyon = @HTML_Alwasyon + ' <th>Role</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Alwasyon = @HTML_Alwasyon + ' <th>LastCommitTime</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Alwasyon = @HTML_Alwasyon + ' <th>LogSendQueueSizeKB</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Alwasyon = @HTML_Alwasyon + ' <th>LogSendRateKB</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Alwasyon = @HTML_Alwasyon + ' <th>RedoQueueSizeKB</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Alwasyon = @HTML_Alwasyon + ' <th>RedoRateKB</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Alwasyon = @HTML_Alwasyon + ' <th>ReplicaAvailabilityMode</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Alwasyon = @HTML_Alwasyon + ' <th>SynchronizationState</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Alwasyon = @HTML_Alwasyon + ' </tr>' + CHAR(13) + CHAR(10);
	SET @HTML_TailAlwasyon = '</table></body></html>';

	SELECT @HTML_BodyAlwasyon = @HTML_Alwasyon + 
								(SELECT 
									GroupName					AS [TD],
									ServerName					AS [TD],
									DatabaseName				AS [TD],
									Role						AS [TD],
									LastCommitTime				AS [TD],
									LogSendQueueSizeKB			AS [TD],
									LogSendRateKB				AS [TD],
									RedoQueueSizeKB				AS [TD],
									RedoRateKB					AS [TD],
									ReplicaAvailabilityMode		AS [TD],
									SynchronizationState		AS [TD]
								 FROM #Result
								 ORDER BY GroupName ASC, Role ASC
								 FOR XML RAW('tr') ,ELEMENTS) + @HTML_TailAlwasyon

	-- Parte Transaction Log
	CREATE TABLE #DBINFORMATION2
	(
		ServerName			VARCHAR(100)Not Null, 
		DatabaseName		VARCHAR(100)Not Null, 
		LogicalFileName		SYSNAME Not Null, 
		PhysicalFileName	NVARCHAR(520), 
		FileSizeMB			INT,
		Status				SYSNAME, 
		RecoveryMode		SYSNAME, 
		FreeSpaceMB			INT, 
		FreeSpacePct		INT, 
		Dateandtime			VARCHAR(10) not null
	)

	ALTER TABLE #DBINFORMATION2 
	ADD CONSTRAINT Comb_SNDNDT2_3 UNIQUE(ServerName, DatabaseName, Dateandtime,LogicalFileName)

	ALTER TABLE #DBINFORMATION2
	ADD CONSTRAINT Pk_SNDNDT2_3 PRIMARY KEY (ServerName, DatabaseName, Dateandtime,LogicalFileName)

	/* I found the code snippet below on the web from another DB Forum and tweaked it as per my need. So Lets take a moment to appreciate the person who has made this available for us*/
	DECLARE @command		VARCHAR(5000),
			@DatabaseName	VARCHAR(100),
			@Pct			SMALLINT,
	        @FileSizeMB		INT,
		    @Status			SYSNAME, 
		    @FreeSpaceMB	INT, 
			@FreeSpacePct	INT, 
			@CONTROLE		SMALLINT
        
	SELECT @command =	'Use [' + '?' + '] SELECT 
						@@servername as ServerName, 
						' + '''' + '?' + '''' + ' AS DatabaseName, 
						Cast (sysfiles.size/128.0 AS int) AS FileSizeMB, 
						sysfiles.name AS LogicalFileName, sysfiles.filename AS PhysicalFileName, 
						CONVERT(sysname,DatabasePropertyEx(''?'',''Status'')) AS Status, 
						CONVERT(sysname,DatabasePropertyEx(''?'',''Recovery'')) AS RecoveryMode, 
						CAST(sysfiles.size/128.0 - CAST(FILEPROPERTY(sysfiles.name, ' + '''' + 
						'SpaceUsed' + '''' + ' ) AS int)/128.0 AS int) AS FreeSpaceMB, 
						CAST(100 * (CAST (((sysfiles.size/128.0 -CAST(FILEPROPERTY(sysfiles.name, 
						' + '''' + 'SpaceUsed' + '''' + ' ) AS int)/128.0)/(sysfiles.size/128.0)) 
						AS decimal(4,2))) as Int) AS FreeSpacePct, CONVERT(VARCHAR(10),GETDATE(),111) as dateandtime 
						FROM dbo.sysfiles' 
	
	INSERT INTO #DBINFORMATION2 (ServerName, DatabaseName, FileSizeMB,  LogicalFileName, PhysicalFileName, 
								 Status, RecoveryMode, FreeSpaceMB, FreeSpacePct, dateandtime) 
	EXEC sp_MSForEachDB @command

	SELECT	
		CONVERT(VARCHAR(100),LTRIM(RTRIM(databasename)))		AS DatabaseName,
		CONVERT(VARCHAR(100),LTRIM(RTRIM(PhysicalFileName)))	AS PhysicalFileName, 
		FileSizeMB												AS FileSizeMB,
		CONVERT(VARCHAR(100),LTRIM(RTRIM(Status)))				AS Status,
		FreeSpaceMB												AS FreeSpaceMB,
		FreeSpacePct											AS FreeSpacePct
	INTO #Result2
	FROM #dbinformation2
	WHERE PhysicalFileName like '%.ldf' 
	and databasename not in ('model','msdb')
	ORDER BY databasename

	SET @HTML_Log = '<html>'
	SET @HTML_Log = @HTML_Log + '<head>' + CHAR(13) + CHAR(10);
	SET @HTML_Log = @HTML_Log + ' <style>' + CHAR(13) + CHAR(10);
	SET @HTML_Log = @HTML_Log + ' </style>' + CHAR(13) + CHAR(10);
	SET @HTML_Log = @HTML_Log + '</head>' + CHAR(13) + CHAR(10) ;
	SET @HTML_Log = @HTML_Log + '<br></br>'	+ CHAR(13) + CHAR(10); 
	SET @HTML_Log = @HTML_Log + '<body> <b>.:: Informações Gerais - Transaction Log ::.</b><hr />' + CHAR(13) + CHAR(10) ;
	SET @HTML_Log = @HTML_Log + '<table>' + CHAR(13) + CHAR(10) ;
	SET @HTML_Log = @HTML_Log + ' <tr>'	+ CHAR(13) + CHAR(10) ;
	SET @HTML_Log = @HTML_Log + ' <th>DatabaseName</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Log = @HTML_Log + ' <th>PhysicalFileName</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Log = @HTML_Log + ' <th>FileSizeMB</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Log = @HTML_Log + ' <th>Status</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Log = @HTML_Log + ' <th>FreeSpaceMB</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Log = @HTML_Log + ' <th>FreeSpacePct</th>' + CHAR(13) + CHAR(10);
	SET @HTML_Log = @HTML_Log + ' </tr>' + CHAR(13) + CHAR(10);
	SET @HTML_TailLog = '</table></body></html>';

	SELECT @HTML_BodyLog = @HTML_Log + 
								(SELECT 
									DatabaseName		AS [TD],
									PhysicalFileName	AS [TD],
									FileSizeMB			AS [TD],
									Status				AS [TD],
									FreeSpaceMB			AS [TD],
									FreeSpacePct		AS [TD]									
								 FROM #Result2
								 ORDER BY DatabaseName ASC
								 FOR XML RAW('tr') ,ELEMENTS) + @HTML_TailLog

	-- Enviando e-mail
	SET @HTML_BodyFinal =	'<b>' + '- LogSendQueueSizeKB	:' + '</b>' + 'Amount of log records of the primary database that has not been sent to the secondary databases, in kilobytes (KB).' + '<br>' + 
							'<b>' + '- LogSendRateKB		:' + '</b>' + 'Rate at which log records are being sent to the secondary databases, in kilobytes (KB)/second.' + '<br>' + 
							'<b>' + '- RedoQueueSizeKB		:' + '</b>' + 'Amount of log records in the log files of the secondary replica that has not yet been redone, in kilobytes (KB).' + '<br>' + 
							'<b>' + '- RedoRateKB			:' + '</b>' + 'Rate at which the log records are being redone on a given secondary database, in kilobytes (KB)/second.' + '<br>' + '<br>' + '<hr>' + '<hr>' + 
							@HTML_BodyAlwasyon + CHAR(10) + CHAR(10)+  @HTML_BodyLog + CHAR(10) + CHAR(10) + '<br></br>' 

	EXEC MSDB..SP_SEND_DBMAIL
		@profile_name = 'DBARGM',
		@RECIPIENTS = 'dba@rgm.com.br',
		@body = @HTML_BodyFinal,
   		@body_format = 'HTML',
   		@SUBJECT = 'Departamento de Banco de Dados - RGM',
		@importance= 'High'
	
	DROP TABLE #tmpdbr_availability_replicas
    DROP TABLE #tmpdbr_database_replica_cluster_states
    DROP TABLE #tmpdbr_database_replica_states
    DROP TABLE #tmpdbr_database_replica_states_primary_LCT
    DROP TABLE #tmpdbr_availability_replica_states
    DROP TABLE #tmpag_availability_groups
	DROP TABLE #Result
	DROP TABLE #DBINFORMATION2
	DROP TABLE #Result2

	SET NOCOUNT OFF
GO
PRINT 'Criando Procedure "AlertStatsDBAlwayson"...'
GO


/***********************************************************************************************************************
--														JOBs
***********************************************************************************************************************/
USE MSDB
GO

IF EXISTS (SELECT * FROM dbo.sysjobs WHERE name LIKE 'ADM DB Alwayson Status Maintenance Enable')
BEGIN
	EXEC sp_delete_job @job_name = N'ADM DB Alwayson Status Maintenance Enable';
End
GO
BEGIN TRANSACTION
	DECLARE @ReturnCode INT
	SELECT @ReturnCode = 0

	IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
	BEGIN
		EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
		IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	END

	DECLARE @jobId BINARY(16)
	EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'ADM DB Alwayson Status Maintenance Enable', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Habilta o JOB "ADM BD Alwayson Status Email" em caso de falha, perda de conexão do Alwayson(Primaria-> Secundária)', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'AdmAwayson', @job_id = @jobId OUTPUT

	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'EnableJOB', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'use msdb

EXEC dbo.sp_update_job
@job_name = N''ADM DB Alwayson Status Email'',
@enabled = 1;', 
		@database_name=N'msdb', 
		@output_file_name=N'D:\teste.txt', 
		@flags=6

	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
		EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
		EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
		COMMIT TRANSACTION
		GOTO EndSave
		QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
	EndSave:
GO
PRINT 'Criando JOB "ADM DB Alwayson Status Maintenance Enable"...'
GO


IF EXISTS (SELECT * FROM dbo.sysjobs WHERE name LIKE 'ADM DB Alwayson Status Maintenance Disable')
BEGIN
	EXEC sp_delete_job @job_name = N'ADM DB Alwayson Status Maintenance Disable';
END
GO
BEGIN TRANSACTION
	DECLARE @ReturnCode INT
	SELECT @ReturnCode = 0

	IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
	BEGIN
		EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
		IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	END

	DECLARE @jobId BINARY(16)
	EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'ADM DB Alwayson Status Maintenance Disable', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'AdmAwayson', @job_id = @jobId OUTPUT

	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'DisableJOB', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'use msdb

EXEC dbo.sp_update_job
@job_name = N''ADM DB Alwayson Status Email'',
@enabled = 0;

WAITFOR DELAY ''00:00:20'';

EXEC master..AlertStatsDBAlwayson;', 
		@database_name=N'master', 
		@flags=0

	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
		EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
		EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
		COMMIT TRANSACTION
		GOTO EndSave
		QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO
PRINT 'Criando JOB "ADM DB Alwayson Status Maintenance Disable"...'
GO


IF EXISTS (SELECT * FROM dbo.sysjobs WHERE name LIKE 'ADM DB Alwayson Status Email')
BEGIN
	EXEC sp_delete_job @job_name = N'ADM DB Alwayson Status Email';
END
GO
BEGIN TRANSACTION
	DECLARE @ReturnCode INT
	SELECT @ReturnCode = 0

	IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
	BEGIN
		EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
		IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	END

	DECLARE @jobId BINARY(16)
	EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'ADM DB Alwayson Status Email', 
		@enabled=0, 
		@notify_level_eventlog=2, 
		@notify_level_email=2, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Este Job, executa Procedure que é responsavel por enviar e-mail com informações e status sobre os bancos de dados configurados no Alwayson.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', 
		@notify_email_operator_name=N'AdmAwayson', @job_id = @jobId OUTPUT

	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Send Status Alwayson', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC master..AlertStatsDBAlwayson', 
		@database_name=N'master', 
		@flags=0

	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
		EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
	EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Send Status Alwayson', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=10, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20140723, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'180b8596-352b-443d-9f1d-f27fdf21259a'

	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
		EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
		COMMIT TRANSACTION
		GOTO EndSave
		QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
		EndSave:
GO
GO
PRINT 'Criando JOB "ADM DB Alwayson Status Email"...'
GO


/***********************************************************************************************************************
--													ALERTAS
***********************************************************************************************************************/
DECLARE @JOB1 uniqueidentifier
DECLARE @JOB2 uniqueidentifier

SET @JOB1 = (SELECT job_id FROM msdb..sysjobs WHERE name like 'ADM DB Alwayson Status Maintenance Enable')
SET @JOB2 = (SELECT job_id FROM msdb..sysjobs WHERE name like 'ADM DB Alwayson Status Maintenance Disable')

IF EXISTS (SELECT 1 FROM dbo.sysalerts WHERE name LIKE 'DBM Perf: Connection between Principal and Secundary has been successfully established')
BEGIN
	EXEC msdb.dbo.sp_delete_alert @name=N'DBM Perf: Connection between Principal and Secundary has been successfully established'
END
EXEC msdb.dbo.sp_add_alert @name=N'DBM Perf: Connection between Principal and Secundary has been successfully established', 
		@message_id=35202, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=0, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=@JOB2
EXEC msdb.dbo.sp_add_notification	@alert_name = N'DBM Perf: Connection between Principal and Secundary has been successfully established', 
									@operator_name=N'AdmAwayson', @notification_method = 1
PRINT 'Criando Alerta "DBM Perf: Connection between Principal and Secundary has been successfully established"...'

IF EXISTS (SELECT 1 FROM dbo.sysalerts WHERE name LIKE 'DBM Perf: Server instance primary is not running')
BEGIN
	EXEC msdb.dbo.sp_delete_alert @name=N'DBM Perf: Server instance primary is not running'
END
EXEC msdb.dbo.sp_add_alert @name=N'DBM Perf: Server instance primary is not running', 
		@message_id=35274, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=0, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
EXEC msdb.dbo.sp_add_notification	@alert_name = N'DBM Perf: Server instance primary is not running', 
									@operator_name=N'AdmAwayson', @notification_method = 1
PRINT 'Criando Alerta "DBM Perf: Server instance primary is not running"...'

IF EXISTS (SELECT 1 FROM dbo.sysalerts WHERE name LIKE 'DBM Perf: Change Status Alwayson Group')
BEGIN
	EXEC msdb.dbo.sp_delete_alert @name=N'DBM Perf: Change Status Alwayson Group'
END
EXEC msdb.dbo.sp_add_alert @name=N'DBM Perf: Change Status Alwayson Group', 
		@message_id=1480, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=0, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
EXEC msdb.dbo.sp_add_notification	@alert_name = N'DBM Perf: Change Status Alwayson Group', 
									@operator_name=N'AdmAwayson', @notification_method = 1
PRINT 'Criando Alerta "DBM Perf: Change Status Alwayson Group"...'

IF EXISTS (SELECT 1 FROM dbo.sysalerts WHERE name LIKE 'DBM Perf:  Server instance secundary is not running')
BEGIN
	EXEC msdb.dbo.sp_delete_alert @name=N'DBM Perf:  Server instance secundary is not running'
END
EXEC msdb.dbo.sp_add_alert @name=N'DBM Perf:  Server instance secundary is not running', 
		@message_id=35206, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=0, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=@JOB1
EXEC msdb.dbo.sp_add_notification	@alert_name = N'DBM Perf:  Server instance secundary is not running', 
									@operator_name=N'AdmAwayson', @notification_method = 1
PRINT 'Criando Alerta "DBM Perf:  Server instance secundary is not running"...'
GO