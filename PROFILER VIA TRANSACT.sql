CREATE DATABASE PROFILER
GO
exec master.dbo.xp_create_subdir 'c:\trace'
go
USE PROFILER
GO
--Primeiro passo criar a tabela.
CREATE TABLE dbo.Traces(

    TextData VARCHAR(MAX) NULL,

    NTUserName VARCHAR(128) NULL,

    HostName VARCHAR(128) NULL,

    ApplicationName VARCHAR(128) NULL,

    LoginName VARCHAR(128) NULL,

    SPID INT NULL,

    Duration NUMERIC(15, 2) NULL,

    StartTime DATETIME NULL,

    EndTime DATETIME NULL,

    Reads INT,

    Writes INT,

    CPU INT,

    ServerName VARCHAR(128) NULL,

    DataBaseName VARCHAR(128),

    RowCounts INT,

    SessionLoginName VARCHAR(128))

-- Para realizar as querys de busca pela data que a query rodou.    

CREATE CLUSTERED INDEX SK01_Traces on Traces(duration)-- with(FILLFACTOR=95)
create index SK02_Traces on Traces(reads)
---------------------------------------------------------------------------Segundo passso criar o trace:


CREATE PROCEDURE [dbo].[stpCreate_Trace]

AS

BEGIN

    declare @rc int, @TraceID int, @maxfilesize bigint, @on bit, @intfilter int--, @bigintfilter bigint

    select @on = 1, @maxfilesize = 50

    -- Criação do trace

    exec @rc = sp_trace_create @TraceID output, 0, N'C:\Trace\Querys_Demoradas', @maxfilesize, NULL

    if (@rc != 0) goto error

    exec sp_trace_setevent @TraceID, 10, 1, @on

    exec sp_trace_setevent @TraceID, 10, 6, @on

    exec sp_trace_setevent @TraceID, 10, 8, @on

    exec sp_trace_setevent @TraceID, 10, 10, @on

    exec sp_trace_setevent @TraceID, 10, 11, @on

    exec sp_trace_setevent @TraceID, 10, 12, @on

    exec sp_trace_setevent @TraceID, 10, 13, @on

    exec sp_trace_setevent @TraceID, 10, 14, @on

    exec sp_trace_setevent @TraceID, 10, 15, @on

    exec sp_trace_setevent @TraceID, 10, 16, @on

    exec sp_trace_setevent @TraceID, 10, 17, @on

    exec sp_trace_setevent @TraceID, 10, 18, @on

    exec sp_trace_setevent @TraceID, 10, 26, @on

    exec sp_trace_setevent @TraceID, 10, 35, @on

    exec sp_trace_setevent @TraceID, 10, 40, @on

    exec sp_trace_setevent @TraceID, 10, 48, @on

    exec sp_trace_setevent @TraceID, 10, 64, @on

    exec sp_trace_setevent @TraceID, 12, 1,  @on

    exec sp_trace_setevent @TraceID, 12, 6,  @on

    exec sp_trace_setevent @TraceID, 12, 8,  @on

    exec sp_trace_setevent @TraceID, 12, 10, @on

    exec sp_trace_setevent @TraceID, 12, 11, @on

    exec sp_trace_setevent @TraceID, 12, 12, @on

    exec sp_trace_setevent @TraceID, 12, 13, @on

    exec sp_trace_setevent @TraceID, 12, 14, @on

    exec sp_trace_setevent @TraceID, 12, 15, @on

    exec sp_trace_setevent @TraceID, 12, 16, @on

    exec sp_trace_setevent @TraceID, 12, 17, @on

    exec sp_trace_setevent @TraceID, 12, 18, @on

    exec sp_trace_setevent @TraceID, 12, 26, @on

    exec sp_trace_setevent @TraceID, 12, 35, @on

    exec sp_trace_setevent @TraceID, 12, 40, @on

    exec sp_trace_setevent @TraceID, 12, 48, @on

    exec sp_trace_setevent @TraceID, 12, 64, @on

    --set @bigintfilter = 3000000 3 segundos
	
    exec sp_trace_setfilter @TraceID, 11, 0, 0, N'captasisapl'
	-- o primeiro parametro(coluna) 11 é o textdata o segundo parametro é o de and = 0 ou or = 1  e o ultimo é o de comparação = 0 é o igual 
    -- Set the trace status to start

    exec sp_trace_setstatus @TraceID, 1

    goto finish

    error:

    select ErrorCode=@rc

    finish:

END


--------------------------------------------------------------------------
-- cria o trace.
exec stpCreate_Trace

--cria a terceira parte



create procedure stpTeste_Trace1

AS

BEGIN

    waitfor delay '00:00:04'

END

GO

exec stpTeste_Trace1

-- Conferindo todos os dados que foram armazenados no trace.

Select Textdata, NTUserName, HostName, ApplicationName, LoginName, SPID, cast(Duration /1000/1000.00 as numeric(15,2)) Duration, Starttime,

    EndTime, Reads,writes, CPU, Servername, DatabaseName, rowcounts, SessionLoginName

FROM :: fn_trace_gettable('C:\Trace\Querys_Demoradas.trc', default)

where Duration is not null

order by Starttime

--------------------------------------------------------------------------

--depois criar esse job.


USE [msdb]
GO

/****** Object:  Job [DBA – Trace Querys Demoradas]    Script Date: 05/14/2012 14:57:56 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 05/14/2012 14:57:56 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'DBA – Trace Querys Demoradas', 
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
/****** Object:  Step [Primeiro passo para passar o trace para a tabela]    Script Date: 05/14/2012 14:57:56 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Primeiro passo para passar o trace para a tabela', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'use master 

Declare @Trace_Id int

SELECT @Trace_Id = TraceId

FROM fn_trace_getinfo(0)

where cast(value as varchar(50)) = ''C:\Trace\Querys_Demoradas.trc''

use profiler
go
exec sp_trace_setstatus  @traceid = @Trace_Id,  @status = 0 -- Interrompe o rastreamento especificado.

exec sp_trace_setstatus  @traceid = @Trace_Id,  @status = 2 --Fecha o rastreamento especificado e exclui sua definição do servidor.

Insert Into Traces(Textdata, NTUserName, HostName, ApplicationName, LoginName, SPID, Duration, Starttime,

    EndTime, Reads,writes,CPU, Servername, DatabaseName, rowcounts, SessionLoginName)

Select Textdata, NTUserName, HostName, ApplicationName, LoginName, SPID, cast(Duration /1000/1000.00 as numeric(15,2)) Duration, Starttime,

    EndTime, Reads,writes, CPU, Servername, DatabaseName, rowcounts, SessionLoginName

FROM :: fn_trace_gettable(''C:\Trace\Querys_Demoradas.trc'', default)

where Duration is not null

order by Starttime
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Deleta o trace antigo]    Script Date: 05/14/2012 14:57:56 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Deleta o trace antigo', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'CmdExec', 
		@command=N'del C:\Trace\Querys_Demoradas.trc /Q', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Cria um novo trace]    Script Date: 05/14/2012 14:57:56 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Cria um novo trace', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec dbo.stpCreate_Trace', 
		@database_name=N'profiler', 
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

--------------------------------------------------------------------------




