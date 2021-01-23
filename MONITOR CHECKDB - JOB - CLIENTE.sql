USE [msdb]
GO

/****** Object:  Job [CheckDB - Script]    Script Date: 21/06/2013 15:58:59 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 21/06/2013 15:58:59 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'CheckDB - Script', 
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
/****** Object:  Step [.]    Script Date: 21/06/2013 15:58:59 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
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
/****** Object:  Step [..]    Script Date: 21/06/2013 15:58:59 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'..', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE MSDB
GO

DECLARE @CODCLI INT
SET @CODCLI = 999

IF EXISTS 
(SELECT 
DISTINCT 
j.name,
JH.run_date
FROM MSDB..SYSJOBS J
JOIN MSDB.. sysjobhistory JH ON J.JOB_ID = JH.job_id AND JH.run_status = 0 AND J.enabled = 1
WHERE CONVERT(VARCHAR,JH.run_date) = CONVERT(VARCHAR,GETDATE(), 112) 
AND J.NAME LIKE ''%CheckDB%'')

BEGIN 

IF EXISTS (SELECT COD_CLI FROM [200.158.216.85].MONITORDBA.DBO.TB_MONITOR_CHECKDB WHERE COD_CLI = @CODCLI)

UPDATE [200.158.216.85].MONITORDBA.DBO.TB_MONITOR_CHECKDB
SET DATA = CONVERT(VARCHAR,GETDATE(), 112) 

ELSE

INSERT INTO [200.158.216.85].MONITORDBA.DBO.TB_MONITOR_CHECKDB
SELECT 
DISTINCT
@CODCLI AS COD_CLI,
J.NAME, 
(SELECT @@SERVERNAME) AS SERVIDOR,
/*
SUBSTRING(CONVERT(VARCHAR, JH.run_date), 7,2) + ''/'' + SUBSTRING(CONVERT(VARCHAR, JH.run_date), 5,2) + ''/'' + SUBSTRING(CONVERT(VARCHAR, JH.run_date), 1,4)  + ''  '' + 
CASE LEN(JH.run_time)
WHEN 5 THEN ''0'' + SUBSTRING(CONVERT(VARCHAR, JH.run_time), 1,1) + '':'' + SUBSTRING(CONVERT(VARCHAR, JH.run_time), 2,2) + ''h'' 
WHEN 6 THEN SUBSTRING(CONVERT(VARCHAR, JH.run_time), 1,2) + '':'' + SUBSTRING(CONVERT(VARCHAR, JH.run_time), 3,2) + ''h'' 
ELSE ''Oh''
END AS RUN_DATE
*/
JH.run_date
FROM MSDB..sysjobhistory JH
JOIN MSDB..SYSJOBS J ON J.JOB_ID = JH.job_id AND JH.run_status = 0 AND J.enabled = 1
WHERE CONVERT(VARCHAR,JH.run_date) = CONVERT(VARCHAR,GETDATE(), 112) 
AND J.NAME LIKE ''%CheckDB%''

END', 
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
		@active_end_time=235959, 
		@schedule_uid=N'41a45f57-23e6-42fb-9931-75bf309d9a18'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

