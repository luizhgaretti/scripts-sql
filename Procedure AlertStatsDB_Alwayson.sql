/*
	Procedure: AlertStatsDBAlwayson
	Data: 28/07/2014
	Autor: Luiz Henrique Garetti
	Objetivo: Procedure coleta status dos banco de dados Participantes do Alwayson e enviar por E-mail.
			  Quando o Principal perder conexão com uma réplica, Um JOB é ativado e dispara e-mail com result dessa Proc.
			  Afim de avaliar Crecimento de LOG do BD Primário como outroas informações relevantes.
*/

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