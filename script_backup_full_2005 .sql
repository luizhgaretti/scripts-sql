/*
1. Alterar o caminho do backups full e de log (XXXXX:\UOLDIVEO\Backup\Full\ e XXXXX:\UOLDIVEO\Backup\Log\)
2. Verificar se a conta de serviço do SQL Server Agent tem permissão de gravação aonde serão gravados os backups tanto full quanto de log
3. Habilitar no job o agendamento do backup full e/ou log (a janela de backup deve ser negociada com o cliente)
*/

use [master]
go

if (select count(*) from sys.databases where name = N'uoldiveodb')=0 and (select count(*) from sys.databases where name = N't4bdb01')>0


  begin

     declare @filedata varchar(1000)
            ,@filelog  varchar(1000)
            ,@sql      varchar(8000)
      
     set @filedata=(select left([filename],charindex('t4bdb01',[filename])-1) as filedata from t4bdb01.dbo.sysfiles
                where fileid=1)

     set @filelog=(select left([filename],charindex('t4bdb01',[filename])-1)as filelog from t4bdb01.dbo.sysfiles
                where fileid=2)

     set @sql =       

       'create database [uoldiveodb] on primary 
       (name = ''uoldiveodb'', filename = ''' + @filedata + 'uoldiveodb.mdf'' , size = 100mb , maxsize = 5gb, filegrowth = 1024mb)
        log on 
       (name = ''uoldiveodb_log'', filename = ''' + @filelog + 'uoldiveodb_log.ldf'' , size = 100mb , maxsize = 5gb , filegrowth = 1024mb)'

      exec(@sql)
      -- print @sql
     
     alter database [uoldiveodb] set recovery simple 

    end

if (select count(*) from sys.databases where name = N'uoldiveodb')>0

  begin
  
  print 'A base de dados de administração já existe no ambiente do cliente!'
  
  end

    else
    
       begin

          set @filedata=(select left([filename],charindex('master',[filename])-1) as filedata from master.dbo.sysfiles
                         where fileid=1)

          set @filelog=(select left([filename],charindex('mast',[filename])-1)as filelog from master.dbo.sysfiles
                         where fileid=2)

     set @sql =       

       'create database [uoldiveodb] on primary 
       (name = ''uoldiveodb'', filename = ''' + @filedata + 'uoldiveodb.mdf'' , size = 100mb , maxsize = 5gb, filegrowth = 1024mb)
        log on 
       (name = ''uoldiveodb_log'', filename = ''' + @filelog + 'uoldiveodb_log.ldf'' , size = 100mb , maxsize = 5gb , filegrowth = 1024mb)'

      exec(@sql)
      --print @sql
      
       alter database [uoldiveodb] set recovery simple 

   end
   
go

use uoldiveodb

go

alter table dbo.uoldiveo_job_monitor
alter column threshold_execution int null

go

if exists (select * from sys.objects where object_id = OBJECT_ID(N'[dbo].[uoldiveo_backup_config]') and type in (N'U'))
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
select   database_id
		,name
		,state
		,state_desc
		,user_access
		,user_access_desc
		,recovery_model
		,recovery_model_desc
		,is_read_only
		,'XXXXX:\UOLDIVEO\Backup\Full\'     as backup_full_path
		,1                                  as backup_full_is_active
		,'NÃO APLICADO'                     as backup_diff_path
		,0                                  as backup_diff_is_active
		,'XXXXX:\UOLDIVEO\Backup\Log\'      as backup_log_path
		,1                                  as backup_log_is_active
		,'Ativo'
from master.sys.databases
where    database_id not in(2,3)
and      name<>'ReportServerTempDB'
order by database_id
       
go

--Verifica se existem bancos de dados configurado com o log shipping, se existir desabilita o backup de log para não quebra o LSN
update dbo.uoldiveo_backup_config
set    backup_log_is_active = 0
where  database_id in(select db_id(primary_database) as primary_database from msdb.dbo.log_shipping_primary_databases
                      where  db_id(primary_database) is not null)

go

if  exists (select * from sys.objects WHERE object_id = OBJECT_ID(N'dbo.usp_uoldiveo_backup_full') and type in (N'P', N'PC'))
drop procedure dbo.usp_uoldiveo_backup_full

go

create procedure [dbo].[usp_uoldiveo_backup_full]
as
declare @db_name  varchar(255)  -- nome do banco de dados  
declare @path     varchar(255)  -- caminho dos arquivos de backup  
declare @filename varchar(255)  -- nome para o arquivo de backup 
declare @sql      varchar(1000) -- comando sql para executar o backup 

---Verifica se existem novos bancos de dados no ambiente
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
select   d.database_id
		,d.name
		,d.state
		,d.state_desc
		,d.user_access
		,d.user_access_desc
		,d.recovery_model
		,d.recovery_model_desc
		,d.is_read_only
		,(select top 1 backup_full_path from dbo.uoldiveo_backup_config)     as backup_full_path
		,1                                                                   as backup_full_is_active
		,'NÃO APLICADO'                                                      as backup_diff_path
		,0                                                                   as backup_diff_is_active
		,(select top 1 backup_log_path from uoldiveo_backup_config)          as backup_log_path
		,case when d.recovery_model=3 then 0
		 else 1 end as backup_log_is_active                                                                 
		,'Ativo' as backup_is_active_desc
from master.sys.databases as d left join  dbo.uoldiveo_backup_config as b
on      d.database_id = b.database_id
where   b.database_id is null 
and     d.database_id not in(2,3)

---Atualiza estado do banco de dados
update dbo.uoldiveo_backup_config
set    database_state        = 100 --- banco de dados que não existe mais na instância do SQL Server 
      ,backup_is_active_desc = 'Inativo'
      ,backup_dat_inactive = getdate() ----Data que o backup foi desabilitado (data que o banco foi deletado do ambiente)
where  database_id not in(select database_id from master.sys.databases where database_id not in(2,3))

---Atualiza estado do banco de dados e grava um novo status para a execução do backup 
update a
set    a.database_name                     = b.[name]
      ,a.database_state                    = b.[state]
      ,a.database_state_desc               = b.[state_desc]
      ,a.database_user_access              = b.user_access
      ,a.database_user_access_desc         = b.user_access_desc
      ,a.backup_full_is_active = case when b.[state]>0 or b.user_access>0 then 0 else 1 end
from   dbo.uoldiveo_backup_config as a 
inner join
       master.sys.databases as b
on     a.database_id = b.database_id     


declare db_cursor cursor for  

select 
       database_name as database_name
      ,backup_full_path
from   dbo.uoldiveo_backup_config
where  database_state = 0              ---bancos de dados com estado "ONLINE"
and    database_user_access = 0        ---bancos de dados com acesso "MULTI_USER"
and    backup_full_is_active = 1       ---bancos de dados com backup full "ATIVO"
and    backup_is_active_desc = 'Ativo' ---bancos de dados com backup "ATIVO"
and    database_name not in('model','tempdb')
order by database_id 

open db_cursor   

fetch next from db_cursor into @db_name,@path   

while @@fetch_status = 0 
  
begin   
      
       set @filename = @path + @db_name + '.bak'  
       
       if (@@microsoftversion / power(2, 24) in(8,9)) ---no existe compresso de dados no SQL Server 2005
           
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

