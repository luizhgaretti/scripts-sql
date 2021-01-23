USE [msdb]
go

if exists (select name from msdb..sysjobs where name = 'Rebuild Index - Script') 

exec sp_delete_job 
@job_name = 'Rebuild Index - Script'
go

/****** Object:  Job [Rebuild Index - Script]    Script Date: 15/10/2012 08:56:53 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 15/10/2012 08:56:53 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Rebuild Index - Script', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [.]    Script Date: 15/10/2012 08:56:53 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'SELECT ROW_NUMBER() OVER(ORDER BY name) Seq, name Banco
INTO #Databases
FROM sys.databases
WHERE name NOT IN (''master'', ''msdb'',''tempdb'',''model'', ''ReportServer'', ''ReportServerTempDB'', ''distribution'', ''cep'')   
--WHERE name IN (''master'')
AND NAME NOT LIKE ''%TST%''
AND NAME NOT LIKE ''%TESTE%''
AND NAME NOT LIKE ''%BKP%''
AND NAME NOT LIKE ''%BACKUP%''
AND STATE = 0 --SOMENTE BASE ONLINE
AND IS_READ_ONLY = 0 --SOMENTE BASE COM PERMISSÃO DE ESCRITA
AND compatibility_level > 80
--AND VERSION IS NOT NULL --BASE OFFLINE
--AND VERSION <> 0 --BASE OFFLINE
ORDER BY Banco;

DECLARE @Loop INT 
SET @Loop = 1

DECLARE	@Qt INT 
SET @Qt = (SELECT COUNT(1) FROM #Databases)

DECLARE	@Banco VARCHAR(50)

	WHILE @Loop <= @Qt
	 BEGIN
	  SET @Banco = (SELECT Banco FROM #Databases WHERE Seq = @Loop);
		EXEC( 
		''USE '' + @Banco +
		'' PRINT ''''Database em uso: '''' + db_name();
		SELECT
			ROW_NUMBER() OVER(ORDER BY p.object_id, p.index_id) Seq,
   			t.name Tabela, h.name Esquema,
			i.name Indice, p.avg_fragmentation_in_percent Frag
		INTO #Consulta
		FROM
		sys.dm_db_index_physical_stats(DB_ID(),null,null,null,null) p
		join sys.indexes i on (p.object_id = i.object_id and p.index_id = i.index_id)
		join sys.tables t on (p.object_id = t.object_id)
		join sys.schemas h on (t.schema_id = h.schema_id)
		where p.avg_fragmentation_in_percent > 20.0
		and p.index_id > 0
		and p.page_count > 100
		ORDER BY Esquema, Tabela;
		DECLARE @Loop INT 
		SET @Loop = 1

		DECLARE	@Total INT 
		SET @Total = (SELECT COUNT(1) FROM #Consulta)

		DECLARE	@Comando VARCHAR(500)

		DECLARE	@FILLFACTOR VARCHAR(3) 
		SET @FILLFACTOR = 80

		WHILE @Loop <= @Total
			BEGIN
				SELECT @Comando = ''''ALTER INDEX '''' + Indice + '''' ON '''' + Esquema + ''''.'''' + Tabela +
					( CASE WHEN Frag > 30.0 THEN '''' REBUILD WITH (FILLFACTOR = '''' + @FILLFACTOR + '''', PAD_INDEX = ON, SORT_IN_TEMPDB = ON)'''' 

ELSE '''' REORGANIZE'''' END)
					FROM #Consulta
					WHERE Seq = @Loop;
				EXEC(@Comando);
				PRINT + @Comando;
				SET @Loop = @Loop + 1;
			END;
		PRINT DB_NAME() + '''' Qtde de índices afetados: '''' + CONVERT(VARCHAR(5),@Total);
		PRINT ''''-----'''';
		DROP TABLE #Consulta;'');  
	  SET @Loop = @Loop + 1;
	 END;

DROP TABLE #Databases;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'.', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20120914, 
		@active_end_date=99991231, 
		@active_start_time=40000, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

go


/*****************************************************************************************************/


USE [msdb]
go

if exists (select name from msdb..sysjobs where name = 'Shrink - Script') 

exec sp_delete_job 
@job_name = 'Shrink - Script'
go

/****** Object:  Job [Shrink - Script]    Script Date: 08/10/2012 11:35:06 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 08/10/2012 11:35:06 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Shrink - Script', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name='sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [.]    Script Date: 08/10/2012 11:35:06 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'--script limpa log-shrinkfile bases de usuarios
DECLARE  @BASE VARCHAR(8000), @SSQL VARCHAR(8000)

DECLARE CBKP CURSOR STATIC FOR 

SELECT 
+ NAME 

FROM sys.databases
WHERE name NOT IN (''master'', ''model'', ''ReportServer'', ''ReportServerTempDB'', ''cep'')   
AND NAME NOT LIKE ''%TST%''
AND NAME NOT LIKE ''%TESTE%''
AND NAME NOT LIKE ''%BKP%''
AND NAME NOT LIKE ''%BACKUP%''
AND STATE = 0 --SOMENTE BASE ONLINE
AND IS_READ_ONLY = 0 --SOMENTE BASE COM PERMISSÃO DE ESCRITA
AND compatibility_level > 80
--AND VERSION IS NOT NULL --BASE OFFLINE
--AND VERSION <> 0 --BASE OFFLINE

OPEN CBKP
	FETCH NEXT FROM CBKP INTO @BASE
	WHILE  @@Fetch_Status = 0
	BEGIN
		SET @SSQL = ''USE '' + @BASE + CHAR(10) +
			--''ALTER DATABASE '' +@BASE+ '' set recovery simple'' +CHAR(10)+ 		
			''DBCC SHRINKFILE (1, truncateonly)'' + CHAR(10)+
			''DBCC SHRINKFILE (2)'' + CHAR(10)
			--+ ''ALTER DATABASE '' +@BASE+ '' set recovery FULL'' + CHAR(10)
					
		EXECUTE (@SSQL)
		PRINT (@SSQL)
	FETCH NEXT FROM CBKP INTO @BASE
	END -- FIM DO WHILE

	CLOSE CBKP
	DEALLOCATE CBKP', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'.', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=64, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20121008, 
		@active_end_date=99991231, 
		@active_start_time=40000, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

go

/*****************************************************************************************************/

USE [msdb]
go

if exists (select name from msdb..sysjobs where name = 'Update Statistics - Script') 

exec sp_delete_job 
@job_name = 'Update Statistics - Script'
go

/****** Object:  Job [Update Statistics - Script]    Script Date: 14/09/2012 11:46:23 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 14/09/2012 11:46:23 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Update Statistics - Script', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [.]    Script Date: 14/09/2012 11:46:23 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'--script update statistics
DECLARE  @BASE VARCHAR(8000), @SSQL VARCHAR(8000)

DECLARE CBKP CURSOR STATIC FOR 

SELECT 
+ NAME 

FROM sys.databases
WHERE name NOT IN (''tempdb'',''model'', ''ReportServer'', ''ReportServerTempDB'', ''cep'')   
AND NAME NOT LIKE ''%TST%''
AND NAME NOT LIKE ''%TESTE%''
AND NAME NOT LIKE ''%BKP%''
AND NAME NOT LIKE ''%BACKUP%''
AND STATE = 0 --SOMENTE BASE ONLINE
AND IS_READ_ONLY = 0 --SOMENTE BASE COM PERMISSÃO DE ESCRITA

OPEN CBKP
	FETCH NEXT FROM CBKP INTO @BASE
	WHILE  @@Fetch_Status = 0
	BEGIN
		SET @SSQL = ''USE '' + @BASE + CHAR(10) +
					''EXEC sp_updatestats'' + CHAR(10) 
					
		EXECUTE (@SSQL)
		--PRINT (@SSQL)
	FETCH NEXT FROM CBKP INTO @BASE
	END -- FIM DO WHILE

	CLOSE CBKP
	DEALLOCATE CBKP', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'.', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20120914, 
		@active_end_date=99991231, 
		@active_start_time=20000, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

go

/*****************************************************************************************************/

USE [msdb]
go

if exists (select name from msdb..sysjobs where name = 'CheckDB - Script') 

exec sp_delete_job 
@job_name = 'CheckDB - Script'
go

/****** Object:  Job [CheckDB - Script]    Script Date: 11/10/2012 09:05:10 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 11/10/2012 09:05:10 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'CheckDB - Script', 
		--@enabled=1, 
		@enabled=0,
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [.]    Script Date: 11/10/2012 09:05:11 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE  @BASE VARCHAR(8000), @SSQL VARCHAR(8000)

DECLARE CBKP CURSOR STATIC FOR 

SELECT 
+ NAME 

FROM sys.databases
WHERE name NOT IN (''tempdb'',''model'', ''ReportServer'', ''ReportServerTempDB'', ''cep'')   
AND NAME NOT LIKE ''%TST%''
AND NAME NOT LIKE ''%TESTE%''
AND NAME NOT LIKE ''%BKP%''
AND NAME NOT LIKE ''%BACKUP%''
AND STATE = 0 --SOMENTE BASE ONLINE
AND IS_READ_ONLY = 0 --SOMENTE BASE COM PERMISSÃO DE ESCRITA

OPEN CBKP
	FETCH NEXT FROM CBKP INTO @BASE
	WHILE  @@Fetch_Status = 0
	BEGIN
		SET @SSQL = ''DBCC CHECKDB (''''''+ @BASE +'''''') WITH NO_INFOMSGS''+ CHAR(10) 
										
		EXECUTE (@SSQL)
		--PRINT (@SSQL)
	FETCH NEXT FROM CBKP INTO @BASE
	END -- FIM DO WHILE

	CLOSE CBKP
	DEALLOCATE CBKP', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'.', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20121011, 
		@active_end_date=99991231, 
		@active_start_time=10000, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

go

/*****************************************************************************************************/

USE [msdb]
go

if exists (select name from msdb..sysjobs where name = 'Update Usage - Script') 

exec sp_delete_job 
@job_name = 'Update Usage - Script'
go

/****** Object:  Job [Update Usage - Script]    Script Date: 08/10/2012 15:02:20 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 08/10/2012 15:02:20 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Update Usage - Script', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [.]    Script Date: 08/10/2012 15:02:21 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'DECLARE  @BASE VARCHAR(8000), @SSQL VARCHAR(8000)

DECLARE CBKP CURSOR STATIC FOR 

SELECT 
+ NAME 

FROM sys.databases
WHERE name NOT IN (''master'', ''msdb'',''tempdb'',''model'', ''ReportServer'', ''ReportServerTempDB'', ''distribution'', ''cep'')   
AND NAME NOT LIKE ''%TST%''
AND NAME NOT LIKE ''%TESTE%''
AND NAME NOT LIKE ''%BKP%''
AND NAME NOT LIKE ''%BACKUP%''
AND STATE = 0 --SOMENTE BASE ONLINE
AND IS_READ_ONLY = 0 --SOMENTE BASE COM PERMISSÃO DE ESCRITA

OPEN CBKP
	FETCH NEXT FROM CBKP INTO @BASE
	WHILE  @@Fetch_Status = 0
	BEGIN
		SET @SSQL = ''USE '' + @BASE + CHAR(10) +
					'' DBCC UPDATEUSAGE('' + @base + '')'' + CHAR(10) 
					
		EXECUTE (@SSQL)
		PRINT (@SSQL)
	FETCH NEXT FROM CBKP INTO @BASE
	END -- FIM DO WHILE

	CLOSE CBKP
	DEALLOCATE CBKP', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'.', 
		@enabled=1, 
		@freq_type=32, 
		@freq_interval=2, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=16, 
		@freq_recurrence_factor=1, 
		@active_start_date=20121008, 
		@active_end_date=99991231, 
		@active_start_time=40000, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

go




