USE [msdb]
GO

/****** Object:  Job [E-mail: Alerta se tem Banco Suspect/Offline]    Script Date: 02/07/2012 11:51:42 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:42 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'E-mail: Alerta se tem Banco Suspect/Offline', 
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
/****** Object:  Step [passo1]    Script Date: 02/07/2012 11:51:43 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec monitordba.dbo.SP_MON_AVISOBANCOSUSPECTOFFLINE', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=10, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20101021, 
		@active_end_date=99991231, 
		@active_start_time=70000, 
		@active_end_time=175959, 
		@schedule_uid=N'f9275cb5-56cb-4784-8232-aebf1b2c2af4'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [E-mail: Aviso Backup]    Script Date: 02/07/2012 11:51:44 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:44 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'E-mail: Aviso Backup', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [passo1]    Script Date: 02/07/2012 11:51:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'declare @TableHTML varchar(max)

SET @TableHTML =    
	''<font face="Verdana" size="4">Aviso Backup</font>  
	<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="47%" id="AutoNumber1" height="50">  
	<tr>  
	<td width="27%" height="22" bgcolor="#000080"><b>  
	<font face="Verdana" size="2" color="#FFFFFF">Codigo</font></b></td>  
	<td width="39%" height="22" bgcolor="#000080"><b>  
	<font face="Verdana" size="2" color="#FFFFFF">Cliente</font></b></td>  
	<td width="90%" height="22" bgcolor="#000080"><b>  
	<font face="Verdana" size="2" color="#FFFFFF">Dt. Ult. Backup</font></b></td>  
	</tr>  
	<tr>  
	''

select
@TableHTML = @TableHTML + ''<tr><td><font face="Verdana" size="1">'' + 
				ISNULL(CONVERT(VARCHAR(100), Ind.nCliente), '''') +''</font></td>'' +    
	''<td><font face="Verdana" size="1">'' + ISNULL(CONVERT(VARCHAR(100), Cli.sNome),'''') + ''</font></td>'' +   
	''<td><font face="Verdana" size="1">'' + ISNULL(CONVERT(VARCHAR, MAX(Ind.dConclusao), 102),'''') + '' '' + ISNULL(CONVERT(VARCHAR, MAX(Ind.dConclusao),108),''-'')+ ''</font></td>'' +'' </tr>''   
from
	Tb_MON_Mov_IndicadoresMonitor Ind
inner join 
	Tb_MON_Cad_Clientes Cli on 
		Ind.nCliente = Cli.ncodigo
where
	Cli.sNome not like ''%Vivara%''
	and cli.sNome not like ''%Ara%daslu%''
	and cli.sNome not like ''%JV%daslu%''
	and cli.snome not like ''%Manoel Bernardes - Culture%''
	and cli.snome not like ''%napoleonsd%''
	and cli.snome not like ''nuova''
	and cli.snome not like ''ConvexTS 2.5''
	and cli.snome <> ''Rimele 0.2''
	and cli.flgAtivo = 1 -- somente clientes que ainda estejam ativo
group by
	Ind.nCliente
	,Cli.sNome
having
	MAX(Ind.dConclusao) < GETDATE()-1
order by 
	MAX(Ind.dConclusao)



SELECT @TableHTML =  @TableHTML + ''</table>''


EXEC msdb.dbo.sp_send_dbmail  
	@profile_name = ''captasql2'',    
	@recipients=''sql.server@capta.com.br'',
	@subject = ''Aviso Backup'',    
	@body = @TableHTML,    
	@body_format = ''HTML'' ;


--exec monitordba.dbo.SP_MON_SEL_BDExpressProxLimite', 
		@database_name=N'MonitorDBA', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20101014, 
		@active_end_date=99991231, 
		@active_start_time=60000, 
		@active_end_time=235959, 
		@schedule_uid=N'531757c9-1c7f-4ced-9e26-d6dfd005766f'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [E-mail: Aviso Defrag]    Script Date: 02/07/2012 11:51:44 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:44 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'E-mail: Aviso Defrag', 
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
/****** Object:  Step [passo1]    Script Date: 02/07/2012 11:51:44 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec SP_MON_AVISODEFRAG', 
		@database_name=N'MonitorDBA', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20101126, 
		@active_end_date=99991231, 
		@active_start_time=73000, 
		@active_end_time=235959, 
		@schedule_uid=N'cbe8b525-9d54-4a72-987b-08cb3756e006'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Email: Aviso Integridade dos Backups]    Script Date: 02/07/2012 11:51:44 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:44 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Email: Aviso Integridade dos Backups', 
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
/****** Object:  Step [.]    Script Date: 02/07/2012 11:51:45 ******/
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
		@command=N'use monitordba
go

select e.cod, c.sNome, e.data, e.erro 
into #Tb_MON_Integridade_Backup_Erro_Final
from Tb_MON_Integridade_Backup_Erro e
left join Tb_MON_Cad_Clientes c on c.ncodigo = e.cod and c.flgAtivo = 1
order by 3 desc
go

DECLARE @TableHTML  VARCHAR(MAX)

SELECT 
	@TableHTML =   
	''</table> 
	<br>
	<br>
	<tr>
	<tr>
	 <table id="AutoNumber1" style="BORDER-COLLAPSE: collapse" borderColor="#111111" height="40" cellSpacing="0" cellPadding="0" width="933" border="1">
	  <tr>
		<td width="35%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Codigo</font></b></td>
		<td width="23%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Cliente</font></b></td>
		<td width="23%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Data</font></b></td>
		<td width="30%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Erro</font></b></td>
	  </tr>''


select 
@TableHTML =  @TableHTML + 
	''<tr><td><font face="Verdana" size="1">'' + isnull(convert(varchar,cod), '''') +''</font></td>'' + 
''<td><font face="Verdana" size="1">'' + isnull(snome, '''') +''</font></td>'' + 
''<td><font face="Verdana" size="1">'' + isnull(convert(varchar,data), '''') +''</font></td>'' + 
''<td><font face="Verdana" size="1">'' + isnull(erro, '''') +''</font></td></tr>''   
from #Tb_MON_Integridade_Backup_Erro_Final

SELECT 
	@TableHTML =  @TableHTML + ''</table>'' +   
	''<p style="margin-top: 0; margin-bottom: 0">&nbsp;</p>
	<hr color="#000000" size="1">
	<p><font face="Verdana" size="2"><b>Responsável: sql.server@capta.com.br </font></p>  
	<p style="margin-top: 0; margin-bottom: 0"><font face="Verdana" size="2">Obrigado. []s,</font></p>  
	<p style="margin-top: 0; margin-bottom: 0"><font face="Verdana" size="2">DBA</font></p>  
	<p>&nbsp;</p>''  

	
--print @TableHTML

if (select count(cod) from #Tb_MON_Integridade_Backup_Erro_Final) > 0

EXEC msdb.dbo.sp_send_dbmail  
	@profile_name = ''captasql2'',    
	@recipients=''nelson.hamilton@capta.com.br'',    
	@subject = ''Integridade de Backups - ALERTA!!!'',    
	@body = @TableHTML,    
	@body_format = ''HTML'' ;    

else

EXEC msdb.dbo.sp_send_dbmail  
	@profile_name = ''captasql2'',    
	@recipients=''sql.server@capta.com.br'',    
	@subject = ''Integridade de Backups OK'',    
	@body = @TableHTML,    
	@body_format = ''HTML'' ; 



drop table #Tb_MON_Integridade_Backup_Erro_Final', 
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
		@active_start_time=60000, 
		@active_end_time=235959, 
		@schedule_uid=N'8761ad81-b17a-4f5e-b72e-277b6c62775a'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [E-mail: Banco Suspect/Offline]    Script Date: 02/07/2012 11:51:45 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:45 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'E-mail: Banco Suspect/Offline', 
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
/****** Object:  Step [passo1]    Script Date: 02/07/2012 11:51:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'--****************************************************************************************************************************
--Banco Suspect
--****************************************************************************************************************************
set nocount on 
declare @codcli numeric
set @codcli = 416

--drop table #tb_dba_sp_helpdb
create table #tb_dba_sp_helpdb
(
[name] varchar(100) null
,[db_size] varchar(100) null
,owner varchar(100) null
,dbid int null
,[created] varchar(20) null
,status varchar(1000) null
,[compatibility_level] int null
)

insert into #tb_dba_sp_helpdb
exec sp_helpdb 


insert into monitordba.dbo.Tb_Mon_Mov_BDClienteSuspect 
(
codcli
, nomebd
, db_size
, [owner]
,DBID
,[created]
,[status]
,[compatibility_level]
)
select 
@codcli codcli
,[name]
,[db_size]
,[owner]
,dbid
,[created]
,[status]
,[compatibility_level]
from 
#tb_dba_sp_helpdb
where
charindex(''Status=ONLINE'', ISNULL([status],'' ''),0) <> 1
--****************************************************************************************************************************
--Banco Suspect
--****************************************************************************************************************************

', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20101021, 
		@active_end_date=99991231, 
		@active_start_time=70000, 
		@active_end_time=175959, 
		@schedule_uid=N'ce1004a0-6454-46fa-a9fe-b204fb17df2a'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [E-mail: BD com índice acima 40%]    Script Date: 02/07/2012 11:51:45 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:45 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'E-mail: BD com índice acima 40%', 
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
/****** Object:  Step [passo1]    Script Date: 02/07/2012 11:51:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec monitordba.dbo.sp_mon_sel_bd_indiceacima40porcento', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20110106, 
		@active_end_date=99991231, 
		@active_start_time=70000, 
		@active_end_time=235959, 
		@schedule_uid=N'aa762296-c2e2-4f9e-9d19-7a8a1bb0b47d'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [E-mail: cversaos e cversis]    Script Date: 02/07/2012 11:51:45 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:45 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'E-mail: cversaos e cversis', 
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
/****** Object:  Step [passo1]    Script Date: 02/07/2012 11:51:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec sp_mon_cversaos_cversis', 
		@database_name=N'MonitorDBA', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20101014, 
		@active_end_date=99991231, 
		@active_start_time=80000, 
		@active_end_time=235959, 
		@schedule_uid=N'87ff4a46-ea92-4365-b7b8-497f2cadb611'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [E-mail: Espaço Livre menor que espaço do tamanho dos bancos]    Script Date: 02/07/2012 11:51:45 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:45 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'E-mail: Espaço Livre menor que espaço do tamanho dos bancos', 
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
/****** Object:  Step [passo1]    Script Date: 02/07/2012 11:51:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec SP_MON_SEL_TamanhoBdCliente', 
		@database_name=N'MonitorDBA', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20101014, 
		@active_end_date=99991231, 
		@active_start_time=70000, 
		@active_end_time=235959, 
		@schedule_uid=N'f3c600f7-cc26-47c7-838c-bd8b3b607bc7'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [E-mail: Log de Banco de dados Grande]    Script Date: 02/07/2012 11:51:45 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:45 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'E-mail: Log de Banco de dados Grande', 
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
/****** Object:  Step [passo1]    Script Date: 02/07/2012 11:51:45 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec SP_MON_SEL_BDClienteLogCritico', 
		@database_name=N'MonitorDBA', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20101014, 
		@active_end_date=99991231, 
		@active_start_time=70000, 
		@active_end_time=235959, 
		@schedule_uid=N'fda3ceae-2770-4773-ab23-94009fe331ff'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [E-mail: NFE Vivara, Amsterdam e Tiffany há mais de 10 minutos]    Script Date: 02/07/2012 11:51:46 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:46 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'E-mail: NFE Vivara, Amsterdam e Tiffany há mais de 10 minutos', 
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
/****** Object:  Step [passo1]    Script Date: 02/07/2012 11:51:46 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'c:\sistemas\nfevivara.bat', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [passo2]    Script Date: 02/07/2012 11:51:46 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo2', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=3, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec monitordba.dbo.sp_mon_nfevivara10min', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Amsterdam e Tiffany]    Script Date: 02/07/2012 11:51:46 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Amsterdam e Tiffany', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec monitordba.dbo.SP_MON_SEL_NFeAcima10min', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=10, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20101221, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'7d084463-bea5-4e3d-8912-7427377c2b82'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [E-mail: Replicação Tiffany]    Script Date: 02/07/2012 11:51:46 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:46 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'E-mail: Replicação Tiffany', 
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
/****** Object:  Step [passo1]    Script Date: 02/07/2012 11:51:46 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec monitordba.dbo.SP_MON_SEL_ReplicacaoParadaTiffany', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=15, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20120630, 
		@active_end_date=99991231, 
		@active_start_time=80000, 
		@active_end_time=215959, 
		@schedule_uid=N'6bb1ab6d-3f15-4a53-a416-d530449c50cd'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [E-mail: Sinal de vida do cliente]    Script Date: 02/07/2012 11:51:46 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:46 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'E-mail: Sinal de vida do cliente', 
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
/****** Object:  Step [passo1]    Script Date: 02/07/2012 11:51:46 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec [SP_MON_SEL_FALTASINALDEVIDACLIENTE]
', 
		@database_name=N'MonitorDBA', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=30, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20101014, 
		@active_end_date=99991231, 
		@active_start_time=70000, 
		@active_end_time=185959, 
		@schedule_uid=N'9d2f6ddb-8c75-4433-a642-86efa2369663'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [E-mail: SQL no ar desde]    Script Date: 02/07/2012 11:51:46 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:46 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'E-mail: SQL no ar desde', 
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
/****** Object:  Step [passo1]    Script Date: 02/07/2012 11:51:46 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'
declare @TableHTML varchar(max)

SET @TableHTML =    
	''<font face="Verdana" size="4">Servidor CAPTASQL1 no ar</font>  
	<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="16%" id="AutoNumber1" height="50">  
	<tr>  
	<td width="16%" height="22" bgcolor="#000080"><b>  
	<font face="Verdana" size="2" color="#FFFFFF">No ar desde</font></b></td>  
	</tr>  
	<tr>  
	''

select 
@TableHTML = @TableHTML + ''<tr><td><font face="Verdana" size="1">'' + 
				ISNULL(convert(varchar,t.crdate,103) + '' '' + convert(varchar,t.crdate,108) ,'''') +''</font></td>'' +    
				'' </tr>''
from 
master.dbo.sysdatabases t
where
t.name=''tempdb''

SELECT @TableHTML =  @TableHTML + ''</table>''


EXEC msdb.dbo.sp_send_dbmail  
	@profile_name = ''captasql2'',    
	@recipients=''jose.ferreira@capta.com.br; sql.server@capta.com.br; cleber.ferrari@capta.com.br'',    
	@subject = ''Servidor CAPTASQL1 no ar'',    
	@body = @TableHTML,    
	@body_format = ''HTML'' ;
	

', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20101021, 
		@active_end_date=99991231, 
		@active_start_time=70000, 
		@active_end_time=235959, 
		@schedule_uid=N'7cab9027-168d-4a1b-8116-8da52adaa275'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento2', 
		@enabled=1, 
		@freq_type=64, 
		@freq_interval=0, 
		@freq_subday_type=0, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20101028, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'3d835072-f734-451a-a62b-8ac8bc99b80a'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Email: Taxa de Crescimento de Banco de Dados]    Script Date: 02/07/2012 11:51:46 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:46 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Email: Taxa de Crescimento de Banco de Dados', 
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
/****** Object:  Step [.]    Script Date: 02/07/2012 11:51:47 ******/
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
		@command=N'use MonitorDBA
go

--hoje
select 
c.ncodigo,
c.sNome,
''C'' as ''hoje'',
bd.nomebd, 
bd.tamanho_MB,
upper(left(isnull(t.caminho_fisico,'' ''),1)) as unidade,
convert(varchar,(isnull(e.[Espaço Livre (GB)],0))) as Espaco_Livre_GB  
--t.caminho_fisico
into #tb_TamanhoBDClientes_hoje 
from (

select Tb_MON_Mov_TamanhoBDClientes.NCLIENTE,getdate() AS DT_HISTORICO,Tb_MON_Mov_TamanhoBDClientes.versao,
Tb_MON_Mov_TamanhoBDClientes.TIPO,Tb_MON_Mov_TamanhoBDClientes.nomebd ,Tb_MON_Mov_TamanhoBDClientes.tamanho_MB ,Tb_MON_Mov_TamanhoBDClientes.ARQUIVO,Tb_MON_Mov_TamanhoBDClientes.caminho_fisico from Tb_MON_Mov_TamanhoBDClientes
inner join (
select ncliente,nomebd,max(dt_historico) as dt_historico from Tb_MON_Mov_TamanhoBDClientes where 
--nomebd=''DL_CPT2009'' and 
dt_historico<=getdate()
and caminho_fisico like ''%mdf'' 
group by ncliente,nomebd) as mov on Tb_MON_Mov_TamanhoBDClientes.nCliente = mov.nCliente 
and Tb_MON_Mov_TamanhoBDClientes.dt_historico=mov.dt_historico

) as bd
join Tb_MON_Cad_Clientes c on c.ncodigo = bd.nCliente
join Tb_DBA_tamanhobdclienteatual t on t.ncliente = c.ncodigo and t.nomebd = bd.nomebd and t.caminho_fisico = bd.caminho_fisico --and t.dt_historico = bd.dt_historico
join Tb_DBA_EspacoTotaleLivre2 e with (nolock) on e.codigo = bd.nCliente and e.unidade = upper(left(isnull(t.caminho_fisico,'' ''),1))  
where  
--c.ncodigo in (43)
--and 
bd.caminho_fisico not like ''%.ldf%''
and t.caminho_fisico not like ''%.ldf%'' 
and c.flgAtivo <> 0
--and nomebd = ''dl_cpt2009''
--group by bd.nomebd, bd.tamanho_MB, dt_historico
order by bd.tamanho_MB  desc
go

--hoje - 30 dias
select 
c.ncodigo,
c.sNome,
''B'' as ''um_mes'',
bd.nomebd, 
bd.tamanho_MB,
upper(left(isnull(t.caminho_fisico,'' ''),1)) as unidade,
convert(varchar,(isnull(e.[Espaço Livre (GB)],0))) as Espaco_Livre_GB  
--t.caminho_fisico
into #tb_TamanhoBDClientes_menos_30_dias 
from (

select Tb_MON_Mov_TamanhoBDClientes.NCLIENTE,dateADD(MM,-1,getdate()) AS DT_HISTORICO,Tb_MON_Mov_TamanhoBDClientes.versao,
Tb_MON_Mov_TamanhoBDClientes.TIPO,Tb_MON_Mov_TamanhoBDClientes.nomebd ,Tb_MON_Mov_TamanhoBDClientes.tamanho_MB ,Tb_MON_Mov_TamanhoBDClientes.ARQUIVO,Tb_MON_Mov_TamanhoBDClientes.caminho_fisico from Tb_MON_Mov_TamanhoBDClientes
inner join (
select ncliente,nomebd,max(dt_historico) as dt_historico from Tb_MON_Mov_TamanhoBDClientes where 
--nomebd=''DL_CPT2009'' and 
dt_historico<=dateADD(MM,-1,getdate())
and caminho_fisico like ''%mdf'' 
group by ncliente,nomebd) as mov on Tb_MON_Mov_TamanhoBDClientes.nCliente = mov.nCliente 
and Tb_MON_Mov_TamanhoBDClientes.dt_historico=mov.dt_historico

) as bd
join Tb_MON_Cad_Clientes c on c.ncodigo = bd.nCliente
join Tb_DBA_tamanhobdclienteatual t on t.ncliente = c.ncodigo and t.nomebd = bd.nomebd and t.caminho_fisico = bd.caminho_fisico --and t.dt_historico = bd.dt_historico
join Tb_DBA_EspacoTotaleLivre2 e with (nolock) on e.codigo = bd.nCliente and e.unidade = upper(left(isnull(t.caminho_fisico,'' ''),1))  
where  
--c.ncodigo in (43)
--and 
bd.caminho_fisico not like ''%.ldf%''
and t.caminho_fisico not like ''%.ldf%''
and c.flgAtivo <> 0
--and nomebd = ''dl_cpt2009''
--group by bd.nomebd, bd.tamanho_MB, dt_historico
order by bd.tamanho_MB  desc
go

--hoje - 60 dias
select 
c.ncodigo,
c.sNome,
''A'' as ''dois_meses'', 
bd.nomebd, 
bd.tamanho_MB,
upper(left(isnull(t.caminho_fisico,'' ''),1)) as unidade,
convert(varchar,(isnull(e.[Espaço Livre (GB)],0))) as Espaco_Livre_GB  
--t.caminho_fisico
into #tb_TamanhoBDClientes_menos_60_dias 
from (

select Tb_MON_Mov_TamanhoBDClientes.NCLIENTE,dateADD(MM,-2,getdate()) AS DT_HISTORICO,Tb_MON_Mov_TamanhoBDClientes.versao,
Tb_MON_Mov_TamanhoBDClientes.TIPO,Tb_MON_Mov_TamanhoBDClientes.nomebd ,Tb_MON_Mov_TamanhoBDClientes.tamanho_MB ,Tb_MON_Mov_TamanhoBDClientes.ARQUIVO,Tb_MON_Mov_TamanhoBDClientes.caminho_fisico from Tb_MON_Mov_TamanhoBDClientes
inner join (
select ncliente,nomebd,max(dt_historico) as dt_historico from Tb_MON_Mov_TamanhoBDClientes where 
--nomebd=''DL_CPT2009'' and 
dt_historico<=dateADD(MM,-2,getdate())
and caminho_fisico like ''%mdf'' 
group by ncliente,nomebd) as mov on Tb_MON_Mov_TamanhoBDClientes.nCliente = mov.nCliente 
and Tb_MON_Mov_TamanhoBDClientes.dt_historico=mov.dt_historico

) as bd
join Tb_MON_Cad_Clientes c on c.ncodigo = bd.nCliente
join Tb_DBA_tamanhobdclienteatual t on t.ncliente = c.ncodigo and t.nomebd = bd.nomebd and t.caminho_fisico = bd.caminho_fisico --and t.dt_historico = bd.dt_historico
join Tb_DBA_EspacoTotaleLivre2 e with (nolock) on e.codigo = bd.nCliente and e.unidade = upper(left(isnull(t.caminho_fisico,'' ''),1))  
where  
--c.ncodigo in (43)
--and 
bd.caminho_fisico not like ''%.ldf%''
and t.caminho_fisico not like ''%.ldf%''
and c.flgAtivo <> 0
--and nomebd = ''dl_cpt2009''
--group by bd.nomebd, bd.tamanho_MB, dt_historico
order by bd.tamanho_MB  desc
go

select * into tb_TamanhoBDClientes_Geral from 
(select * from #tb_TamanhoBDClientes_hoje 
union 
select * from #tb_TamanhoBDClientes_menos_30_dias 
union 
select * from #tb_TamanhoBDClientes_menos_60_dias) TB

-- declarando duas variáveis
DECLARE @Colunas VARCHAR(MAX), @SQL NVARCHAR(MAX)

-- montando a coluna do pivot dinamicamente
SET @Colunas = STUFF(
                                  (SELECT  '', '' + QUOTENAME(CAST(hoje AS VARCHAR(MAX))) 
                FROM tb_TamanhoBDClientes_Geral GROUP BY hoje ORDER BY hoje asc
                FOR XML PATH('''')), 1,2,'''')
                
SET @SQL = N''''
SET @SQL = @SQL + N'' SELECT ncodigo, snome, nomebd, unidade, espaco_livre_gb,'' +  @Colunas 
SET @SQL = @SQL + N'' into tb_BD FROM tb_TamanhoBDClientes_Geral''
SET @SQL = @SQL + N'' PIVOT (max(tamanho_mb) FOR hoje IN ('' + @Colunas + '')) Z''
EXEC SP_EXECUTESQL @SQL
--print @sql

create table #tb_bdclientes
(
codigo int,
cliente varchar(50),
banco varchar(50),
unidade varchar(1),
espaco_livre_gb decimal (19,2),
[60_dias] decimal(19,2),
[30_dias] decimal(19,2),
[Atual] decimal(19,2)
)

insert into #tb_bdclientes
select * from tb_BD

--select convert(varchar,(dateadd(mm, -2, getdate())),103) + ''  #######  '' + convert(varchar,(dateadd(mm, -1, getdate())),103) + ''  #######  '' +  convert(varchar,getdate(), 103) as Data_Referencia
--declare @datas varchar(500)
--set @datas = convert(varchar,(dateadd(mm, -2, getdate())),103) + ''  #######  '' + convert(varchar,(dateadd(mm, -1, getdate())),103) + ''  #######  '' +  convert(varchar,getdate(), 103) 
select 
--@datas as Datas_Referencia,
--(select convert(varchar,getdate(), 103)) as Data_Referencia,
cliente, 
banco, 
unidade,
(espaco_livre_gb * 1024) as espaco_livre_mb,
[60_dias], 
[30_dias], 
[Atual], 
convert(decimal(19,2),((([Atual] / [60_dias]) - 1) * 100)) as [Taxa_Crescimento_%],
case when abs(([Atual] - [60_dias])) >= 1 and [Atual] > [60_dias] then 
convert(decimal(19,0),(((espaco_livre_gb * 1024) * 2) / ([Atual] - [60_dias]))) 
else 
0
end as [Meses_Disco_FULL]
into #tb_db_html
from #tb_bdclientes
WHERE ATUAL>1000
order by 8 desc


/********************************************************************************************************************************************************/
/*************************************************************TRATAMENTO PARA MANDAR EMAIL***************************************************************/
/********************************************************************************************************************************************************/
DECLARE @TableHTML  VARCHAR(MAX)

SELECT 
	@TableHTML =   
	''</table> 
	<br>
	<br>
	<tr>
	<tr>
	 <table id="AutoNumber1" style="BORDER-COLLAPSE: collapse" borderColor="#111111" height="40" cellSpacing="0" cellPadding="0" width="933" border="1">
	  <tr>
		<td width="35%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Cliente</font></b></td>
		<td width="23%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Banco</font></b></td>
		<td width="23%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Unidade</font></b></td>
		<td width="30%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Espaco Livre (MB)</font></b></td>
		<td width="50%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">60 Dias</font></b></td>
		<td width="50%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">30 Dias</font></b></td>
			<td width="50%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Atual</font></b></td>
			<td width="50%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Taxa de Crescimento %</font></b></td>
			<td width="50%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Meses Disco FULL</font></b></td>
	  </tr>''


select 
@TableHTML =  @TableHTML + 
	''<tr><td><font face="Verdana" size="1">'' + isnull(cliente, '''') +''</font></td>'' + 
''<td><font face="Verdana" size="1">'' + isnull(banco, '''') +''</font></td>'' + 
''<td><font face="Verdana" size="1">'' + isnull(unidade, '''') +''</font></td>'' + 
''<td><font face="Verdana" size="1">'' + isnull(convert(varchar,espaco_livre_mb), '''') +''</font></td>'' + 
''<td><font face="Verdana" size="1">'' + isnull(convert(varchar,[60_dias]), '''') +''</font></td>'' + 
''<td><font face="Verdana" size="1">'' + isnull(convert(varchar,[30_dias]), '''') +''</font></td>'' + 
''<td><font face="Verdana" size="1">'' + isnull(convert(varchar,[Atual]), '''') +''</font></td>'' + 
''<td><font face="Verdana" size="1">'' + isnull(convert(varchar,[Taxa_Crescimento_%]), '''') +''</font></td>'' + 
''<td><font face="Verdana" size="1">'' + isnull(convert(varchar,Meses_Disco_FULL), '''') +''</font></td></tr>'' 
from #tb_db_html

SELECT 
	@TableHTML =  @TableHTML + ''</table>'' +   
	''<p style="margin-top: 0; margin-bottom: 0">&nbsp;</p>
	<hr color="#000000" size="1">
	<p><font face="Verdana" size="2"><b>Responsável: sql.server@capta.com.br </font></p>  
	<p style="margin-top: 0; margin-bottom: 0"><font face="Verdana" size="2">Obrigado. []s,</font></p>  
	<p style="margin-top: 0; margin-bottom: 0"><font face="Verdana" size="2">DBA</font></p>  
	<p>&nbsp;</p>''  

	
--print @TableHTML


EXEC msdb.dbo.sp_send_dbmail  
	@profile_name = ''captasql2'',    
	@recipients=''sql.server@capta.com.br'',    
	@subject = ''Crescimento dos Bancos SQL'',    
	@body = @TableHTML,    
	@body_format = ''HTML'' ;    



drop table #tb_TamanhoBDClientes_hoje
drop table #tb_TamanhoBDClientes_menos_30_dias 
drop table #tb_TamanhoBDClientes_menos_60_dias 
drop table tb_TamanhoBDClientes_Geral
drop table tb_BD
drop table #tb_BDClientes
drop table #tb_db_html
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'.', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=2, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20120621, 
		@active_end_date=99991231, 
		@active_start_time=73000, 
		@active_end_time=235959, 
		@schedule_uid=N'664f6615-40e8-4c3e-a88e-9ee27c7820c9'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [E-mail: Versão Express próximo do limite]    Script Date: 02/07/2012 11:51:47 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:47 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'E-mail: Versão Express próximo do limite', 
		@enabled=1, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'capta', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [passo1]    Script Date: 02/07/2012 11:51:47 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec SP_MON_SEL_BDExpressProxLimite', 
		@database_name=N'MonitorDBA', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20101014, 
		@active_end_date=99991231, 
		@active_start_time=53000, 
		@active_end_time=235959, 
		@schedule_uid=N'cb0843af-7fa5-4798-af95-c97a85e7e8ba'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Envia E-mail]    Script Date: 02/07/2012 11:51:47 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:47 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Envia E-mail', 
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
/****** Object:  Step [passo1]    Script Date: 02/07/2012 11:51:47 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'EXEC msdb.dbo.sp_send_dbmail  
	@profile_name = ''captasql3'',    
	@recipients=''sql.server@capta.com.br; cleber.ferrari@capta.com.br'',    
	--@recipients=''jose.ferreira@capta.com.br'',    
	@subject = ''Shutdown Sistema Operacional captasql1'',    
	@body = '''',    
	@body_format = ''HTML'' ;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento', 
		@enabled=1, 
		@freq_type=64, 
		@freq_interval=0, 
		@freq_subday_type=0, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20101105, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'7ceac4f8-0a70-4ee9-9444-657593eb3f0c'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Espaço Total e Livre Tiffany]    Script Date: 02/07/2012 11:51:47 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:47 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Espaço Total e Livre Tiffany', 
		@enabled=0, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'capta', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [passo1]    Script Date: 02/07/2012 11:51:47 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec monitordba.dbo.SP_MON_SEL_EspacoTotaleLivreTiffany', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=15, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20101019, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'953eb596-dbe5-43f0-8d6c-32fe973f636b'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Limpeza de Log das Bases]    Script Date: 02/07/2012 11:51:47 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:47 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Limpeza de Log das Bases', 
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
/****** Object:  Step [.]    Script Date: 02/07/2012 11:51:47 ******/
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

FROM SYS.DATABASES
WHERE NAME NOT IN (''northwind'',''pubs'',''tempdb'',''adventureworks'', ''adventureworksdw'', ''bd_ddd'', ''AB_PDV_Garcia'')
AND STATE = 0

OPEN CBKP
	FETCH NEXT FROM CBKP INTO @BASE
	WHILE  @@Fetch_Status = 0
	BEGIN
		SET @SSQL = ''USE '' + @BASE + CHAR(10)+  
			''ALTER DATABASE '' +@BASE+ '' set recovery simple'' +CHAR(10)+ 		
			''DBCC SHRINKFILE (2)'' + CHAR(10)
					
		EXECUTE (@SSQL)
		PRINT (@SSQL)
	FETCH NEXT FROM CBKP INTO @BASE
	END -- FIM DO WHILE

	CLOSE CBKP
	DEALLOCATE CBKP

/*******************************************************************************************************************/

use AB_PDV_Garcia
go
dbcc shrinkfile(2)
go
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'limpeza de log das bases', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=43, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20120504, 
		@active_end_date=99991231, 
		@active_start_time=20000, 
		@active_end_time=235959, 
		@schedule_uid=N'01515790-2b0e-4970-b0c4-960d2fd2455a'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Sinal de vida]    Script Date: 02/07/2012 11:51:48 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:48 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Sinal de vida', 
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
/****** Object:  Step [passo1]    Script Date: 02/07/2012 11:51:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'--****************************************************************************************************************************
--Sinal de Vida
--****************************************************************************************************************************
declare @codcli int
set @codcli = 416

if
isnull(
(
select 
count(1) 
from 
monitordba.dbo.Tb_Mon_MovSinalVidaCliente
where
codcli = @codcli
)
,0)
> 0 
	update monitordba.dbo.Tb_Mon_MovSinalVidaCliente
	set
	dt_ult_sinalvida = getdate()
	where
	codcli = @codcli




if
isnull(
(
select 
count(1) 
from 
monitordba.dbo.Tb_Mon_MovSinalVidaCliente
where
codcli = @codcli
)
,0)
= 0 
	insert into monitordba.dbo.Tb_Mon_MovSinalVidaCliente values ( @codcli, getdate())

--****************************************************************************************************************************
--Sinal de Vida
--****************************************************************************************************************************




', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=10, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20110106, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'b198226f-7562-45e7-9208-96ac6c010266'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

/****** Object:  Job [Tabelas Excedentes]    Script Date: 02/07/2012 11:51:48 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:48 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Tabelas Excedentes', 
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
/****** Object:  Step [Tabelas Excedentes]    Script Date: 02/07/2012 11:51:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Tabelas Excedentes', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'SSIS', 
		@command=N'/SQL "\Tabelas_Excedentes" /SERVER "." /USER capta /PASSWORD db2010sql /DECRYPT db2010sql /CHECKPOINTING OFF /REPORTING E', 
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

/****** Object:  Job [Versao Capta - desabilitado]    Script Date: 02/07/2012 11:51:48 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 02/07/2012 11:51:48 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Versao Capta - desabilitado', 
		@enabled=0, 
		@notify_level_eventlog=2, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'capta', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [passo1]    Script Date: 02/07/2012 11:51:48 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'passo1', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'use master

declare @codcli int
set @codcli = 418

create table #tb_dba_bancos
(
nOrdem int not null identity(1,1)
,banco varchar(100) not null
)

insert into #tb_dba_bancos ( banco )
select
name
from
master.dbo.sysdatabases s
where
s.name not in ( ''master'', ''tempdb'', ''model'', ''msdb'', ''tstbho'', ''tst_horas'' )
order by 1


declare @nOrdem_Banco int
set @nOrdem_Banco = ISNULL( ( select MIN(nOrdem) from #tb_dba_bancos ),0)

--faz loop de todos os bancos de dados que estão atachados no cliente

declare @sql varchar(8000)
create table #Tb_Bancos_com_Versao
(
nOrdem int not null identity(1,1)
, banco varchar(100) 
,nr_tabelas int
)

while @nOrdem_Banco <= ISNULL( ( select MAX(nOrdem) from #tb_dba_bancos ),0)
begin 
	--checa se existem as tabelas sljlog e sljparac
	set @sql = '' insert into #Tb_Bancos_com_Versao ( banco, nr_tabelas ) select '' + CHAR(39) + (select banco from #tb_dba_bancos where nOrdem = @nOrdem_Banco) + CHAR(39) + '' ,count(distinct o.name) nr_tabelas from ''
	set @sql = @sql + (select banco from #tb_dba_bancos where nOrdem = @nOrdem_Banco) + ''.dbo.sysobjects o ''
	set @sql = @sql + '' inner join '' + (select banco from #tb_dba_bancos where nOrdem = @nOrdem_Banco) + ''.dbo.syscolumns c on c.id = o.id and o.xtype=''''U'''' and o.name in (''''sljlog'''',''''sljparac'''' ) having count(distinct o.name) > 0 ''
	exec(@sql)	
	--checa se existem as tabelas sljlog e sljparac
	set @nOrdem_Banco = @nOrdem_Banco + 1
end
--faz loop de todos os bancos de dados que estão atachados no cliente


--nesse trecho pega as informações das tabelas sljlog e sljparac
declare @nOrdem_Versao int
set @nOrdem_Versao = ( select MIN(nOrdem) from #Tb_Bancos_com_Versao )
declare @banco varchar(100)
while @nOrdem_Versao <= ( select Max(nOrdem) from #Tb_Bancos_com_Versao )
begin
	set @banco = (select banco from #Tb_Bancos_com_Versao where nOrdem = @nOrdem_Versao)
	set @sql= ''insert into monitordba.dbo.Tb_MON_MovVersaoCaptaCliente''
	set @sql = @sql + '' select ''
	set @sql = @sql + convert(varchar,@codcli)
	set @sql = @sql + '' ,banco''
	set @sql = @sql + '' ,GETDATE()''
	set @sql = @sql + '' ,(select top 1 cversaos from '' + @banco + ''.dbo.sljlog (nolock) order by datars desc)''
	set @sql = @sql + '' ,(select cversis from '' + @banco +''.dbo.sljparac (nolock) )''
	set @sql = @sql + '' from''
	set @sql = @sql + '' #Tb_Bancos_com_Versao''
	set @sql = @sql + '' where''
	set @sql = @sql + '' nOrdem = '' + convert(varchar,@nOrdem_Versao)
	set @sql = @sql + '' and nr_tabelas > 0''
	--print @sql
	exec(@sql)
	
	set @nOrdem_Versao = @nOrdem_Versao + 1
end	

--nesse trecho pega as informações das tabelas sljlog e sljparac

drop table #tb_dba_bancos
drop table #Tb_Bancos_com_Versao





', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'agendamento', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=1, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20101014, 
		@active_end_date=99991231, 
		@active_start_time=70000, 
		@active_end_time=185959, 
		@schedule_uid=N'bc1660d1-c965-4171-9239-5b3465ebc6c7'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


