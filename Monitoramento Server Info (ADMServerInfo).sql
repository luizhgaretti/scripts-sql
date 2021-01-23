/*
	SCRIPT	: Rotina de Saude Ambiente Semanal
	DATA	: 15/12/2015
	VERSÕES	: SQL Server 2008R2, 2012, 2014, 2016
	
	Observações:
	*Agendar com o job com script abaixo* -- Configurando para o ambiente do Cliente
	
	USE ADMServer
	GO

	EXEC sp_configure 'show advanced options',1
	GO
	RECONFIGURE
	GO
	EXEC sp_configure 'Ole Automation Procedures',1
	GO
	RECONFIGURE
	GO

	-- EXEC [spADMServerInfo] 'IP Servidor', 'Cliente', 'Profiler DatabaseMail', 'Destinatário', threshold Free Disk, threshold Free Database, 'Tipo Ambiente'

	EXEC sp_configure 'Ole Automation Procedures', 0
	GO
	RECONFIGURE
	GO
	EXEC sp_configure 'show advanced options',0
	GO
	RECONFIGURE
	GO
*/

USE ADMServer
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF EXISTS (SELECT COUNT(*) FROM sys.procedures WHERE name = 'spADMServerInfo')
BEGIN
	DROP PROCEDURE dbo.[spADMServerInfo]
END
GO

CREATE PROCEDURE [dbo].[spADMServerInfo]   (@ServerIP					VARCHAR(100),
											@Cliente					VARCHAR(50),
											@ProfileMail				VARCHAR(50),
										    @Recipients					VARCHAR(255),
											@PercentFreeSpaceDisk		TINYINT,
											@PercentFreeSpaceDatabase	TINYINT,
											@Funcao						VARCHAR(30))
WITH RECOMPILE
AS
BEGIN
	SET NOCOUNT ON

	DECLARE
			@TableHTML					VARCHAR(MAX),
			@Property					NVARCHAR(100),
			@Command					VARCHAR(5000),
			@FileSystem					VARCHAR(128),
			@Engine						VARCHAR(100),
			@PhysicalName				VARCHAR(100),
			@StrSubject					VARCHAR(100),
			@Oriserver					VARCHAR(100),
			@Edition					VARCHAR(100),
			@SP							VARCHAR(100),
			@VolumeName					VARCHAR(129),
			@Uptime						VARCHAR(50),
			@Collation					VARCHAR(50),
			@ProcessID					VARCHAR(10),
			@IsHadr						VARCHAR(3),
			@IsReady					VARCHAR(5),
			@ISClustered				VARCHAR(3),
			@DriveLetter				VARCHAR(1),	
			@StartDate					DATETIME,
			@Starttime					DATETIME,
			@MinDate					DATETIME,
			@TotalSize					BIGINT,
			@AvailableSpace				BIGINT,
			@FreeSpace					BIGINT,	
			@Çast_run_duration			INT,
			@DriveLetter_ASCII_Code		INT,
			@FileSystemInstance			INT,
			@DriveCount					INT,
			@DriveCollection			INT,
			@Drive						INT,
			@Difference_dd				INT,
			@Difference_hh				INT,
			@Difference_mi				INT,
			@PhysicalMemory				INT,
			@QuantidadeCPU				TINYINT,
			@Hyperthread				TINYINT,
			@QuantidadeVLFs				VARCHAR(MAX)

	/* Setando Variaveis Iniciais - Utilizadas na Parte Inicial do Relatório */
	SET @PhysicalName	= CONVERT(VARCHAR(100), SERVERPROPERTY('ComputerNamePhysicalNetBIOS'))
	SET @OriServer		= CONVERT(VARCHAR(50), SERVERPROPERTY('ServerName'))
	SET @Edition		= CONVERT(VARCHAR(100), SERVERPROPERTY('Edition'))
	SET @SP				= CONVERT(VARCHAR(100), SERVERPROPERTY ('ProductLevel'))
	SET @ProcessID		= CONVERT(VARCHAR(100), SERVERPROPERTY('ProcessID'))
	SET @Collation		= CONVERT(VARCHAR(100), SERVERPROPERTY('Collation'))
	SET @strSubject		= '[' + @Cliente + '] Relatório Informativo Ambiente (' + CONVERT(VARCHAR(50), SERVERPROPERTY('servername')) + ')'
	SET @PhysicalMemory = (SELECT ROUND(total_physical_memory_kb / 1024 /1024.0 ,0) FROM sys.dm_os_sys_memory)
	SET @QuantidadeCPU	= (SELECT (cpu_count) FROM sys.dm_os_sys_info)
	SET @Hyperthread	= (SELECT (hyperthread_ratio) FROM sys.dm_os_sys_info)	

	IF (SELECT CHARINDEX('SQL Server 2014', @@VERSION)) <> 0
		SET @Engine =  'Microsoft SQL Server 2014'
	ELSE IF (SELECT CHARINDEX('SQL Server 2012', @@VERSION)) <> 0
		SET @Engine =  'Microsoft SQL Server 2012'
	ELSE IF (SELECT CHARINDEX('SQL Server 2008R2', @@VERSION)) <> 0
		SET @Engine =  'Microsoft SQL Server 2008R2'
	ELSE IF (SELECT CHARINDEX('SQL Server 2008', @@VERSION)) <> 0
		SET @Engine =  'Microsoft SQL Server 2008'
	ELSE IF (SELECT CHARINDEX('SQL Server 2005', @@VERSION)) <> 0
		SET @Engine =  'Microsoft SQL Server 2005'
	ELSE
		SET @Engine = 'Unknown'

	IF SERVERPROPERTY('IsClustered') = 0 
	BEGIN
		SET @ISClustered = 'NO'
	END
	ELSE
	BEGIN
		SET @ISClustered = 'YES'
	END

	IF ((SERVERPROPERTY('IsHadrEnabled') = 0) OR (SERVERPROPERTY('IsHadrEnabled') IS NULL))
	BEGIN
		SET @IsHadr = 'NO'
	END
	ELSE
	BEGIN
		SET @IsHadr = 'YES'
	END	

	SET @Starttime		= (SELECT crdate FROM master..sysdatabases WHERE name = 'tempdb' )
	SET @Difference_mi	= (SELECT DATEDIFF(mi, @starttime, GETDATE()))
	SET @Difference_dd	= (@difference_mi/60/24)
	SET @Difference_mi	= (@difference_mi - (@difference_dd*60)*24)
	SET @Difference_hh	= (@difference_mi/60)
	SET @Difference_mi	= (@difference_mi - (@difference_hh*60))
	SET @Uptime			= CONVERT(VARCHAR, @difference_dd) + ' Dia(s) ' +  CONVERT(VARCHAR, @difference_hh) + ' Hora(s) ' + CONVERT(VARCHAR, @difference_mi) + ' Minuto(s).'

	/* Utilização de Memoria RAM por Database */	
	SELECT TOP 10
		Database_id AS DatabaseID,
		CASE [database_id] WHEN 32767 
			THEN 'RESOURCE SQL SERVER' 
			ELSE DB_NAME(database_id) END AS DatabaseName,
		COUNT_BIG(*) AS BuffersPorPagina,
		(CONVERT(NUMERIC(20,2),COUNT_BIG(*)*8)/1024) AS BuffersPorMB
	INTO #MemoryDatabase
	FROM sys.dm_os_buffer_descriptors
	GROUP BY database_id, DB_NAME(database_id)
	ORDER BY BuffersPorPagina DESC, BuffersPorMB DESC

	/* Informações de JOBs */	
	CREATE TABLE #Jobs_Status
	(    
		Job_id				UNIQUEIDENTIFIER,
		Name				SYSNAME,
		[Enabled]			TINYINT,
		Last_Run_Outcome	INT,
		Last_Run_Duration	INT
	)

	INSERT #jobs_status (job_id, name, enabled, last_run_outcome,last_run_duration)
	SELECT
		A.job_id,
		C.name,
		B.enabled,
		A.last_run_outcome,
		a.last_run_duration
	FROM msdb.dbo.sysjobservers A, msdb.dbo.sysjobs_view B, msdb.dbo.sysjobs C
	WHERE A.job_id = B.job_id
	AND A.job_id = C.job_id
	ORDER BY C.name ASC
	
	/* Utilização de CPU por Database*/	
	SELECT
		DatabaseID, 
		CASE WHEN (DatabaseID = 32767)
			THEN 'RESOURCE SQL SERVER'
			ELSE DB_Name(DatabaseID) END [DatabaseName],
		SUM(total_worker_time) AS [CPU_Time_Ms]
	INTO #CPUDatabase
	FROM sys.dm_exec_query_stats AS qs 
	CROSS APPLY (SELECT
					CONVERT(int, value) AS [DatabaseID]  
				  FROM sys.dm_exec_plan_attributes(qs.plan_handle) 
				  WHERE attribute = N'dbid') AS F_DB 
	 GROUP BY DatabaseID
	 ORDER BY [CPU_Time_Ms] DESC

	/* Wait Statistics */
	SELECT
		[wait_type]											AS [wait_type],
		[wait_time_ms] / 1000.0								AS [WaitS],
		([wait_time_ms] - [signal_wait_time_ms]) / 1000.0	AS [ResourceS],
		[signal_wait_time_ms] / 1000.0						AS [SignalS],
		[waiting_tasks_count]								AS [WaitCount],
		100.0 * [wait_time_ms] / SUM ([wait_time_ms]) OVER() AS [Percentage],		
		ROW_NUMBER() OVER(ORDER BY [wait_time_ms] DESC) AS [RowNum]
	INTO #Waits
	FROM sys.dm_os_wait_stats
	WHERE [wait_type] NOT IN
	(
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
		N'XE_DISPATCHER_WAIT',          N'XE_TIMER_EVENT'
	)

	/* Informações Disco */
	CREATE TABLE  #DriveList
	(
	   [DriveLetter]	CHAR(1)
	  ,[VolumeName]		VARCHAR(255)
	  ,[FileSystem]		VARCHAR(50)
	  ,[TotalSize]		BIGINT
	  ,[AvailableSpace]	BIGINT
	  ,[FreeSpace]		BIGINT 
	)

	BEGIN
		EXEC sp_OACreate 'Scripting.FileSystemObject', @FileSystemInstance OUT
		EXEC sp_OAGetProperty @FileSystemInstance,'Drives', @DriveCollection OUT
		EXEC sp_OAGetProperty @DriveCollection,'Count', @DriveCount OUT

		SET @DriveLetter_ASCII_Code = 65
  
		WHILE @DriveLetter_ASCII_Code <= 90
		BEGIN		
			SET @Property = 'item("'+ CHAR (@DriveLetter_ASCII_Code)+'")'			
			
			EXEC sp_OAGetProperty @DriveCollection,@Property, @Drive OUT
			EXEC sp_OAGetProperty @Drive,'DriveLetter', @DriveLetter OUT

			IF @DriveLetter = CHAR (@DriveLetter_ASCII_Code)
			BEGIN   
				EXEC sp_OAGetProperty @Drive,'VolumeName', @VolumeName OUT 
				EXEC sp_OAGetProperty @Drive,'FileSystem', @FileSystem OUT
				EXEC sp_OAGetProperty @Drive,'TotalSize', @TotalSize OUT 
				EXEC sp_OAGetProperty @Drive,'AvailableSpace', @AvailableSpace OUT
				EXEC sp_OAGetProperty @Drive,'FreeSpace', @FreeSpace OUT          
				EXEC sp_OAGetProperty @Drive,'IsReady'  , @IsReady OUT; 

				IF (@IsReady='True')
				BEGIN
					INSERT INTO #DriveList ( [DriveLetter],[TotalSize], [AvailableSpace],[FreeSpace],[FileSystem] ,[VolumeName] )
					VALUES( @DriveLetter,@TotalSize,@AvailableSpace,@FreeSpace,@FileSystem,@VolumeName)
				END
			END
			SET @DriveLetter_ASCII_Code = @DriveLetter_ASCII_Code +1
		END  
		EXEC sp_OADestroy @Drive 
		EXEC sp_OADestroy @DriveCollection
	END

	SELECT
		DriveLetter + ': (' + VolumeName + ')' AS [Disk],
		((TotalSize)/1024/1024/1024) AS [TotalSize(GB)],
		((FreeSpace)/1024/1024/1024) AS [FreeSpace(GB)],
		CAST((FreeSpace/(TotalSize*1.0))*100.0 AS INT) AS [FreeSpace(%)]
	INTO #DriveListFormated
	FROM #DriveList
	
	/* Informações Databases - Geral*/
	CREATE TABLE #DATABASEGERAL
	(
		name				VARCHAR(128),
		db_size				VARCHAR(100),
		owner				VARCHAR(128),
		dbid				SMALLINT,
		created				CHAR(11),
		status				VARCHAR(340),
		compatibility_level TINYINT,
	)

	INSERT INTO #DATABASEGERAL
	EXEC sp_helpdb
		
	/* Informações Database - Details Data File 1 */
	CREATE TABLE #DBINFORMATION2
	(
		ServerName			VARCHAR(100),
		DatabaseName		VARCHAR(100),
		LogicalFileName		SYSNAME,
		PhysicalFileName	NVARCHAR(520),
		FileSizeMB			INT,
		Status				SYSNAME,
		RecoveryMode		SYSNAME,
		FreeSpaceMB			INT,
		FreeSpacePct		INT
	)
 
	SELECT @command = 
		'Use [' + '?' + ']
			SELECT
					' +	'''' + '?' + '''' + ' AS DatabaseName,
				Cast (sysfiles.size/128.0 AS int) AS FileSizeMB,
				sysfiles.name AS LogicalFileName, sysfiles.filename AS PhysicalFileName,
				CONVERT(sysname,DatabasePropertyEx(''?'',''Status'')) AS Status,
				CONVERT(sysname,DatabasePropertyEx(''?'',''Recovery'')) AS RecoveryMode,
				CAST(sysfiles.size/128.0 - CAST(FILEPROPERTY(sysfiles.name, ' + '''' +
				'SpaceUsed' + '''' + ' ) AS int)/128.0 AS int) AS FreeSpaceMB,
				CAST(100 * (CAST (((sysfiles.size/128.0 -CAST(FILEPROPERTY(sysfiles.name,
				' + '''' + 'SpaceUsed' + '''' + ' ) AS int)/128.0)/(sysfiles.size/128.0))
				AS decimal(4,2))) as Int) AS FreeSpacePct
			FROM dbo.sysfiles'

	INSERT INTO #DBINFORMATION2
	(
		DatabaseName,
		FileSizeMB,
		LogicalFileName,
		PhysicalFileName,
		Status,
		RecoveryMode,
		FreeSpaceMB,
		FreeSpacePct
	)
	EXEC sp_MSForEachDB @command

	INSERT #DBINFORMATION2 (DatabaseName,FileSizeMB,LogicalFileName,PhysicalFileName,Status,RecoveryMode,FreeSpaceMB,FreeSpacePct)
	SELECT
		DB_Name(MST.database_id),
		AA.TotalSizeMB,
		aa.LOG_DBNAME,
		'N/A',
		MST.state_desc,
		MST.recovery_model_desc,
		0,
		0
	FROM sys.databases MST
				INNER JOIN (SELECT b.name [LOG_DBNAME],
							CONVERT(DECIMAL(20,2),SUM(CONVERT(DECIMAL(20,2),(a.size * 8)) /1024)) [TotalSizeMB]
							FROM sys.sysaltfiles A
							INNER JOIN sys.databases B on A.dbid = B.database_id
							GROUP BY b.name)AA on AA.[LOG_DBNAME] = MST.name
	WHERE MST.state_desc = 'OFFLINE'

 	SELECT     
		CONVERT(VARCHAR(100),LTRIM(RTRIM(databasename))) AS [Database_Name],
		CONVERT(VARCHAR(100),LTRIM(RTRIM(LogicalFileName)))AS [Logical_Name],		
		CASE WHEN (PhysicalFileName LIKE '%.LDF')
				THEN 'LOG (.ldf)'
			WHEN (PhysicalFileName LIKE '%.MDF')
				THEN 'DATA (.mdf)'
			WHEN (PhysicalFileName LIKE '%.NDF')
				THEN 'DATA (.ndf)'
				END [File_Type],
		CONVERT(VARCHAR(100),LTRIM(RTRIM(Status)))AS [Status],
		CONVERT(VARCHAR(100),LTRIM(RTRIM(RecoveryMode)))AS [Recovery_Model],	
		FileSizeMB AS [File_Size],
		FreeSpaceMB AS [Free_Space],
		FreeSpacePct AS [Free_Space_pct]
	INTO #ResultInfoDatabase
	FROM #dbinformation2
 
	/* Informações Database - Details Data File 2 */
	 SELECT	
		DB_NAME(D.database_id)		AS DatabaseName,
		M.type_desc					AS Type,
		D.num_of_reads				AS CountReads,
		D.io_stall_read_ms			AS WaitReads_ms, -- Tempo total em milissegundos de espera de operações de fisicas de leituras
		CONVERT(NUMERIC(20,2),(CONVERT(NUMERIC(20,2),D.io_stall_read_ms)/CONVERT(NUMERIC(20,2),D.num_of_reads))) AS AVGLatencyRead_ms, -- Média de Latency em Leitura		
		CAST((D.num_of_bytes_read * 1.0 / (D.num_of_bytes_read * 1.0 + D.num_of_bytes_written * 1.0) * 100) AS NUMERIC(20,2)) AS  [Read%], -- Percentual de Leitura
		D.num_of_writes				AS CountWrites,
		D.io_stall_write_ms			AS WaitWrite_ms, -- Tempo total em milissegundos de espera de operações de fisicas de escritas
		CONVERT(NUMERIC(20,2),(CONVERT(NUMERIC(20,2),D.io_stall_write_ms)/CONVERT(NUMERIC(20,2),D.num_of_writes))) AS AVGLatencyWrite_ms,	-- Média de Latency em Escrita
		CAST((D.num_of_bytes_written * 1.0 / (D.num_of_bytes_written * 1.0 + D.num_of_bytes_read * 1.0) * 100) AS NUMERIC(20,2)) AS [Write%], -- Percentual de Escrita
		(D.io_stall_read_ms + D.io_stall_write_ms) AS TotalWaitIO_ms, -- Tempo total, em milissegundos, de espera -> Leitura + Escritas			
		CAST((io_stall_read_ms + io_stall_write_ms ) / (1.0 + num_of_reads + num_of_writes) AS NUMERIC(20,4)) AS AvgIOWait -- Média de I/Os no Geral
	INTO #DATABASEDETAIL2
	FROM sys.dm_io_virtual_file_stats(NULL,NULL) AS D 
	INNER JOIN sys.master_files M
		ON D.database_id = M.database_id
		AND D.file_id = M.file_id
	WHERE DB_NAME(m.database_id) NOT IN ('MODEL','MSDB')
	ORDER BY 1 ASC

	/* Estatiscas de utilização de I/O por Disco*/
	 SELECT
		SUM(IOS.num_of_reads) AS Reads,
		SUM(IOS.num_of_bytes_read) BytesRead,
		SUM(IOS.io_stall_read_ms) AS IoStallReadMs,
		SUM(IOS.num_of_writes) AS Writes,
		SUM(IOS.num_of_bytes_written) AS BytesWritten,
		SUM(IOS.io_stall_write_ms) AS IoStallWritesMs,
		SUM(IOS.io_stall) AS IoStall,
		SUM(IOS.size_on_disk_bytes) SizeOnDisk
	INTO #IOT
	FROM sys.dm_io_virtual_file_stats(DEFAULT, DEFAULT) AS IOS

	SELECT
		DBS.name AS DatabaseName,
		MF.name AS [FileName],
		MF.type_desc AS FileType,
		SUBSTRING(MF.physical_name, 1, 3) AS Drive,
		CASE WHEN DBS.name IN ('master', 'model', 'msdb', 'tempdb')
			THEN 1
			ELSE 0 END AS IsSystemDB,
		IOS.*
	INTO #IOF
	FROM sys.dm_io_virtual_file_stats(DEFAULT, DEFAULT) AS IOS
	INNER JOIN sys.databases AS DBS
		ON IOS.database_id = DBS.database_id
	INNER JOIN sys.master_files AS MF
		ON IOS.database_id = MF.database_id
	AND IOS.file_id = MF.file_id

	/* Quantidade de VLFs Por Database*/
	CREATE TABLE #LOGINFO
	(
		DBNAME			SYSNAME NOT NULL DEFAULT DB_NAME(),
		RecoveryUnitid	TINYINT,
		FileId			TINYINT,
		FileSize		BIGINT,
		StartOffset		BIGINT,
		FSeqNo			INT,
		[Status]		TINYINT,
		Parity			TINYINT,
		CreateLSN		NUMERIC(25,0)
	)	

	SET @QuantidadeVLFs = ' USE [?]
		IF (((SELECT CHARINDEX(''SQL Server 2012'', @@VERSION)) <> 0) OR (SELECT CHARINDEX(''SQL Server 2014'', @@VERSION))<> 0)
			INSERT #LOGINFO (RecoveryUnitid, FileId, FileSize, StartOffset, FSeqNo, [Status], Parity, CreateLSN)
			EXEC (''DBCC LOGINFO ([?])'')
		ELSE
			INSERT #LOGINFO (FileId, FileSize, StartOffset, FSeqNo, [Status], Parity, CreateLSN)
			EXEC (''DBCC LOGINFO ([?])'')'
	EXEC sp_MSforeachdb @QuantidadeVLFs

	/* Ponto de Montagem HTML - Corpo do E-mail*/
 	SET @TableHTML =
	'
	<body>
		<table width="100%" bgColor="#ffffff">
			<tr>
				<td align="center">
					<p><font face="arial" size="6"><b>.:: Relatório Informativo Ambiente - SQL Server ::.</b></font></p>				
					<p><font face="arial" size="4"><b>' + @Cliente + '</b></font></p>
					<p><font face="arial" size="4"><b> Ambiente: ' + UPPER(@Funcao) + '</b></font></p>
				</td>
				<td align="center">
					<img src= "http://www.prodesp.sp.gov.br/imagens/logotipo_prodesp2.gif">
				</td>
			</tr>
		</table> <br>

		<p>
			<font face="verdana" size="2"><b>Responsável:</b>' + ' Serviço de Suporte e Implantação de Banco de Dados - SIBD </font> </br> <b>Contato: </b> outsourcingbd@prodesp.sp.gov.br
		</p>		
		<p style="margin-top: 0; margin-bottom: 0"></p></style>
		<hr color="#000000" size="2"></hr><br>

		<table style="BORDER-COLLAPSE: collapse"  width="50%" bgColor="#ffffff" borderColorLight="#000000"></style>
			<tr>
				<td align="left"> <b> <font face="verdana" size="2" color="#000000Y">Server IP</b></font></td>' + '<td align="left" bgcolor="#FFFFFF"> <font face="verdana" size="2" color="#000000Y">' + ':' +  @ServerIP + '</td></font>
			</tr>
			<tr>
				<td align="left"> <b> <font face="verdana" size="2" color="#000000Y">Physical Name</b></font></td>' + '<td align="left" bgcolor="#FFFFFF"> <font face="verdana" size="2" color="#000000Y">' + ':' + @PhysicalName + '</td></font>
			</tr>
			<tr>
				<td align="left"> <b> <font face="verdana" size="2" color="#000000Y">Instance Name</b></font></td>' + '<td align="left" bgcolor="#FFFFFF"> <font face="verdana" size="2" color="#000000Y">' + ':' + @Oriserver + '</td></font>
			</tr>
			<tr>
				<td align="left"> <b> <font face="verdana" size="2" color="#000000Y">Engine</b></font></td>' + '<td align="left" bgcolor="#FFFFFF"> <font face="verdana" size="2" color="#000000Y">' + ':' + @Engine + '</td></font>
			</tr>
			<tr>
				<td align="left"> <b> <font face="verdana" size="2" color="#000000Y">Edition</b></font></td>' + '<td align="left" bgcolor="#FFFFFF"> <font face="verdana" size="2" color="#000000Y">' + ':' + @Edition + '</td></font>
			</tr>
			<tr>
				<td align="left"> <b> <font face="verdana" size="2" color="#000000Y">Service Pack</b></font></td>' + '<td align="left" bgcolor="#FFFFFF"> <font face="verdana" size="2" color="#000000Y">' + ':' + @SP + '</td></font>
			</tr>
			<tr>
				<td align="left"> <b> <font face="verdana" size="2" color="#000000Y">Clusterd</b></font></td>' + '<td align="left" bgcolor="#FFFFFF"> <font face="verdana" size="2" color="#000000Y">' + ':' + @ISClustered + '</td></font>
			</tr>
			<tr>
				<td align="left"> <b> <font face="verdana" size="2" color="#000000Y">AlwaysOn</b></font></td>' + '<td align="left" bgcolor="#FFFFFF"> <font face="verdana" size="2" color="#000000Y">' + ':' + @IsHadr + '</td></font>
			</tr>			
			<tr>
				<td align="left"> <b> <font face="verdana" size="2" color="#000000Y">Collation</b></font></td>' + '<td align="left" bgcolor="#FFFFFF"> <font face="verdana" size="2" color="#000000Y">' + ':' + @Collation + '</td></font>
			</tr>
			<tr>
				<td align="left"> <b> <font face="verdana" size="2" color="#000000Y">Uptime</b></font></td>' + '<td align="left" bgcolor="#FFFFFF"> <font face="verdana" size="2" color="#000000Y">' + ':' + @Uptime + '</td></font>
			</tr>
			<tr>
				<td align="left"> <b> <font face="verdana" size="2" color="#000000Y">Process ID</b></font></td>' + '<td align="left" bgcolor="#FFFFFF"> <font face="verdana" size="2" color="#000000Y">' + ':' + @ProcessID + '</td></font>
			</tr>
			<tr>
				<td align="left"> <b> <font face="verdana" size="2" color="#000000Y">Physical Memory</b></font></td>' + '<td align="left" bgcolor="#FFFFFF"> <font face="verdana" size="2" color="#000000Y">' + ':' + CONVERT(VARCHAR(10),@PhysicalMemory) + '</td></font>
			</tr>
			<tr>
				<td align="left"> <b> <font face="verdana" size="2" color="#000000Y">CPU</b></font></td>' + '<td align="left" bgcolor="#FFFFFF"> <font face="verdana" size="2" color="#000000Y">' + ':' + CONVERT(VARCHAR(3),@QuantidadeCPU) + '    |    <b>SLOT:</b>' + CONVERT(VARCHAR(5),@Hyperthread) + ' </td></font>
			</tr>
		</table> <br> <br>
			
		<table style="BORDER-COLLAPSE: collapse" borderColor="#111111" cellPadding="0" width="80%" bgColor="#ffffff" border="1"></style>
			<tr>
				<th  height="25" colspan=4 bgColor="#000000">
					<font color="#FFFFFF" face="verdana" size="3"><b>.:: Information JOBs ::.</b></font>
				</th>
			</tr>
			<tr>
				<td  height="20" align="center" bgcolor="#D3D3D3">
					 <font face="verdana" size="1" color="#000000"><b>JOB NAME</b></font>
				</td>
				<td  height="20" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>ENABLED</b></font>
				</td>
				<td  height="20" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>LAST RUN</b></font>
				</td>
				<td  height="20" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>LAST RUN DURATION</b></font>
				</td>
			</tr>'
			SELECT @TableHTML = @TableHTML + 
			'<tr>
				<td>
					<font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(100), JSA.name), '') +'</font>
				</td>' +
				CASE JSA.enabled 
					WHEN 0 THEN '<td align="center" bgcolor="#FF0000"><b><font color="#FFFFFF" face="verdana" size="2">FALSE</font></b></td>'  
					WHEN 1 THEN '<td align="center"><font face="verdana" size="1">TRUE</font></td>'  
					ELSE '<td align="center" ><font face="verdana" size="1">UNKNOWN</font></td>' END  +
				CASE JSA.last_run_outcome     
					WHEN 0 THEN '<td bgcolor="#FF0000" align="center"><b><font color="#FFFFFF" face="verdana" size="2"> FAILED </font></b></td>'  
					WHEN 1 THEN '<td bgcolor="#33ff33" align="center"><b><font color="#000000Y" face="verdana" size="2"> SUCCESS </font></b></td>'  
					WHEN 3 THEN '<td bgcolor="#FFCC99" align="center"><b><font color="#000000Y" face="verdana" size="2"> CANCELLED </font</b></td>'  
					WHEN 5 THEN '<td bgcolor="#FFCC99" align="center"><b><font color="#000000Y" face="verdana" size="2"> UNKNOWN </font></b></td>'  
					ELSE '<td bgColor="#FFFF00" align="center"><font face="arial" size="2"> OTHER </font></td>' END +																								
				'<td align="center" ><font face="verdana" size="1">' + CONVERT(VARCHAR(255),ISNULL(REVERSE(STUFF(STUFF(REVERSE(REPLICATE('0', 6 - LEN(CONVERT(VARCHAR(255), JSA.last_run_duration))) + CONVERT(VARCHAR(255), JSA.last_run_duration)), 3, 0, ':'), 6, 0, ':')),'UNKNOWN')) + '</font></td>
			</tr>'
			FROM #jobs_status JSA
			SET @TableHTML = @TableHTML + '
		</table> <br><br>'

		SET @TableHTML = @TableHTML + '
		<table style="BORDER-COLLAPSE: collapse" borderColor="#111111" cellPadding="0" width="100%" bgColor="#ffffff" border="1"></style>
			<tr>
				<th  height="25" colspan=8 bgColor="#000000">
					<font color="#FFFFFF" face="verdana" size="3"><b>.:: Information Database - Macro ::.</b></font>
				</th>
			</tr>
			<tr>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">DATABASE NAME</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">DATABASE SIZE</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">RECOVERY MODEL</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">OWNER</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">READ ONLY</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">USER ACCESS</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">COMPATIBILITY LEVEL</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">DATABASE STATE</font></b>
				</td>
			</tr>'
			SELECT @TableHTML =  @TableHTML +
			'<tr>
				 <td> <font face="verdana" size="1">' + ISNULL(tb1.name,tb2.name) + '</font></td>' +
				'<td align="center"><font face="verdana" size="1">' + ISNULL(tb1.db_size, 'UNKNOWN') + '</font></td>' +
				'<td align="center"><font face="verdana" size="1">' + ISNULL(tb2.recovery_model_desc, tb2.recovery_model_desc) + '</font></td>' +
				'<td align="center"><font face="verdana" size="1">' + ISNULL(tb1.owner, tb3.name) + '</font></td>' +
				'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(1),tb2.is_read_only),tb2.is_read_only) + '</font></td>' +
				'<td align="center"><font face="verdana" size="1">' + ISNULL(tb2.user_access_desc,'') + '</font></td>' +
				'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(5),tb1.compatibility_level),tb2.compatibility_level) + '</font></td>' +
				CASE WHEN ISNULL(CONVERT(VARCHAR(255),tb2.state_desc),'') = 'ONLINE'
					THEN '<td bgColor="#33ff33" align="center"><font face="verdana" size="2"><b>' + ISNULL(CONVERT(VARCHAR(255),tb2.state_desc),'') + '</b></font></td>'
					ELSE '<td bgColor="#ff0000" align="center"><font face="verdana" color="#FFFFFF" size="2"><b>' + ISNULL(CONVERT(VARCHAR(255),tb2.state_desc),'') + '</b></font></td>' END +										
			'</tr>' 
			FROM #DATABASEGERAL tb1
			RIGHT JOIN SYS.DATABASES tb2
				ON tb1.dbid = tb2.database_id	
			LEFT JOIN sys.syslogins tb3
				ON tb2.owner_sid = tb3.sid
								
			
			SET @TableHTML = @TableHTML +
		'</table><br><br>'

		SET @TableHTML = @TableHTML + '
		<table style="BORDER-COLLAPSE: collapse" borderColor="#111111" cellPadding="0" width="100%" bgColor="#ffffff" border="1"></style>
			<tr>
				<th  height="25" colspan=8 bgColor="#000000">
					<font color="#FFFFFF" face="verdana" size="3"><b>.:: Information Databases - Details Data Files ::.</b></font>
				</th>
			</tr>
			<tr>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">DATABASE NAME</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">LOGICAL NAME</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">FILE TYPE</font></b>
				</td>						
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">FILE SIZE(MB)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">FREE SPACE(MB)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">FREE SPACE(%)</font></b>
				</td>
			</tr>'
			SELECT @TableHTML =  @TableHTML +
			'<tr>
				 <td> <font face="verdana" size="1">' + ISNULL(TBI1.Database_Name,'Unknown') + '</font></td>' +
				'<td> <font face="verdana" size="1">' + ISNULL(TBI1.Logical_Name,'Unknown') + '</font></td>' +
				'<td align="center"><font face="verdana" size="1">' + ISNULL(TBI1.File_Type,'MDF+LDF') + '</font></td>' +					 					
				'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(255),TBI1.File_Size),'Unknown') + '</font></td>' +
				'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(255),TBI1.Free_Space),'Unknown') + '</font></td>' +
				CASE WHEN TBI1.Free_Space_pct <= @PercentFreeSpaceDatabase
					THEN '<td bgColor="#ff0000" align="center"><font face="verdana" color="#FFFFFF" size="2"><b>' + ISNULL(CONVERT(VARCHAR(255),TBI1.Free_Space_pct),'') + '%' + '</b></font></td>'
					ELSE '<td bgColor="#33ff33" align="center"><font face="verdana"  size="2"><b>' + ISNULL(CONVERT(VARCHAR(255),TBI1.Free_Space_pct),'') + '%' + '</b></font></td>' END +
			'</tr>' 
			FROM #ResultInfoDatabase TBI1
			ORDER BY TBI1.Database_Name ASC
			
			SET @TableHTML = @TableHTML +
		'</table><br><br>'
	
		SET @TableHTML = @TableHTML + '
		<table style="BORDER-COLLAPSE: collapse" borderColor="#111111" cellPadding="0" width="100%" bgColor="#ffffff" border="1"></style>
			<tr>
				<th  height="25" colspan=12 bgColor="#000000">
					<font color="#FFFFFF" face="verdana" size="3"><b>.:: Information Database - Details Data Files (Statistic I/O)::.</b></font>
				</th>
			</tr>
			<tr>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">DATABASE NAME</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">TYPE</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">COUNT READS</font></b>
				</td>						
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">WAIT READS(ms)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">AVG LATENCY READ(ms)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">READ(%)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">COUNT WRITES</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">WAIT WRITE(ms)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">AVG LATENCY WRITE(ms)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">WRITE(%)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">TOTAL WAIT I/O (ms)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">AVG I/O WAIT (ms)</font></b>
				</td>
			</tr>'
			SELECT @TableHTML =  @TableHTML +
			'<tr>
				 <td> <font face="verdana" size="1">' + ISNULL(dbt.DatabaseName,'') + '</font></td>' +					
				'<td align="center"><font face="verdana" size="1">' + ISNULL(dbt.Type,'') + '</font></td>' +					 					
				'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(50),dbt.CountReads),'') + '</font></td>' +					 					
				'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(50),dbt.WaitReads_ms),'') + '</font></td>' +					 					
				'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(50),dbt.AVGLatencyRead_ms),'') + '</font></td>' +					 					
				'<td align="center"><font face="verdana" size="2"><b>' + ISNULL(CONVERT(VARCHAR(50),dbt.[Read%]),'') + '</font></td></b>' +					 					
				'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(50),dbt.CountWrites),'') + '</font></td>' +					 					
				'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(50),dbt.WaitWrite_ms),'') + '</font></td>' +					 					
				'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(50),dbt.AVGLatencyWrite_ms),'') + '</font></td>' +					 					
				'<td align="center"><font face="verdana" size="2"><b>' + ISNULL(CONVERT(VARCHAR(50),dbt.[Write%]),'') + '</font></td></b>' +					 					
				'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(50),dbt.TotalWaitIO_ms),'') + '</font></td>' +					 					
				'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(50),dbt.AvgIOWait),'') + '</font></td>' +					 															
			'</tr>' 
			FROM #DATABASEDETAIL2 dbt		
			
			SET @TableHTML = @TableHTML +
		'</table><br><br>'
		
		SET @TableHTML = @TableHTML + '
		<table style="BORDER-COLLAPSE: collapse" borderColor="#111111" cellPadding="0" width="60%" bgColor="#ffffff" border="1"></style>
			<tr>
				<th  height="25" colspan=3 bgColor="#000000">
					<font color="#FFFFFF" face="verdana" size="3"><b>.:: Information Databases - VLFs Transaction Log ::.</b></font>
				</th>
			</tr>
			<tr>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">DATABASE NAME</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">QTD VLFs</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">SIZE LDF(MB)</font></b>
				</td>				
			</tr>'
			SELECT @TableHTML =  @TableHTML +
			'<tr>
				 <td> <font face="verdana" size="1">' + ISNULL(LF1.DBNAME,'') + '</font></td>' +
				'<td  align="center"> <font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(5), COUNT(*)),'')  + '</font></td>' +
				'<td  align="center"> <font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(255),LFF2.File_Size),'') + '</font></td>' +
			'</tr>'
			FROM #LOGINFO LF1
			LEFT JOIN #ResultInfoDatabase LFF2
				ON LF1.DBNAME = LFF2.Database_Name
			WHERE LFF2.File_Type = 'LOG (.ldf)'
			GROUP BY LF1.DBNAME, LFF2.File_Size

			SET @TableHTML = @TableHTML +
		'</table><br><br>'

		SET @TableHTML = @TableHTML + '		
		<table style="BORDER-COLLAPSE: collapse" borderColor="#111111" cellPadding="0" width="50%" bgColor="#ffffff" border="1"></style>
			<tr>
				<th  height="25" colspan=8 bgColor="#000000">
					<font color="#FFFFFF" face="verdana" size="3"><b>.:: Information Disk/Storage ::.</b></font>
				</th>
			</tr>
			<tr>				
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">DISK</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">TOTAL SIZE(GB)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">USED SPACE(GB)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">FREE SPACE(GB)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3"> <b>
					<font face="verdana" size="1" color="#000000">FREE SPACE(%)</font></b>
				</td>
			</tr>'
			SELECT
				@TableHTML =  @TableHTML +   
				'<tr>
					<td align="left"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(100), [Disk]), '') +'</font></td>' +
					'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(100), [TotalSize(GB)]), '') +'</font></td>' +
					'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(100), [TotalSize(GB)] - [FreeSpace(GB)]), '') +'</font></td>' +					
					'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(100), [FreeSpace(GB)]), '') +'</font></td>' +
					CASE WHEN [FreeSpace(%)] <= @PercentFreeSpaceDisk
						THEN '<td bgColor="#ff0000" align="center"><font color="#FFFFFF" face="verdana" size="2"><b>' + ISNULL(CONVERT(VARCHAR(100), [FreeSpace(%)]), '') + '%' + '</b></font></td>'
						ELSE '<td align="center"><font face="verdana" size="2"><b>'	+ ISNULL(CONVERT(VARCHAR(100), [FreeSpace(%)]), '') + '%' +  '</b></font></td>
				</tr>' END
			FROM 
				#DriveListFormated
			SET @TableHTML = @TableHTML + 
		'</table><br><br>'

		SET @TableHTML = @TableHTML + '
		<table style="BORDER-COLLAPSE: collapse" borderColor="#111111" cellPadding="0" width="80%" bgColor="#ffffff" border="1"></style>
			<tr>
				<th  height="25" colspan=9 bgColor="#000000">
					<font color="#FFFFFF" face="verdana" size="3"><b>.:: Disk Usage Statistics ::.</b></font>
				</th>
			</tr>
			<tr>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>UNIDADE</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>READS(%)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>BYTES READS(%)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>IO STALL READS ms(%)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>WRITES(%)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>BYTES WRITTEN(%)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>IO STALL WRITER ms(%)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>IO STALL(%)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>SIZE ON DISK(%)</font></b>
				</td>
			</tr>'
			SELECT @TableHTML =  @TableHTML +			
			'<tr>
				 <td align="left"><font face="arial" size="1">' + ISNULL(DF.Disk,'') +'</font></td>' +
				'<td align="center"><font face="verdana" size="2"><b>' + ISNULL(CONVERT(VARCHAR(20),CONVERT(numeric(5,2), SUM(100.0 * IOF.num_of_reads / IOT.Reads))),'') +'</b></font></td>' +
				'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(20),CONVERT(numeric(5,2), SUM(100.0 * IOF.num_of_bytes_read / IOT.BytesRead))),'') +'</font></td>' +
				'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(20),CONVERT(numeric(5,2), SUM(100.0 * IOF.io_stall_read_ms / IOT.IoStallReadMs))),'') +'</font></td>' +
				'<td align="center"><font face="verdana" size="2"><b>' + ISNULL(CONVERT(VARCHAR(20),CONVERT(numeric(5,2), SUM(100.0 * IOF.num_of_writes / IOT.Writes))),'') +'</b></font></td>' +
				'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(20),CONVERT(numeric(5,2), SUM(100.0 * IOF.num_of_bytes_written / IOT.BytesWritten))),'') +'</font></td>' +
				'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(20),CONVERT(numeric(5,2), SUM(100.0 * IOF.io_stall_write_ms / IOT.IoStallWritesMs))),'') +'</font></td>' +
				'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(20),CONVERT(numeric(5,2), SUM(100.0 * IOF.io_stall / IOT.IoStall))),'') +'</font></td>' +
				'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(20),CONVERT(numeric(5,2), SUM(100.0 * IOF.io_stall_write_ms / IOT.IoStallWritesMs))),'') +' </font></td>
			</tr>'
			FROM #IOF IOF
			LEFT JOIN #DriveListFormated DF
				ON SUBSTRING(IOF.Drive,0,3) = SUBSTRING(DF.Disk,0,3)
			CROSS APPLY #IOT IOT			
			GROUP BY DF.Disk
			ORDER BY DF.Disk
			
			SET @TableHTML = @TableHTML +  
		'</table><br><br>'
				
		SET @TableHTML = @TableHTML + '
		<table style="BORDER-COLLAPSE: collapse" borderColor="#111111" cellPadding="0" width="80%" bgColor="#ffffff" border="1"></style>
			<tr>
				<th  height="25" colspan=8 bgColor="#000000">
					<font color="#FFFFFF" face="verdana" size="3"><b>.:: Wait Statistics (TOP 10)::.</b></font>
				</th>
			</tr>
			<tr>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>WAIT TYPE</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>WAIT_S</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>RESOURCE_S</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>SIGNAL_S</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>WAIT COUNT</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>PERCENTAGE(%)</font></b>
				</td>
			</tr>'
			SELECT TOP 10 @TableHTML =  @TableHTML +   
				'<tr>
					 <td align="left"><font face="arial" size="1">' + ISNULL(CONVERT(VARCHAR(100),[W1].[wait_type]),'') +'</font></td>' +
					'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(100),CAST([W1].[WaitS] AS DECIMAL (16, 2))),'') +'</font></td>' +
					'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(100),CAST([W1].[ResourceS] AS DECIMAL (16, 2))),'') +'</font></td>' +
					'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(100),CAST([W1].[SignalS] AS DECIMAL (16, 2))),'') +'</font></td>' +
					'<td align="center"><font face="verdana" size="1">' + ISNULL(CONVERT(VARCHAR(100),[W1].[WaitCount]),'') +'</font></td>' +
					'<td align="center"><font face="verdana" size="2"><b>' + ISNULL(CONVERT(VARCHAR(100),CAST([W1].[Percentage] AS DECIMAL (5, 2))),'') +'</b></font></td>
				</tr>'
			FROM #waits AS [W1]
			INNER JOIN #waits AS [W2]
				ON [W2].[RowNum] <= [W1].[RowNum]
			GROUP BY [W1].[RowNum], [W1].[wait_type], [W1].[WaitS],[W1].[ResourceS], [W1].[SignalS], [W1].[WaitCount], [W1].[Percentage]
			HAVING SUM ([W2].[Percentage]) - [W1].[Percentage] < 99

			SET @TableHTML = @TableHTML +  
		'</table><br><br>'

		SET @TableHTML = @TableHTML + '
		<table style="BORDER-COLLAPSE: collapse" borderColor="#111111" cellPadding="0" width="80%" bgColor="#ffffff" border="1"></style>
			<tr>
				<th  height="25" colspan=8 bgColor="#000000">
					<font color="#FFFFFF" face="verdana" size="3"><b>.:: Use of Memory for Database (TOP 10) ::.</b></font>
				</th>
			</tr>
			<tr>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>DATABASE ID</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>DATABASE NAME</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>BUFFERS(PAGEs)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>BUFFERS(GB)</font></b>
				</td>
			</tr>'
			SELECT TOP 10 @TableHTML =  @TableHTML +   
				'<tr>
					<td align="center"><font face="arial" size="2">' + ISNULL(CONVERT(VARCHAR(100),#MemoryDatabase.DatabaseID),'') +'</font></td>' +
					'<td align="left"><font face="arial" size="1">' + ISNULL(CONVERT(VARCHAR(100),#MemoryDatabase.DatabaseName),'') +'</font></td>' + 
					'<td align="center"><font face="arial" size="1">' + ISNULL(CONVERT(VARCHAR(100),#MemoryDatabase.BuffersPorPagina),'') +'</font></td>' +
					'<td align="center"><font face="verdana" size="2"><b>' + ISNULL(CONVERT(VARCHAR(100),CAST(#MemoryDatabase.BuffersPorMB AS DECIMAL (10, 2))),'') + '</b></font>
				</td>'
			FROM #MemoryDatabase
			ORDER BY BuffersPorPagina DESC, BuffersPorMB DESC

			SET @TableHTML = @TableHTML + 
		'</table><br><br>'

		SET @TableHTML = @TableHTML + '
		<table style="BORDER-COLLAPSE: collapse" borderColor="#111111" cellPadding="0" width="80%" bgColor="#ffffff" border="1"></style>
			<tr>
				<th  height="25" colspan=8 bgColor="#000000">
					<font color="#FFFFFF" face="verdana" size="3"><b>.:: Use of a CPU for Database (TOP 10) ::.</b></font>
				</th>
			</tr>
			<tr>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>DATABASE ID</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>DATABASE NAME</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>CPU TIME(ms)</font></b>
				</td>
				<td  height="25" align="center" bgcolor="#D3D3D3">
					<font face="verdana" size="1" color="#000000"><b>IN USE(%)</font></b>
				</td>
			</tr>'
			SELECT TOP 10 @TableHTML =  @TableHTML +   
				'<tr>
					 <td align="center"><font face="arial" size="2">' +  ISNULL(CONVERT(VARCHAR(100),#CPUDatabase.DatabaseID),'') + '</font></td>' +
					'<td align="left"><font face="arial" size="1">' +  ISNULL(CONVERT(VARCHAR(100),#CPUDatabase.DatabaseName),'') + '</font></td>' + 
					'<td align="center"><font face="arial" size="1">' +  ISNULL(CONVERT(VARCHAR(100),#CPUDatabase.CPU_Time_Ms),'') + '</font></td>' +
					'<td align="center"><font face="arial" size="2"><b>' + ISNULL(CONVERT(VARCHAR(100),CAST([CPU_Time_Ms] * 1.0 / SUM([CPU_Time_Ms]) OVER() * 100.0 AS DECIMAL(5, 2))),'') +'</b></font></td>' + '</font></td>'
				FROM #CPUDatabase
				ORDER BY CPU_Time_Ms DESC
			
			SET @TableHTML = @TableHTML + 
		'</table><br><br>'

		SET @TableHTML =  @TableHTML + 
			'<p style="margin-top: 0; margin-bottom: 0">&nbsp;</p>
				<hr color="#000000" size="1">
			 <p><font face="Verdana" size="2"><b>Copyright ©2015 - PRODESP - Empresa de Processamento de Dados do Estado de São Paulo' +'</font></p></b><p>&nbsp;</p>'

	EXEC msdb.dbo.sp_send_dbmail  
			@profile_name	= @ProfileMail,
			@recipients		= @Recipients,
			@subject		= @strSubject,
			@body			= @TableHTML,
			@body_format	= 'HTML';

	DROP TABLE #DriveList
	DROP TABLE #DriveListFormated
	DROP TABLE #waits
	DROP TABLE #MemoryDatabase
	DROP TABLE #CPUDatabase
	DROP TABLE #DBINFORMATION2
	DROP TABLE #ResultInfoDatabase
	DROP TABLE #IOF
	DROP TABLE #IOT
	DROP TABLE #DATABASEGERAL
	DROP TABLE #DATABASEDETAIL2
	DROP TABLE #LOGINFO
END
GO