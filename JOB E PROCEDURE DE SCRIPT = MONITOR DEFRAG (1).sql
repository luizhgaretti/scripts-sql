USE MASTER
GO

 if exists (select name from msdb..sysjobs where name = 'sp_dba_monitordefrag')  

 drop procedure sp_dba_monitordefrag
 go

create procedure sp_dba_monitordefrag

as

declare @codcli int

set @codcli = 999

declare @msg varchar(1000)

--UNIDADE C:\
if ISNULL( ( select ISNULL( count(1),0) from sysobjects where xtype='U' and name = 'tb_dba_analisedefrag' ),0) > 0 drop table tb_dba_analisedefrag

create table tb_dba_analisedefrag

(

linha varchar(1000)

)

BULK INSERT tb_dba_analisedefrag

   FROM 'c:\sistemas\defragC.txt';

if

ISNULL(

(

select 

isnull(COUNT(1),0)

from 

tb_dba_analisedefrag 

where 

linha like '%Você deve desfragmentar este volume%'

or linha like '%You should defragment this volume%'

or linha like '%Vocˆ deve desfragmentar este volume%'

)

,0) > 0

begin

	set @msg = ''

	select @msg = @msg + linha

	from

	tb_dba_analisedefrag 

	where 

	linha is not null

	insert into [200.158.216.85].monitordba.dbo.Tb_Mon_MovDefrag ( ncodigo, unidade, dt_log, msg )

	values

	(

	@codcli

	,'C'

	,GETDATE()

	,@msg

	)

end

--UNIDADE D:\
if ISNULL( ( select ISNULL( count(1),0) from sysobjects where xtype='U' and name = 'tb_dba_analisedefrag' ),0) > 0 drop table tb_dba_analisedefrag

create table tb_dba_analisedefrag

(

linha varchar(1000)

)

BULK INSERT tb_dba_analisedefrag

   FROM 'c:\sistemas\defragD.txt';

if

ISNULL(

(

select 

isnull(COUNT(1),0)

from 

tb_dba_analisedefrag 

where 

linha like '%Você deve desfragmentar este volume%'

or linha like '%You should defragment this volume%'

or linha like '%Vocˆ deve desfragmentar este volume%'

)

,0) > 0

begin

	set @msg = ''

	select @msg = @msg + linha

	from

	tb_dba_analisedefrag 

	where 

	linha is not null

	insert into [200.158.216.85].monitordba.dbo.Tb_Mon_MovDefrag ( ncodigo, unidade, dt_log, msg )

	values

	(

	@codcli

	,'D'

	,GETDATE()

	,@msg

	)	

end

--UNIDADE E:\
if ISNULL( ( select ISNULL( count(1),0) from sysobjects where xtype='U' and name = 'tb_dba_analisedefrag' ),0) > 0 drop table tb_dba_analisedefrag

create table tb_dba_analisedefrag

(

linha varchar(1000)

)

BULK INSERT tb_dba_analisedefrag

   FROM 'c:\sistemas\defragE.txt';

if

ISNULL(

(

select 

isnull(COUNT(1),0)

from 

tb_dba_analisedefrag 

where 

linha like '%Você deve desfragmentar este volume%'

or linha like '%You should defragment this volume%'

or linha like '%Vocˆ deve desfragmentar este volume%'

)

,0) > 0

begin

	set @msg = ''

	select @msg = @msg + linha

	from

	tb_dba_analisedefrag 

	where 

	linha is not null

	insert into [200.158.216.85].monitordba.dbo.Tb_Mon_MovDefrag ( ncodigo, unidade, dt_log, msg )

	values

	(

	@codcli

	,'E'

	,GETDATE()

	,@msg

	)		

end

--UNIDADE F:\
if ISNULL( ( select ISNULL( count(1),0) from sysobjects where xtype='U' and name = 'tb_dba_analisedefrag' ),0) > 0 drop table tb_dba_analisedefrag

create table tb_dba_analisedefrag

(

linha varchar(1000)

)

BULK INSERT tb_dba_analisedefrag

   FROM 'c:\sistemas\defragF.txt';

if

ISNULL(

(

select 

isnull(COUNT(1),0)

from 

tb_dba_analisedefrag 

where 

linha like '%Você deve desfragmentar este volume%'

or linha like '%You should defragment this volume%'

or linha like '%Vocˆ deve desfragmentar este volume%'

)

,0) > 0

begin

	set @msg = ''

	select @msg = @msg + linha

	from

	tb_dba_analisedefrag 

	where 

	linha is not null

	insert into [200.158.216.85].monitordba.dbo.Tb_Mon_MovDefrag ( ncodigo, unidade, dt_log, msg )

	values

	(

	@codcli

	,'F'

	,GETDATE()

	,@msg

	)		

end

go

/***************************************************************************************************************/

--CRIAÇÃO DO JOB

USE [msdb]
go

if exists (select name from msdb..sysjobs where name = 'Monitor Defrag') 

exec sp_delete_job 
@job_name = 'Monitor Defrag'
go

/****** Object:  Job [Monitor Defrag]    Script Date: 07/11/2012 12:12:50 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 07/11/2012 12:12:50 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'Monitor Defrag', 
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
/****** Object:  Step [.]    Script Date: 07/11/2012 12:12:50 ******/
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
		@command=N'exec master.dbo.xp_cmdshell ''defrag C: -a > c:\sistemas\defragC.txt'', no_output
exec master.dbo.xp_cmdshell ''defrag D: -a > c:\sistemas\defragD.txt'', no_output
exec master.dbo.xp_cmdshell ''defrag E: -a > c:\sistemas\defragE.txt'', no_output
exec master.dbo.xp_cmdshell ''defrag F: -a > c:\sistemas\defragF.txt'', no_output

exec master.dbo.sp_dba_monitordefrag


', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'.', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=32, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20121107, 
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


