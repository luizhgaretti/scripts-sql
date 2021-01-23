USE MSDB
GO

BEGIN TRANSACTION

DECLARE @ReturnCode INT
SELECT @ReturnCode = 0

IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1) BEGIN
	EXECUTE @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
	IF (@@ERROR <> 0 OR @ReturnCode <> 0) BEGIN
		GOTO QuitWithRollback
	END
END

DECLARE @jobId BINARY(16)
EXECUTE @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'MONITORA_EXECUCAO_CPTAGEND_CLIENTE', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'capta', @job_id = @jobId OUTPUT

IF (@@ERROR <> 0 OR @ReturnCode <> 0) BEGIN
	GOTO QuitWithRollback
END

EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, 
		@subsystem=N'TSQL', 
		@command=N'DECLARE @DBProfile VARCHAR(100)
					DECLARE @HOSTNAME VARCHAR(100)
					DECLARE @IP VARCHAR(100)

					IF EXISTS (SELECT NAME FROM TEMPDB.SYS.TABLES WHERE NAME LIKE '' + '' +''%#TB_DBA_HOSTNAME%'') BEGIN
						DROP TABLE #TB_DBA_HOSTNAME
					END

					IF EXISTS (SELECT NAME FROM TEMPDB.SYS.TABLES WHERE NAME LIKE '' + '' +''%#TB_DBA_IP%'') BEGIN
						DROP TABLE #TB_DBA_IP
					END

					CREATE TABLE #TB_DBA_HOSTNAME (HOSTNAME VARCHAR(100))

					INSERT INTO #TB_DBA_HOSTNAME EXECUTE MASTER..XP_CMDSHELL ''HOSTNAME''

					SELECT @HOSTNAME = HOSTNAME FROM #TB_DBA_HOSTNAME WHERE HOSTNAME IS NOT NULL

					CREATE TABLE #TB_DBA_IP (IP VARCHAR(800))

					INSERT INTO #TB_DBA_IP EXECUTE MASTER..XP_CMDSHELL ''IPCONFIG''

					SELECT @IP = IP FROM #TB_DBA_IP WHERE IP LIKE ''%IPV4%''

					SELECT @DBProfile=Name FROM msdb.dbo.sysmail_profile WHERE Profile_ID=1

					declare @cliente varchar(50)
					DECLARE @NICKNAME VARCHAR(100)
					
					set @cliente = ''VILLAR''
					SET @NICKNAME = ''villarsa''

					declare @string varchar(50)
					set @string = ''Capta Processos Parado no Cliente ''  + ''" '' + @cliente + '' "'' 

					declare @servername sysname
					set @servername = (select @@SERVERNAME)

					declare @string2 varchar(800)
					set @string2 = 
					''Capta Processos parado: '' + char(13) + char(13) +
					''Instância do SQL Server: '' + @servername + char(13) + 
					''Hostname do SQL Server: '' + @HOSTNAME + char(13) + 
					''IP do SQL Server: '' + @IP + char(13) + 
					''Hostname do Capta Processos: '' + @NICKNAME + CHAR(13) + CHAR(13) +
					''Favor Verificar Urgente!''

					select @string2 = @string2

					declare @nr_processos int
					set @nr_processos = isnull(
						(
						select
						count(1)
						from
						master.dbo.sysprocesses p
						inner join master.dbo.sysdatabases d on d.dbid = p.dbid 
						--and d.name like ''cptprocs%''
						and p.program_name like ''%cptagend.exe%''
						where p.spid >= 50
						)
						,0)

						if isnull(@nr_processos,0) = 0
						begin
							EXEC msdb.dbo.sp_send_dbmail  
							--@profile_name = ''captasql2'',    
							@profile_name = @DBProfile,
							@recipients=''captamon@capta.com.br'',    
							--@subject =  ''Capta Processos Parado '',
							@subject = @string,
							--@body = ''Verificar os Processos!!!'',    
							@body = @string2,   
							@body_format = ''text'' ;   
						end
					', 
					@database_name=N'master', 
					@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) BEGIN
	GOTO QuitWithRollback
END

EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1

IF (@@ERROR <> 0 OR @ReturnCode <> 0) BEGIN
	GOTO QuitWithRollback
END

EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule 
		@job_id=@jobId, 
		@name=N'agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=5,
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20100409, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959

IF (@@ERROR <> 0 OR @ReturnCode <> 0) BEGIN
	GOTO QuitWithRollback
END

EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'

IF (@@ERROR <> 0 OR @ReturnCode <> 0) BEGIN
	GOTO QuitWithRollback
END

COMMIT TRANSACTION

GOTO EndSave

QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION

EndSave:
GO