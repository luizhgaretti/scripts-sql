/*
1. Alterar o caminho do backups full e de log (XXXXX:\UOLDIVEO\Backup\Full\ e XXXXX:\UOLDIVEO\Backup\Log\)
2. Verificar se a conta de serviço do SQL Server Agent tem permissão de gravação aonde serão gravados os backups tanto full quanto de log
3. Habilitar no job o agendamento do backup full e/ou log (a janela de backup deve ser negociada com o cliente)
*/

use uoldiveodb
go

alter table dbo.uoldiveo_job_monitor
alter column threshold_execution int null

go

if exists (select * from sysobjects where id = OBJECT_ID(N'[dbo].[uoldiveo_backup_config]') and xtype in (N'U'))
drop table dbo.uoldiveo_backup_config
go

create table [dbo].[uoldiveo_backup_config](
	[database_id] [int] NULL,
	[database_name] [nvarchar](255) NULL,
	[database_state] [tinyint] NULL,
	[database_state_desc] [nvarchar](255) NULL,
	[database_user_access] [tinyint] NULL,
	[database_user_access_desc] [nvarchar](255) NULL,
	[database_recovery_model] [tinyint] NULL,
	[database_recovery_model_desc] [nvarchar](255) NULL,
	[database_is_read_only] [bit] NULL,
	[database_dat_changed_read_only] [datetime] NULL,
	[backup_full_path] [varchar](255) NULL,
	[backup_full_is_active] [bit] NULL,
	[backup_diff_path] [varchar](255) NULL,
	[backup_diff_is_active] [bit] NULL,
	[backup_log_path] [varchar](255) NULL,
	[backup_log_is_active] [bit] NULL,
	[backup_is_active_desc] [varchar](50) NULL,
	[backup_dat_inactive] [datetime] NULL
) on [primary]

go

truncate table dbo.uoldiveo_backup_config

go

insert dbo.uoldiveo_backup_config(
                 database_id
			   , database_name
			   , database_state
			   , database_state_desc
			   , database_user_access
			   , database_user_access_desc
			   , database_recovery_model
			   , database_recovery_model_desc
			   , database_is_read_only
			   , backup_full_path
			   , backup_full_is_active
			   , backup_diff_path
			   , backup_diff_is_active
			   , backup_log_path
			   , backup_log_is_active
			   , backup_is_active_desc)
select   
         dbid
        ,name
        ,case when databasepropertyex(name, 'status')='ONLINE' then 0
              else 1 end as [state]
        ,convert(nvarchar(255),databasepropertyex(name, 'status')) as state_desc
        ,case when databasepropertyex(name, 'useraccess')='MULTI_USER' then 0
              when databasepropertyex(name, 'useraccess')='SINGLE_USER' then 1
              else 2 end as user_access
        ,convert(nvarchar(255),databasepropertyex(name, 'useraccess')) as user_access_desc
        ,case when databasepropertyex(name, 'recovery')='FULL'        then 1
              when databasepropertyex(name, 'recovery')='BULK_LOGGED' then 2 
              else 3 end as recovery_model
        ,convert(nvarchar(255),databasepropertyex(name, 'recovery')) as recovery_model_desc
        ,case when databasepropertyex(name, 'updateability')='READ_WRITE' then 0
              else 1 end as is_read_only
		,'XXXXX:\UOLDIVEO\Backup\Full\'     as backup_full_path
		,1                                  as backup_full_is_active
		,'NÃO APLICADO'                     as backup_diff_path
		,0                                  as backup_diff_is_active
		,'XXXXX:\UOLDIVEO\Backup\Log\'      as backup_log_path
		,case when databasepropertyex(name, 'recovery')='FULL' then 1 
		      when databasepropertyex(name, 'recovery')='BULK_LOGGED' then 1
              else 0 end                    as backup_log_is_active
		,'Ativo'
from     master.dbo.sysdatabases
where    dbid not in(2,3)
and      name<>'ReportServerTempDB'
order by dbid
       
go


/****** Object:  StoredProcedure [dbo].[usp_uoldiveo_backup_full]    Script Date: 07/11/2013 23:07:32 ******/
if exists (select * from sysobjects where id = OBJECT_ID(N'[dbo].[usp_uoldiveo_backup_full]') and xtype in (N'P', N'PC'))
drop procedure [dbo].[usp_uoldiveo_backup_full]
go

/****** Object:  StoredProcedure [dbo].[usp_uoldiveo_backup_full]    Script Date: 07/11/2013 23:07:32 ******/

create procedure [dbo].[usp_uoldiveo_backup_full]
as
declare @db_name  varchar(255)   -- nome do banco de dados  
declare @path     varchar(255)  -- caminho dos arquivos de backup  
declare @filename varchar(255)  -- nome para o arquivo de backup
declare @sql      varchar(1000) -- comando sql para executar o backup 

---Verifica se existem novos bancos de dados no ambiente


insert dbo.uoldiveo_backup_config(  database_id
        , database_name
        , database_state
        , database_state_desc
        , database_user_access
        , database_user_access_desc
        , database_recovery_model
        , database_recovery_model_desc
        , database_is_read_only
        , backup_full_path
        , backup_full_is_active
        , backup_diff_path
        , backup_diff_is_active
        , backup_log_path
        , backup_log_is_active
        , backup_is_active_desc)                     
select   d.dbid
        ,d.[name]
        ,case when databasepropertyex(name, 'status')='ONLINE' then 0
              else 1 end as state
        ,convert(nvarchar(255),databasepropertyex(name, 'status')) as state_desc
        ,case when databasepropertyex(name, 'useraccess')='MULTI_USER' then 0
              when databasepropertyex(name, 'useraccess')='SINGLE_USER' then 1
              else 2 end as user_access
        ,convert(nvarchar(255),databasepropertyex(name, 'useraccess')) as user_access_desc
        ,case when databasepropertyex(name, 'recovery')='FULL'        then 1
              when databasepropertyex(name, 'recovery')='BULK_LOGGED' then 2 
              else 3 end as recovery_model
        ,convert(nvarchar(255),databasepropertyex(name, 'recovery')) as recovery_model_desc
        ,case when databasepropertyex(name, 'updateability')='READ_WRITE' then 0
              else 1 end as is_read_only
        ,(select top 1 backup_full_path from dbo.uoldiveo_backup_config)            as backup_full_path
        ,1                                                              as backup_full_is_active
        ,'NÃO APLICADO'                                                 as backup_diff_path
        ,0                                                              as backup_diff_is_active
        ,(select top 1 backup_log_path from uoldiveo_backup_config)  as backup_log_path
        ,case when databasepropertyex(name, 'recovery')='FULL'        then 1
              when databasepropertyex(name, 'recovery')='BULK_LOGGED' then 1 
              else 0 end as backup_log_is_active
        ,'Ativo'
from master.dbo.sysdatabases as d left join  dbo.uoldiveo_backup_config as b
on      d.dbid = b.database_id
where   b.database_id is null 
and     d.dbid not in(2,3)


---Atualiza estado do banco de dados
update dbo.uoldiveo_backup_config
set    database_state        = 100 --- banco de dados que não existe mais na instância do SQL Server 
      ,backup_is_active_desc = 'Inativo'
      ,backup_dat_inactive = getdate() ----Data que o backup foi desabilitado (data que o banco foi deletado do ambiente)
where  database_id not in(select dbid from master.dbo.sysdatabases where dbid not in(2,3))

---Atualiza estado do banco de dados e grava um novo status para a execução do backup 
update a
set    a.database_name = b.[name]
      ,a.database_state                    = case when databasepropertyex(b.[name], 'status')='ONLINE' then 0 else 1 end
      ,a.database_state_desc               = convert(nvarchar(255),databasepropertyex(b.[name], 'status'))
      ,a.database_user_access              = case when databasepropertyex(b.[name], 'useraccess')='MULTI_USER' then 0 when databasepropertyex(b.[name], 'useraccess')='SINGLE_USER' then 1 else 2 end
      ,a.database_user_access_desc         = convert(nvarchar(255),databasepropertyex(b.[name], 'useraccess')) 
      ,a.backup_full_is_active             = case when databasepropertyex(b.[name], 'status')<>'ONLINE' or databasepropertyex(b.[name], 'useraccess') not in('MULTI_USER','RESTRICTED_USER') then 0 else 1 end
from   dbo.uoldiveo_backup_config as a 
inner join
       master.dbo.sysdatabases as b
on     a.database_id = b.dbid     


declare db_cursor cursor for 
 
select database_name
      ,backup_full_path
from   dbo.uoldiveo_backup_config
where  database_state = 0              ---bancos de dados com estado "ONLINE"
and    database_user_access = 0        ---bancos de dados com acesso "MULTI_USER"
and    backup_full_is_active = 1       ---bancos de dados com backup full "ATIVO"
and    backup_is_active_desc = 'Ativo' ---bancos de dados com backup "ATIVO"

open db_cursor   

fetch next from db_cursor into @db_name,@path   

while @@fetch_status = 0   

begin   
       set @filename = @path + @db_name + '.bak'  
       
          if (@@microsoftversion / power(2, 24) in(8,9)) ---não existe compressão de dados no SQL Server 2000 e 2005
       
             begin
       
                set @sql= 'backup database ' + quotename(@db_name) + ' to disk = ''' + @filename + ''' with init,format'
               
                  exec(@sql)
               --print @sql
       
             end
       
          else
          
             begin
       
                set @sql= 'backup database ' + quotename(@db_name) + ' to disk = ''' + @filename + ''' with init,format, compression'
               
                exec(@sql)
               --print @sql
             
             end
             
       fetch next from db_cursor into @db_name,@path   
end   
close db_cursor   
deallocate db_cursor

go

use msdb

go

if  exists (select job_id from msdb.dbo.sysjobs_view where name = N'UOLDIVEO: Backup Full')

begin

declare @job uniqueidentifier

set     @job = (select job_id from msdb.dbo.sysjobs_view where name = N'UOLDIVEO: Backup Full')

exec msdb.dbo.sp_delete_job @job_id=@job, @delete_unused_schedule=1

end

go

begin

BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 06/10/2013 17:50:18 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'UOLDIVEO: Backup Full', 
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
/****** Object:  Step [Step 1: Grava Log Início]    Script Date: 06/10/2013 17:50:18 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Step 1: Grava Log Início', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=4, 
		@on_fail_step_id=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'insert dbo.uoldiveo_job_monitor (job_name, job_description, dat_begin_execution, dat_end_execution, time_minute_execution, status_last_execution)
select ''UOLDIVEO: Backup Full''
      ,''Job responsável pela execução do backup full dos clientes UOLDIVEO-SOLVO''
      ,getdate()
      ,null
      ,null
      ,''Executando''
', 
		@database_name=N'uoldiveodb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Step 2: Rotina que executa o backup full dos bancos de dados]    Script Date: 06/10/2013 17:50:18 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Step 2: Rotina que executa o backup full dos bancos de dados', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=4, 
		@on_fail_step_id=3, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec dbo.usp_uoldiveo_backup_full
', 
		@database_name=N'uoldiveodb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Step 3: Grava Log Fim]    Script Date: 06/10/2013 17:50:18 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Step 3: Grava Log Fim', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'update dbo.uoldiveo_job_monitor
set        dat_end_execution = getdate()
            ,time_minute_execution =  datediff(minute,dat_begin_execution,getdate())
           ,status_last_execution = ''Sucesso''
where  dat_begin_execution in(select max(dat_begin_execution) from dbo.uoldiveo_job_monitor where job_name=''UOLDIVEO: Backup Full'')
and      status_last_execution = ''Executando''
', 
		@database_name=N'uoldiveodb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'UOLDIVEO: Agendamento Diário (Backup Full)', 
		@enabled=0, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20130427, 
		@active_end_date=99991231, 
		@active_start_time=235900, 
		@active_end_time=235959
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

end

go

update msdb.dbo.sysjobs
set   [enabled] = 0
where [Name] = 'UOLDIVEO: Backup Full'

go




