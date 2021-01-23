
/*
Eduardo de Oliveira Gomes - Procedure para replicar bases
*/
if exists (select name from sysobjects where name = 'sp_replica_bases')
  drop procedure sp_replica_bases
go
create procedure sp_replica_bases with ENCRYPTION 
as
begin
  declare @name_backup varchar (255)
  declare @name_backup_anterior varchar (255)
  declare @cmd_text varchar (1000)
  declare @namedatabase varchar (255)
  declare @comando varchar (1000)
  declare @LogicalNameData nvarchar(128)
  declare @LogicalNameLog nvarchar(128) 
  declare @error_message varchar (8000)
  declare @to varchar (8000)
  declare @from varchar (8000)
  declare @assunto varchar (8000)

  create table #Restore (
    LogicalName nvarchar(128),
    PhysicalName nvarchar(260), 
    Type char(1), 
    FileGroupName nvarchar(128), 
    SizeB numeric(20, 0), 
    MaxSizeB numeric(20, 0), 
    fileid bigint, 
    createlsn bigint, 
    droplsn bigint, 
    Uniqueld uniqueidentifier, 
    ReadOnlyLsn bigint,  
    ReadWriteLsn bigint, 
    BackupSizeInBytes bigint, 
    SourceBlockSize bigint, 
    FileGroupID bigint, 
    LOGgRUPgUid uniqueidentifier, 
    DiferentialBasseLsn varchar(100), 
    DiferentialBasseGuid varchar(100), 
    IsReadOnly bigint, 
    IsPresent bigint)

  set @error_message = ''
  set @to = 'eduardo.gomes@localcred.com.br'
  set @from = 'eduardo.gomes@localcred.com.br'
  set @assunto = ''

  declare c_databases cursor local for select name   
                                       from sysdatabases 
                                       where name not in ('LOFIDIS','LOCITICA')
                                       order by 1

  open c_databases fetch next from c_databases into @namedatabase

  while @@fetch_status = 0
  begin

  begin try
-- Cria pastas

    select @cmd_text = 'md D:\SQL_TESTES\SQL_LOG\DB_'+@namedatabase +'_LOG'
    exec xp_cmdshell @cmd_text
    select @cmd_text = 'md D:\SQL_TESTES\SQL_DATA\DB_'+@namedatabase
    exec xp_cmdshell @cmd_text

-- Renomeia arquivo de backup

    select @name_backup = @namedatabase + '_backup_' + convert(varchar(8),getdate(),112) + '.bak'

-- Mata os Processos do Banco a ser restaurado

    declare c_kill_processes cursor local for select 'kill ' + convert(varchar(10),spid) 
                                              from sysprocesses 
                                              where dbid = (select dbid from sysdatabases where name = @namedatabase)
    
    open c_kill_processes fetch next from c_kill_processes into @comando
    
    while @@fetch_status = 0
    begin
      exec (@comando)
      fetch next from c_kill_processes into @comando
    end
    close c_kill_processes
    deallocate c_kill_processes

-- Realiza a restauração da base

    insert into #Restore exec('restore filelistonly from disk = ''D:\CopiasBDReplicados\'+@name_backup+'''') 
    select @LogicalNameData = LogicalName from #Restore where Type = 'D' 
    select @LogicalNameLog = LogicalName from #Restore where Type = 'L' 

    select @comando = '
    restore database '+ @namedatabase + ' from disk = N''D:\CopiasBDReplicados\'+@name_backup+''' 
    with file = 1, 
    move ''' + @LogicalNameData + ''' to N''D:\SQL_TESTES\SQL_DATA\DB_'+@namedatabase+'\'+@namedatabase+'_DAT.mdf'',
    move ''' + @LogicalNameLog + ''' to N''D:\SQL_TESTES\SQL_LOG\DB_'+@namedatabase +'_LOG\'+@namedatabase+'_LOG.ldf'',
    nounload, replace, stats = 10'

    exec (@comando)

  end try
  begin catch

    select @error_message = 'Erro na  replicação da base: ' + @namedatabase + ' de Testes
    - erro msg ' + error_message()
    select @assunto ='Erro na  replicação da base: ' + @namedatabase + ' de Testes'
    exec master.dbo.sp_SQLNotify 
         @to,
         @from,
         @assunto,
         @error_message

    exec master.dbo.sp_SQLNotify 
     'eduardo.gomes@localcred.com.br',
     '551178188069@mmsnextel.com.br',
     @assunto,
     @error_message

  end catch

    fetch next from c_databases into @namedatabase
  end
  close c_databases
  deallocate c_databases
end  
  
