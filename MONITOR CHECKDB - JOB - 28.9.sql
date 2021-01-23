USE [msdb]
GO

/****** Object:  Job [Email: Monitor CheckDB]    Script Date: 21/06/2013 16:00:57 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 21/06/2013 16:00:58 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Email: Monitor CheckDB', 
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
/****** Object:  Step [.]    Script Date: 21/06/2013 16:00:58 ******/
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

select CDB.COD_CLI, c.sNome, CDB.DATA, CDB.JOB, CDB.SERVIDOR
into #CHECKDB
from MONITORDBA..TB_MONITOR_CHECKDB CDB
left join Tb_MON_Cad_Clientes c on c.ncodigo = CDB.COD_CLI and c.flgAtivo = 1
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
		<td width="35%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Job</font></b></td>
		<td width="30%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Server</font></b></td>
	  </tr>''


select 
@TableHTML =  @TableHTML + 
	''<tr><td><font face="Verdana" size="1">'' + isnull(convert(varchar,COD_CLI), '''') +''</font></td>'' + 
''<td><font face="Verdana" size="1">'' + isnull(snome, '''') +''</font></td>'' + 
''<td><font face="Verdana" size="1">'' + isnull(convert(varchar,data), '''') +''</font></td>'' + 
''<td><font face="Verdana" size="1">'' + isnull(job, '''') +''</font></td>'' + 
''<td><font face="Verdana" size="1">'' + isnull(SERVIDOR, '''') +''</font></td>''  
from #CHECKDB

SELECT 
	@TableHTML =  @TableHTML + ''</table>'' +   
	''<p style="margin-top: 0; margin-bottom: 0">&nbsp;</p>
	<hr color="#000000" size="1">
	<p><font face="Verdana" size="2"><b>Responsável: sql.server@capta.com.br </font></p>  
	<p style="margin-top: 0; margin-bottom: 0"><font face="Verdana" size="2">Obrigado. []s,</font></p>  
	<p style="margin-top: 0; margin-bottom: 0"><font face="Verdana" size="2">DBA</font></p>  
	<p>&nbsp;</p>''  

	
--print @TableHTML

IF EXISTS (select DATA from #CHECKDB WHERE DATA = CONVERT(VARCHAR, GETDATE(), 112))

EXEC msdb.dbo.sp_send_dbmail  
	@profile_name = ''captasql2'',    
	--@recipients=''sql.server@capta.com.br'',    
	@recipients=''NELSON.HAMILTON@capta.com.br'',    
	@subject = ''CHECKDB COM FALHA - VERIFICAR INTEGRIDADE DAS BASES!!!'',    
	@body = @TableHTML,    
	@body_format = ''HTML'' ;    

--else

--print ''Jobs OK''

--truncate table MONITORDBA..TB_MONITOR_CHECKDB

drop table #CHECKDB

--SELECT * FROM MONITORDBA.DBO.TB_MONITOR_CHECKDB', 
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
		@active_start_date=20130621, 
		@active_end_date=99991231, 
		@active_start_time=60000, 
		@active_end_time=235959, 
		@schedule_uid=N'c0ed6fa5-5a4f-4b69-aed8-d4a55e410849'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO

