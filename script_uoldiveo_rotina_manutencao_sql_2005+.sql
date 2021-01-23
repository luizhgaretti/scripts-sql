---O caminho do banco de dados e do arquivo de log deve ser alterado para o disco físico do ambiente do cliente

use [master]
go

if (select count(*) from sys.databases where name = N'uoldiveodb')=0

  begin
  
       create database [uoldiveodb] on primary 
      (name = N'uoldiveodb', filename = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\uoldiveodb.mdf' , size = 2048kb , maxsize = 5gb, filegrowth = 1024mb )
       log on 
      (name = N'uoldiveodb_log', filename = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.MSSQLSERVER\MSSQL\DATA\uoldiveodb_log.ldf' , size = 2048kb , maxsize = 5gb , filegrowth = 1024mb)

       alter database [uoldiveodb] set recovery simple 

   end
   
else

    begin
    
         print  'O banco de dados de administração da UOLDIVEO já existe na instância do SQL Server!'
    
    end

go


use [uoldiveodb]
go

if ((select count(*) from sys.objects where name ='uoldiveo_job_monitor') = 1)
begin

	       print 'a tabela para o monitoramento dos jobs já existe na base de dados de administração da uoldiveo! Cheque se a mesma esta atualizada no ambiente!'
end
else begin

create table [dbo].[uoldiveo_job_monitor](
	[id_job_execution] [int] identity(1,1) not null,
	[job_name] [varchar](100) null,
	[job_description] [varchar](255) null,
	[dat_begin_execution] [datetime] null,
	[dat_end_execution] [datetime] null,
	[time_minute_execution] [varchar](50) null,
	[status_last_execution] [char](10) null,
	[threshold_execution] [int] null,
	[dat_end_statistics_execution] [datetime] null,
	[dat_end_index_execution] [datetime] null,
	[dat_end_recompile_execution] [datetime] null,
	[dat_end_dbcc_execution] [datetime] null,
	[error_description_statistics] [varchar](255) null,
	[error_description_index] [varchar](255) null,
	[error_description_recompile] [varchar](255) null,
	[error_description_dbcc] [varchar](255) null
) on [primary]

end

go


if exists(select 1 from sys.objects where name ='uoldiveo_bancos_manutencao') 
drop table [dbo].[uoldiveo_bancos_manutencao]
go


create table [dbo].[uoldiveo_bancos_manutencao](
	[id_iden] [int] identity(1,1) not null,
	[id_banco] [int] null,
	[nome_banco] [varchar](256) null
) on [primary]

go


if ((select count(*) from sys.objects where name ='uoldiveo_index_fragment') = 1)
begin

	print 'a tabela para a análise de fragemtação dos índices já existe na base de dados de administração da uoldiveo!'
end
else begin

create table [dbo].[uoldiveo_index_fragment](
	[db_name] [nvarchar](255) null,
	[table_name] [nvarchar](255) null,
	[schema_name] [nvarchar](255) null,
	[index_name] [nvarchar](255) null,
	[avg_fragment] [decimal](18, 2) null,
	[dat_execution] [datetime] null,
	[status_execution] [bit] null,
	[id_job_monitor] [int] null,
	[index_partition] [int] null
) on [primary]

end

go

/****** Object:  StoredProcedure [dbo].[usp_uoldiveo_update_statistics]    Script Date: 08/01/2013 18:23:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_uoldiveo_update_statistics]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_uoldiveo_update_statistics]
GO

/****** Object:  StoredProcedure [dbo].[usp_uoldiveo_update_statistics]    Script Date: 01/07/2013 16:29:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[usp_uoldiveo_update_statistics]
as

begin try

truncate table dbo.uoldiveo_bancos_manutencao

insert into dbo.uoldiveo_bancos_manutencao
select database_id,name from sys.databases
where  state = 0              ---bancos de dados com estado "ONLINE"
and    user_access = 0        ---bancos de dados com acesso "MULTI_USER"
and    is_read_only = 0     ---bancos de dados diferente de  "READ_ONLY"
and database_id >= 5



declare @job int

--pego o id do job que estamos tratando, para melhor controlar e dividir os jobs e ate que ponto foi executado

select @job = max(id_job_execution) 
from dbo.uoldiveo_job_monitor 
where status_last_execution = 'Executando' 
and convert(varchar(10),dat_begin_execution,112) >= convert(varchar(10), dateadd(d,-1,getdate()), 112)
and job_name = 'UOLDIVEO: Rotina Manutenção'  

set @job = isnull(@job,0)

if @job = 0 begin

	 raiserror('não foi encontrado job para execução', 16, 1);
     return;

end

declare @janela int
declare @inicio_exec datetime
declare @tempo_exec int

--seleciono o tempo de janela deste job, para assim controlar a execucao do reindex

select @janela = threshold_execution, @inicio_exec = dat_begin_execution   
from dbo.uoldiveo_job_monitor
where id_job_execution = @job

set @tempo_exec = datediff(minute, @inicio_exec, getdate())

if @tempo_exec >= @janela begin

	 raiserror('tempo de execução estourou janela', 16, 1);
     return;

end 

declare @id_banco int
declare @nome_banco varchar(256)
declare @sql  varchar(max)

--set @sql = ''

declare cursor_bancos_statistics cursor for

select id_banco, nome_banco from dbo.uoldiveo_bancos_manutencao

open cursor_bancos_statistics

fetch cursor_bancos_statistics into @id_banco, @nome_banco

while @@fetch_status = 0 begin

	if @tempo_exec >= @janela begin

		 raiserror('tempo de execução estourou janela', 16, 1);
		 return;

	end 

	--exec [uoldiveodb]..sp_msforeachtable @command1='update statistics ?'
	set @sql = 'exec [' + @nome_banco + ']..sp_MSforeachtable @command1=''update statistics ?'''

	exec (@sql)
	

fetch cursor_bancos_statistics into @id_banco, @nome_banco

end

close cursor_bancos_statistics
deallocate cursor_bancos_statistics

end try

begin catch

print isnull(error_message(),'')

update dbo.uoldiveo_job_monitor
set    dat_end_execution = getdate()
      ,time_minute_execution =  datediff(minute,dat_begin_execution,getdate())
      ,status_last_execution = 'falha'
      ,error_description_statistics = 'falha na etapa "step 2: atualização das estatísticas" da rotina de manutenção. erro: ' + isnull(error_message(),'')
where   id_job_execution = @job

end catch


update dbo.uoldiveo_job_monitor
set    dat_end_statistics_execution=  getdate()
where   id_job_execution = @job

GO

/****** Object:  StoredProcedure [dbo].[usp_uoldiveo_rebuild_index]    Script Date: 08/01/2013 18:23:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_uoldiveo_rebuild_index]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_uoldiveo_rebuild_index]
GO

/****** Object:  StoredProcedure [dbo].[usp_uoldiveo_rebuild_index]    Script Date: 01/07/2013 16:32:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[usp_uoldiveo_rebuild_index]
as

begin try

declare @job int

--pego o id do job que estamos tratando, para melhor controlar e dividir os jobs e ate que ponto foi executado

select @job = max(id_job_execution) 
from dbo.uoldiveo_job_monitor 
where status_last_execution = 'Executando' 
and convert(varchar(10),dat_begin_execution,112) >= convert(varchar(10), dateadd(d,-1,getdate()), 112)
and job_name = 'UOLDIVEO: Rotina Manutenção'  

set @job = isnull(@job,0)


if @job = 0 begin

	 raiserror('não foi encontrado job para execução', 16, 1);
     return;

end

declare @janela int
declare @inicio_exec datetime
declare @tempo_exec int

--seleciono o tempo de janela deste job, para assim controlar a execucao do reindex

select @janela = threshold_execution, @inicio_exec = dat_begin_execution   
from dbo.uoldiveo_job_monitor
where id_job_execution = @job

set @tempo_exec = datediff(minute, @inicio_exec, getdate())

if @tempo_exec >= @janela begin

	 raiserror('tempo de execução estourou janela', 16, 1);
     return;
end 


declare @id_banco int
declare @nome_banco varchar(256)

--a partir dos bancos aptos a reindex, jogo em cursor para pegar todos os indices com fragmentação maior que 10 % para rebuild

declare cursor_bancos_reindex cursor for

	select id_banco, nome_banco	from dbo.uoldiveo_bancos_manutencao

open cursor_bancos_reindex

fetch cursor_bancos_reindex into @id_banco, @nome_banco

while @@fetch_status = 0 begin
	
		exec (' insert into dbo.uoldiveo_index_fragment
				select ''' + @nome_banco + ''',
						o.name as objectname,
						s.name as schemaname,
						i.name as indexname,
						ps.avg_fragmentation_in_percent as frag, getdate(), 0, ''' + @job + ''', partition_number
		from sys.dm_db_index_physical_stats (''' + @id_banco + ''', null, null , null, ''limited'') ps
		inner join [' + @nome_banco + '].sys.objects o on ps.object_id = o.object_id
		inner join [' + @nome_banco + '].sys.schemas s on s.schema_id = o.schema_id
		inner join [' + @nome_banco + '].sys.indexes i on o.object_id = i.object_id and ps.index_id = i.index_id
		where ps.avg_fragmentation_in_percent > 10.0 and ps.index_id > 0 and ps.page_count > 8 and i.name is not null
					')


fetch cursor_bancos_reindex into @id_banco, @nome_banco

end 

close cursor_bancos_reindex
deallocate cursor_bancos_reindex



	declare @dbid       int
	declare @dbname     varchar(255)
	declare @schemaname sysname;
	declare @objectname sysname;
	declare @indexname  sysname;
	declare @frag       decimal(18,2);
	declare @command    varchar(8000);
	declare @partition int

	declare cursor_reindex cursor for

	select db_name, table_name,schema_name, index_name,  index_partition
	from dbo.uoldiveo_index_fragment 
	where status_execution = 0 
	and dat_execution >= convert(varchar(10), getdate() ,112)
	and id_job_monitor = @job

	
	open cursor_reindex

	fetch cursor_reindex into @dbname, @objectname, @schemaname, @indexname, @partition

	while @@fetch_status = 0 begin


		if @tempo_exec >= @janela begin

			raiserror('tempo de execução estourou janela', 16, 1);
			return;

		end 

		if @partition= 1 begin

			set @command = 'alter index [' + @indexname +'] on [' + @dbname + '].[' + @schemaname + '].[' + @objectname + '] rebuild'

		end
		
		else if @partition > 1 begin

			set @command = 'alter index [' + @indexname +'] on [' + @dbname + '].[' + @schemaname + '].[' + @objectname + '] rebuild  Partition = ' + convert(varchar(10), @partition)
			
		end

		--print @command
		exec (@command)
		
			update dbo.uoldiveo_index_fragment
			set    status_execution = 1
			where  db_name          = @dbname
			and    table_name       = @objectname
			and    schema_name      = @schemaname
			and    index_name       = @indexname
			and    avg_fragment     = @frag
			and    convert(varchar(10),dat_execution,103) = convert(varchar(10),getdate(),103)
			and    status_execution = 0	


	fetch cursor_reindex into @dbname, @objectname, @schemaname, @indexname, @partition
	
	end
	
	close cursor_reindex
	deallocate cursor_reindex

end try

begin catch

	print isnull(error_message(),'')

	if @job >0 begin
	
		update dbo.uoldiveo_job_monitor
		set    dat_end_execution = getdate()
				,time_minute_execution =  datediff(minute,dat_begin_execution,getdate())
				,status_last_execution = 'falha'
				,error_description_index = 'falha na etapa "step 3: reconstrução dos índices (fragmentação >10%)" da rotina de manutenção. erro: ' + isnull(error_message(),'')
		where  id_job_execution = @job
	end
	else begin
		
		 raiserror('não foi encontrado job para execução', 16, 1);
		 return;

	end

end catch

update dbo.uoldiveo_job_monitor
set    dat_end_index_execution=  getdate()
where  id_job_execution = @job

GO

/****** Object:  StoredProcedure [dbo].[usp_uoldiveo_dbcc_checkdb]    Script Date: 08/01/2013 18:23:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_uoldiveo_dbcc_checkdb]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_uoldiveo_dbcc_checkdb]
GO

/****** Object:  StoredProcedure [dbo].[usp_uoldiveo_dbcc_checkdb]    Script Date: 01/07/2013 16:33:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[usp_uoldiveo_dbcc_checkdb]
as

declare @job int

begin try

--pego o id do job que estamos tratando, para melhor controlar e dividir os jobs e ate que ponto foi executado

select @job = max(id_job_execution) 
from dbo.uoldiveo_job_monitor 
where status_last_execution = 'Executando' 
and convert(varchar(10),dat_begin_execution,112) >= convert(varchar(10), dateadd(d,-1,getdate()), 112)
and job_name = 'UOLDIVEO: Rotina Manutenção'  

set @job = isnull(@job,0)

if @job = 0 begin

	 raiserror('não foi encontrado job para execução', 16, 1);
     return;

end

declare @janela int
declare @inicio_exec datetime
declare @tempo_exec int

--seleciono o tempo de janela deste job, para assim controlar a execucao do reindex

select @janela = threshold_execution, @inicio_exec = dat_begin_execution   
from dbo.uoldiveo_job_monitor
where id_job_execution = @job

set @tempo_exec = datediff(minute, @inicio_exec, getdate())

if @tempo_exec >= @janela begin

	 raiserror('tempo de execução estourou janela', 16, 1);
     return;

end 

declare @id_banco int
declare @nome_banco varchar(256)
declare @sql  varchar(max)

set @sql = ''

declare cursor_bancos_dbcc cursor for

select id_banco, nome_banco from dbo.uoldiveo_bancos_manutencao

open cursor_bancos_dbcc

fetch cursor_bancos_dbcc into @id_banco, @nome_banco

while @@fetch_status = 0 begin

	if @tempo_exec >= @janela begin

		raiserror('tempo de execução estourou janela', 16, 1);
		return;

	end 

	set @sql = 'dbcc checkdb ([' + @nome_banco + '])  with no_infomsgs; ' +  char(13)

	exec (@sql)
	
fetch cursor_bancos_dbcc into @id_banco, @nome_banco

end

close cursor_bancos_dbcc
deallocate cursor_bancos_dbcc

end try

begin catch

update dbo.uoldiveo_job_monitor
set    dat_end_execution = getdate()
      ,time_minute_execution =  datediff(minute,dat_begin_execution,getdate())
      ,status_last_execution = 'falha'
      ,error_description_dbcc = 'falha na etapa "step 5: verifica integridade das bases de dados" da rotina de manutenção.  erro: ' + isnull(error_message(),'')
where  id_job_execution = @job

end catch  

update dbo.uoldiveo_job_monitor
set    dat_end_dbcc_execution=  getdate()
where  id_job_execution = @job

GO

/****** Object:  StoredProcedure [dbo].[usp_uoldiveo_recompile_object]    Script Date: 08/01/2013 18:23:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_uoldiveo_recompile_object]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_uoldiveo_recompile_object]
GO

/****** Object:  StoredProcedure [dbo].[usp_uoldiveo_recompile_object]    Script Date: 01/07/2013 16:31:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[usp_uoldiveo_recompile_object]
as
-- Executa sp_recompile para todos os objetos de todos os users databases.

begin try

declare @job int

--pego o id do job que estamos tratando, para melhor controlar e dividir os jobs e ate que ponto foi executado

select @job = max(id_job_execution) 
from dbo.uoldiveo_job_monitor 
where status_last_execution = 'Executando' 
and convert(varchar(10),dat_begin_execution,112) >= convert(varchar(10), dateadd(d,-1,getdate()), 112)
and job_name = 'UOLDIVEO: Rotina Manutenção'  

set @job = isnull(@job,0)

if @job = 0 begin

	 raiserror('não foi encontrado job para execução', 16, 1);
     return;

end

declare @janela int
declare @inicio_exec datetime
declare @tempo_exec int

--seleciono o tempo de janela deste job, para assim controlar a execucao do reindex

select @janela = threshold_execution, @inicio_exec = dat_begin_execution   
from dbo.uoldiveo_job_monitor
where id_job_execution = @job

set @tempo_exec = datediff(minute, @inicio_exec, getdate())

if @tempo_exec >= @janela begin

	 raiserror('tempo de execução estourou janela', 16, 1);
     return;
end 


declare @sql  varchar(max)

set @sql = ''
select	@sql = @sql + 'exec [' + nome_banco + ']..sp_MSforeachtable @command1=''sp_recompile [?]''' + char(13)
		from dbo.uoldiveo_bancos_manutencao
	
	
exec (@sql)
--print (@sql)

end try

begin catch

update dbo.uoldiveo_job_monitor
set    dat_end_execution = getdate()
      ,time_minute_execution =  datediff(minute,dat_begin_execution,getdate())
      ,status_last_execution = 'Falha'
      ,error_description_recompile = 'Falha na etapa "Step 4: Recompilação dos Objetos" da rotina de manutenção. erro: ' + isnull(error_message(),'')
where  dat_begin_execution in(select max(dat_begin_execution) from dbo.uoldiveo_job_monitor)

end catch   

update dbo.uoldiveo_job_monitor
set    dat_end_recompile_execution=  getdate()
where  dat_begin_execution in(select max(dat_begin_execution) from dbo.uoldiveo_job_monitor)

GO

/****** Object:  StoredProcedure [dbo].[usp_uoldiveo_dbcc_checkdb]    Script Date: 08/01/2013 18:23:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_uoldiveo_dbcc_checkdb]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[usp_uoldiveo_dbcc_checkdb]
GO

/****** Object:  StoredProcedure [dbo].[usp_uoldiveo_dbcc_checkdb]    Script Date: 01/07/2013 16:33:32 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE proc [dbo].[usp_uoldiveo_dbcc_checkdb]
as

declare @job int

begin try

--pego o id do job que estamos tratando, para melhor controlar e dividir os jobs e ate que ponto foi executado

select @job = max(id_job_execution) 
from dbo.uoldiveo_job_monitor 
where status_last_execution = 'Executando' 
and convert(varchar(10),dat_begin_execution,112) >= convert(varchar(10), dateadd(d,-1,getdate()), 112)
and job_name = 'UOLDIVEO: Rotina Manutenção'  

set @job = isnull(@job,0)

if @job = 0 begin

	 raiserror('não foi encontrado job para execução', 16, 1);
     return;

end

declare @janela int
declare @inicio_exec datetime
declare @tempo_exec int

--seleciono o tempo de janela deste job, para assim controlar a execucao do reindex

select @janela = threshold_execution, @inicio_exec = dat_begin_execution   
from dbo.uoldiveo_job_monitor
where id_job_execution = @job

set @tempo_exec = datediff(minute, @inicio_exec, getdate())

if @tempo_exec >= @janela begin

	 raiserror('tempo de execução estourou janela', 16, 1);
     return;

end 

declare @id_banco int
declare @nome_banco varchar(256)
declare @sql  varchar(max)

set @sql = ''

declare cursor_bancos_dbcc cursor for

select id_banco, nome_banco from dbo.uoldiveo_bancos_manutencao

open cursor_bancos_dbcc

fetch cursor_bancos_dbcc into @id_banco, @nome_banco

while @@fetch_status = 0 begin

	if @tempo_exec >= @janela begin

		raiserror('tempo de execução estourou janela', 16, 1);
		return;

	end 

	set @sql = 'dbcc checkdb ([' + @nome_banco + '])  with no_infomsgs; ' +  char(13)

	exec (@sql)
	
fetch cursor_bancos_dbcc into @id_banco, @nome_banco

end

close cursor_bancos_dbcc
deallocate cursor_bancos_dbcc

end try

begin catch

update dbo.uoldiveo_job_monitor
set    dat_end_execution = getdate()
      ,time_minute_execution =  datediff(minute,dat_begin_execution,getdate())
      ,status_last_execution = 'falha'
      ,error_description_dbcc = 'falha na etapa "step 5: verifica integridade das bases de dados" da rotina de manutenção.  erro: ' + isnull(error_message(),'')
where  id_job_execution = @job

end catch  

update dbo.uoldiveo_job_monitor
set    dat_end_dbcc_execution=  getdate()
where  id_job_execution = @job



GO

USE [msdb]
GO

declare @job varchar(200)

select @job = job_id from sysjobs
where name = 'UOLDIVEO: Rotina Manutenção'

if @job <> '' begin

	/****** Object:  Job [UOLDIVEO: Rotina Manutenção]    Script Date: 28/05/2013 14:55:18 ******/
	EXEC msdb.dbo.sp_delete_job @job_id=@job, @delete_unused_schedule=1

end

GO


/****** Object:  Job [UOLDIVEO: Rotina Manutenção]    Script Date: 28/05/2013 14:55:18 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Database Maintenance]    Script Date: 28/05/2013 14:55:18 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Database Maintenance' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Database Maintenance'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'UOLDIVEO: Rotina Manutenção', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'No description available.', 
		@category_name=N'Database Maintenance', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Step 1: Grava Log Ínicio]    Script Date: 28/05/2013 14:55:18 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Step 1: Grava Log Ínicio', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=4, 
		@on_fail_step_id=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'insert dbo.uoldiveo_job_monitor
select ''UOLDIVEO: Rotina Manutenção''
      ,''Job responsável pela execução da rotina de manutenção dos clientes UOLDIVEO-SOLVO''
      ,getdate()
      ,null
      ,null
      ,''Executando''
      ,60                 ----Digitar o threshold da rotina de manutenção (limite máximo em minutos que a rotina pode executar sem ultrapassar a janela de manutenção).
      ,null
      ,null
      ,null
      ,null
      ,null
      ,null
      ,null
      ,null     
', 
		@database_name=N'uoldiveodb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Step 2: Atualização das Estatísticas]    Script Date: 28/05/2013 14:55:18 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Step 2: Atualização das Estatísticas', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=4, 
		@on_fail_step_id=3, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec dbo.usp_uoldiveo_update_statistics', 
		@database_name=N'uoldiveodb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Step 3: Reconstrução dos Índices (fragmentação >10%)]    Script Date: 28/05/2013 14:55:18 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Step 3: Reconstrução dos Índices (fragmentação >10%)', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=4, 
		@on_fail_step_id=4, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec dbo.usp_uoldiveo_rebuild_index', 
		@database_name=N'uoldiveodb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Step 4: Recompilação dos Objetos]    Script Date: 28/05/2013 14:55:18 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Step 4: Recompilação dos Objetos', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=4, 
		@on_fail_step_id=5, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec dbo.usp_uoldiveo_recompile_object', 
		@database_name=N'uoldiveodb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Step 5: Verifica Integridade das Bases de Dados]    Script Date: 28/05/2013 14:55:18 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Step 5: Verifica Integridade das Bases de Dados', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=4, 
		@on_fail_step_id=6, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'exec dbo.usp_uoldiveo_dbcc_checkdb', 
		@database_name=N'uoldiveodb', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [Step 6: Grava Log Fim]    Script Date: 28/05/2013 14:55:18 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'Step 6: Grava Log Fim', 
		@step_id=6, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'update dbo.uoldiveo_job_monitor
set    dat_end_execution = getdate()
      ,time_minute_execution =  datediff(minute,dat_begin_execution,getdate())
      ,status_last_execution = ''Sucesso''
where  dat_begin_execution in(select max(dat_begin_execution) from dbo.uoldiveo_job_monitor where job_name = ''UOLDIVEO: Rotina Manutenção'')
and    status_last_execution = ''Executando''
', 
		@database_name=N'uoldiveodb', 
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

use uoldiveodb
go

/****** Object:  StoredProcedure [dbo].[usp_zabbix_job_status_ultima_execucao_plano_manutencao]    Script Date: 07/12/2013 19:27:54 ******/
if exists (select * from sys.sysobjects where name = 'usp_zabbix_job_status_ultima_execucao_plano_manutencao') 
drop procedure [dbo].[usp_zabbix_job_status_ultima_execucao_plano_manutencao]
GO

create procedure [dbo].[usp_zabbix_job_status_ultima_execucao_plano_manutencao]
as

 begin

   if exists (select id_job_execution      
              from 
              dbo.uoldiveo_job_monitor 
              where job_name = 'UOLDIVEO: Rotina Manutenção'
              and   status_last_execution='Falha'
              and   id_job_execution in(select max(id_job_execution) from dbo.uoldiveo_job_monitor where job_name = 'UOLDIVEO: Rotina Manutenção'))

begin
select 1 as Valor ---Existem erros na última execução do job da rotina de manutenção
end

else 
select 0 as Valor ---Não existem erros na última execução do job da rotina de manutenção

end

go

use msdb

go

if  exists (select job_id from msdb.dbo.sysjobs_view where name = N'T4B_ROTINAS_SEMANAIS')

begin

	declare @job uniqueidentifier

	set     @job = (select job_id from msdb.dbo.sysjobs_view where name = N'T4B_ROTINAS_SEMANAIS')

	exec msdb.dbo.sp_delete_job @job_id=@job, @delete_unused_schedule=1

end



