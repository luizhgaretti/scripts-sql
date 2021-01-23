
-- status da replicação log shipping / espelhamento com aviso de e-mail...

USE [msdb]
GO
/****** Object:  Job [verifica status replicacao]    Script Date: 01/20/2012 15:19:22 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 01/20/2012 15:19:23 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'verifica status replicacao', 
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
/****** Object:  Step [passo1]    Script Date: 01/20/2012 15:19:23 ******/
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
		@command=N'use coliseu
/*
State of the mirror database and of the database mirroring session.
0 = Suspended
1 = Disconnected from the other partner
2 = Synchronizing 
3 = Pending Failover
4 = Synchronized
5 = The partners are not synchronized. Failover is not possible now.
6 = The partners are synchronized. Failover is potentially possible. For information about the requirements for failover see, Synchronous Database Mirroring (High-Safety Mode). 
NULL = Database is inaccessible or is not mirrored. 
*/


select ISNULL( ( select espelhamento.mirroring_state from sys.database_mirroring (nolock) espelhamento inner join sys.databases (nolock) bancos on bancos.database_id = espelhamento.database_id and bancos.name= ''coliseu'' ),0)
if ISNULL( ( select espelhamento.mirroring_state from sys.database_mirroring (nolock) espelhamento inner join sys.databases (nolock) bancos on bancos.database_id = espelhamento.database_id and bancos.name= ''coliseu'' ),0) <> 4
begin

	declare @TableHTML varchar(max)

	SET @TableHTML =    
		''<font face="Verdana" size="4">Espelhamento Coliseu</font>  
		<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="100%" id="AutoNumber1" height="50">  
		<tr>  
		<td width="50%" height="22" bgcolor="#000080"><b>  
		<font face="Verdana" size="2" color="#FFFFFF">Codigo</font></b></td>  
		<td width="50%" height="22" bgcolor="#000080"><b>  
		<font face="Verdana" size="2" color="#FFFFFF">Descrição</font></b></td>  
		</tr>  
		''



	select
	@TableHTML = @TableHTML + ''<tr><td><font face="Verdana" size="1">'' + 
					convert(varchar,espelhamento.mirroring_state) +''</font></td>'' +    
		''<td><font face="Verdana" size="1">'' + ISNULL(espelhamento.mirroring_state_desc,'''') + ''</font></td>'' 
		+'' </tr>''   
	FROM 
	sys.database_mirroring (nolock) espelhamento
	inner join sys.databases (nolock) bancos on bancos.database_id = espelhamento.database_id and bancos.name= ''coliseu''


	SELECT @TableHTML =  @TableHTML + ''</table>''


	EXEC msdb.dbo.sp_send_dbmail  
		@profile_name = ''coliseu'',    
		@recipients=''jose.ferreira@capta.com.br;sql.server@capta.com.br'',    
		--@recipients=''jose.ferreira@capta.com.br'',    
		@subject = ''*** Replicação Coliseu ***'',    
		@body = @TableHTML,    
		@body_format = ''HTML'' ;

end
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
		@active_start_date=20110201, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
