USE [msdb]
go

/****** Object:  Job [CPU - Memoria Servidores]    Script Date: 13/09/2012 10:06:36 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 13/09/2012 10:06:36 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'CPU - Memoria Servidores', 
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
/****** Object:  Step [,]    Script Date: 13/09/2012 10:06:36 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N',', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'/*
use monitordba
go

--drop table Tb_MON_Mem_CPU

create table Tb_MON_Mem_CPU
(
codcli int,
--nomecli varchar(100),
servidor varchar(100),
cpu int,
memoria int,
data datetime,
banco varchar(100),
tamanhobd decimal(18,4)
)
*/

declare @codcli int
set @codcli = 999

if exists (select codcli from [200.158.216.85].monitordba.dbo.Tb_MON_Mem_CPU where codcli = @codcli)

update [200.158.216.85].monitordba.dbo.Tb_MON_Mem_CPU
set a.cpu = b.cpu_count, a.memoria = ((b.physical_memory_in_bytes/1024)/1024/1024 + 1), a.data = getdate()
from [200.158.216.85].monitordba.dbo.Tb_MON_Mem_CPU a
join sys.dm_os_sys_info b on a.servidor = (select @@servername) and a.codcli = @codcli

else

insert into [200.158.216.85].monitordba.dbo.Tb_MON_Mem_CPU

select @codcli as cod_cli, (select @@servername) as servidor, cpu_count as cpus, ((physical_memory_in_bytes/1024)/1024/1024 + 1) as memoria_gb, getdate()
from sys.dm_os_sys_info', 
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
		@active_start_date=20120913, 
		@active_end_date=99991231, 
		@active_start_time=60000, 
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

/*************************************************************************************************************************************************/

if exists (select name from msdb..sysjobs where name = 'Limpeza Log / Tabelas Temporarias') 

exec sp_delete_job 
@job_name = 'Limpeza Log / Tabelas Temporarias'
go

/****** Object:  Job [Limpeza Log / Tabelas Temporarias]    Script Date: 13/09/2012 10:06:36 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 13/09/2012 10:06:36 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Limpeza Log / Tabelas Temporarias', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Nenhuma descrição disponível.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Desconectar Usuarios]    Script Date: 13/09/2012 10:06:36 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Desconectar Usuarios', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'--MATA PROCESSOS PRESOS NOS BANCOS
exec sp_killuser [captarmtdb]
exec sp_killuser [captasup]
exec sp_killuser [usuarios]
exec sp_killuser [user]
exec sp_killuser [usuprocs]
exec SP_KILLUSER [CAPTA_VS]
go


--LIMPA A TABELA CPTLIC
DECLARE  @BASE VARCHAR(8000), @SSQL VARCHAR(8000)

DECLARE CBKP CURSOR STATIC FOR 

SELECT 
+ NAME 

FROM MASTER.dbo.sysdatabases   
WHERE name NOT IN (''master'', ''msdb'',''tempdb'',''model'',''distribution'', ''cep'')   
AND NAME NOT LIKE ''%TST%''
AND NAME NOT LIKE ''%TESTE%''
AND NAME NOT LIKE ''%BKP%''
AND NAME NOT LIKE ''%BACKUP%''
AND VERSION IS NOT NULL --BASE OFFLINE
AND VERSION <> 0 --BASE OFFLINE

OPEN CBKP
	FETCH NEXT FROM CBKP INTO @BASE
	WHILE  @@Fetch_Status = 0
	BEGIN
		SET @SSQL = ''if exists (select name from '' + @BASE + ''.sys.tables where name = ''''cptlic'''')'' + char(10) +
''truncate table '' + @BASE + ''..cptlic '' + char(10) --+ ''else print '''''''''' + char(10)
										
		EXECUTE (@SSQL)
		--PRINT (@SSQL)
	FETCH NEXT FROM CBKP INTO @BASE
	END -- FIM DO WHILE

	CLOSE CBKP
	DEALLOCATE CBKP

', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Limpar Log das Bases]    Script Date: 13/09/2012 10:06:36 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Limpar Log das Bases', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC SP_MSFOREACHDB
''
IF (''''?'''' <> ''''tempdb'''')
BEGIN
USE ?

DECLARE @id_log INT;
DECLARE @execstr varchar(400);

DECLARE logShrink CURSOR FOR
 select fileid from sysfiles where status & 0x40 = 0x40 order by fileid
OPEN logShrink;
FETCH NEXT FROM logShrink INTO @id_log;
WHILE @@FETCH_STATUS = 0
BEGIN
 PRINT ''''? - Truncating e Shrinking Log File'''';
 SELECT @execstr = ''''DBCC SHRINKFILE('''' + CAST(@id_log as varchar(8)) + '''', 1)'''';
 EXEC (@execstr);
 FETCH NEXT FROM logShrink INTO @id_log;
END;
CLOSE logShrink;
DEALLOCATE logShrink;
END;
''


', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Limpar Log do TempDb]    Script Date: 13/09/2012 10:06:36 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Limpar Log do TempDb', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'dbcc shrinkfile (templog)
dbcc shrinkfile (tempdev)', 
		@database_name=N'tempdb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'Limpeza Log / Tabelas Temporárias', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20090827, 
		@active_end_date=99991231, 
		@active_start_time=35500, 
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


