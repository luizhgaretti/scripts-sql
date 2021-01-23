
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
  declare @name_backup_log varchar (255)
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
                                       from [192.168.0.14].master.dbo.sysdatabases 
                                       where filename like 'E:\SQL_DATA%'
and name not in (
'LOABN',
'LOABNCDC', 
'LOABNGAR',
'LOBMG', 
'LOHSCARD', 
'LOORBITA',
'LOSAFCAR', 
'LOSAFRA'
)
                                       order by 1

  open c_databases fetch next from c_databases into @namedatabase

  while @@fetch_status = 0
  begin

  begin try

-- Exclui Backup dia anterior

    select @name_backup_anterior = @namedatabase + '_backup*.bak'
    select @cmd_text = 'del D:\CopiasBDReplicados\' + @name_backup_anterior
    exec xp_cmdshell @cmd_text

-- Exclui Backup log dia anteriores

    select @name_backup_anterior = @namedatabase + '_backup_*.trn'
    select @cmd_text = 'del D:\CopiasBDReplicados\BACKUP_LOG\' + @name_backup_anterior
    exec xp_cmdshell @cmd_text

-- Copia os Backups do servidor e cria pastas

    select @name_backup = @namedatabase + '_backup_*.bak'
    select @cmd_text = 'xcopy \\192.168.0.14\backups\'+@namedatabase +'\'+@name_backup+ ' D:\CopiasBDReplicados'
    exec xp_cmdshell @cmd_text
    select @cmd_text = 'md D:\SQL_LOG\DB_'+@namedatabase +'_LOG'
    exec xp_cmdshell @cmd_text
    select @cmd_text = 'md F:\SQL_DATA\DB_'+@namedatabase
    exec xp_cmdshell @cmd_text

-- Renomeia arquivo de backup

    select @cmd_text = 'rename D:\CopiasBDReplicados\'+ @name_backup + ' ' +  @namedatabase + '_backup.bak'
    exec xp_cmdshell @cmd_text
    select @name_backup = @namedatabase + '_backup.bak'

-- Copia os Backups de log

    select @name_backup_log = @namedatabase + '_backup_' + convert(varchar(8),dateadd(dd,-1,getdate()),112) + '*.trn'
    select @cmd_text = 'xcopy \\192.168.0.14\backups\'+@namedatabase +'\'+@name_backup_log+ ' D:\CopiasBDReplicados\BACKUP_LOG'
    exec xp_cmdshell @cmd_text

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
    move ''' + @LogicalNameData + ''' to N''F:\SQL_DATA\DB_'+@namedatabase+'\'+@namedatabase+'_DAT.mdf'',
    move ''' + @LogicalNameLog + ''' to N''D:\SQL_LOG\DB_'+@namedatabase+'_LOG\'+@namedatabase+'_LOG.ldf'',
    nounload, replace, stats = 10'

    exec (@comando)


-- Elimina Logins Orfãos
    select @comando = 'use ' + @namedatabase + '

    declare @comando varchar (1000)

    declare c_map_login cursor local for select ''sp_change_users_login ''''Update_One'''',''''''+ name + '''''',''''''+ name + '''''''' from sys.sysusers where uid > 4 and uid < 1000 and issqluser = 1
    
    open c_map_login fetch next from c_map_login into @comando

    while @@fetch_status = 0
    begin
      exec (@comando)
      fetch next from c_map_login into @comando
    end
    close c_map_login
    deallocate c_map_login'
    exec (@comando)


-- Diminui o LOG

  set @comando = 'use '+ @namedatabase + 
           ' declare @name_ldf varchar (255)
             declare @comando2 varchar (8000)

             select @name_ldf = rtrim(name) from sysfiles where fileid = 2
             
             set @comando2 = ''dbcc shrinkfile ('''''' + @name_ldf + '''''')''
             exec (@comando2)
           '            

  exec (@comando)

  end try
  begin catch

    select @error_message = 'Erro na  replicação da base: ' + @namedatabase + '  
    - erro msg ' + error_message()
    select @assunto ='Erro na  replicação da base: ' + @namedatabase
    exec master.dbo.sp_SQLNotify 
         @to,
         @from,
         @assunto,
         @error_message

  end catch

    fetch next from c_databases into @namedatabase
  end
  close c_databases
  deallocate c_databases
end  
  
