--EXEC msdb..sp_delete_backuphistory @oldest_date = '2012-08-10'

--select physical_device_name from msdb..backupmediafamily


USE [msdb]
GO

/****** Object:  Job [Verifica Integridade dos Backups]    Script Date: 28/06/2012 14:25:02 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 28/06/2012 14:25:02 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Verifica Integridade dos Backups', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'capta', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [.]    Script Date: 28/06/2012 14:25:02 ******/
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
		@command=N'create table #backup_erro
(
cod int,
data varchar(20),
erro varchar(500)
)

DECLARE  @BASE varchar(8000),@CAMINHO VARCHAR(8000), @SSQL VARCHAR(8000), @caminho2 as varchar(800)
set @caminho2 = ''d:\databases\Backup\''

DECLARE CBKP CURSOR STATIC FOR 

select 
db.database_name, dbf.physical_device_name 
from msdb..backupset db
join msdb..backupmediafamily dbf on dbf.media_set_id = db.media_set_id 
where dbf.physical_device_name like '''' + @caminho2 + ''%''
and backup_finish_date in 
						(select max(backup_finish_date) from msdb..backupset 
							--where convert(varchar,backup_finish_date, 112) <= dateadd(dd, -1, (convert(varchar,GETDATE(), 112))) 
								group by database_name )

OPEN CBKP
	FETCH NEXT FROM CBKP INTO @BASE, @CAMINHO
	WHILE  @@Fetch_Status = 0
	BEGIN

		SET @SSQL =
		''declare @codcli int, @backupSetId as int
		 set @codcli = 61
		select @backupSetId = position from msdb..backupset where database_name = '''''' + @base  + '''''' 
	and backup_set_id=(select max(backup_set_id) from msdb..backupset where database_name= '''''' + @base + '''''' )
if @backupSetId is null 
begin 
insert into #backup_erro
select cod = @codcli, GETDATE(), ''''Verify failed. Backup information for database '' + @base + '' not found.'''' 
end
BEGIN TRY
RESTORE VERIFYONLY FROM DISK = '' + '''''''' + @CAMINHO + '''''''' + '' WITH  FILE = @backupSetId,  NOUNLOAD,  NOREWIND
END TRY
BEGIN CATCH
insert into #backup_erro
select cod = @codcli, getdate(), ''''VERIFY DATABASE '' + @base + '' is terminating abnormally.'''' 
END CATCH'' + char(10) 

		EXECUTE (@SSQL)
		--PRINT (@SSQL)
	FETCH NEXT FROM CBKP INTO  @BASE, @CAMINHO
	END -- FIM DO WHILE

	CLOSE CBKP
	DEALLOCATE CBKP

	insert into [200.158.216.85].monitordba.dbo.Tb_MON_Integridade_Backup_Erro
			select cod, (convert(varchar,data, 103)) as data, erro 
			from #backup_erro
				where data in (select max(data) from #backup_erro group by erro)

	drop table #backup_erro', 
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
		@active_start_date=20120628, 
		@active_end_date=99991231, 
		@active_start_time=003000, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


/********************************************************************************************************************************************************/


USE [msdb]
GO

/****** Object:  Job [Jobs Ativos]    Script Date: 20/07/2012 14:29:09 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 20/07/2012 14:29:09 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Jobs Ativos', 
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
/****** Object:  Step [.]    Script Date: 20/07/2012 14:29:10 ******/
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
		@command=N'use msdb
go

declare @codcli int
set @codcli = 61

select
distinct 
@codcli as codcli,
getdate() as data,
j.name as job,
h.server, 
a.last_executed_step_date, 
a.next_scheduled_run_date, 
(((DATEPART(MINUTE,getdate())) - (DATEPART(MINUTE,a.start_execution_date))) +
	(((DATEPART(HOUR,getdate())) - (DATEPART(HOUR,a.start_execution_date)))/60) /60) as [tempo_em_execucao (horas)], 
a.stop_execution_date
into #jobs_ativos_tmp
from sysjobactivity a
left join sysjobhistory h on h.job_id = a.job_id
left join sysjobs j on j.job_id = a.job_id
where datediff(MINUTE,start_execution_date,getdate()) > 5
and start_execution_date is not null
and stop_execution_date is null
and a.start_execution_date in (select max(start_execution_date) from sysjobactivity a left join sysjobs j on j.job_id = a.job_id group by j.name)


if (select count(*) from #jobs_ativos_tmp) > 0

insert into [200.158.216.85].monitordba.dbo.jobs_ativos
select 
codcli,
data,
job,
server,
[tempo_em_execucao (horas)]
from #jobs_ativos_tmp

drop table #jobs_ativos_tmp', 
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
		@active_start_date=20120720, 
		@active_end_date=99991231, 
		@active_start_time=63000, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO



