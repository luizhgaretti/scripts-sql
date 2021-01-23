-- EXEMPLO DE EXECUÇÃO
-- exec usp_backup_database 1,'C:\Backup\'
-- exec usp_backup_database 4,'C:\Backup\Log\'

use master
go

CREATE PROCEDURE usp_backup_database  @typebackup tinyint , @directorypath varchar(2000) with encryption
AS
-- @typebackup = 1 bkfull with init
-- @typebackup = 2 bkdiff with init
-- @typebackup = 3 bklog  with init
-- @typebackup = 4 bklog  with noint

declare @databasename  varchar(300),
@backupsql     varchar(8000),
@fullpath      varchar(2500),
@recoverymodel varchar(15),
@dbstatus      varchar(10),
@apagar varchar(20)

SELECT @apagar = convert(varchar(20),getdate(),112) 

DECLARE database_cursor cursor for 
SELECT d.name 
FROM master..sysdatabases d 
WHERE d.name NOT IN ('master','tempdb','model','msdb')
and status NOT IN (128,512,4096,32768)
-- 128 = recovering
-- 512 = offline
-- 4096 = single user
-- 32768 = emergency mode
  
open database_cursor
fetch next from database_cursor
into @databasename
WHILE @@fetch_status = 0
BEGIN
 SET @DbStatus  = (SELECT CONVERT(VARCHAR (10),DATABASEPROPERTYEX(@databasename,'Status')))
 IF @DbStatus = 'ONLINE'
 BEGIN

  set @fullpath = ''
  set @fullpath = @directorypath

 
  if (select @typebackup) = 1 -- backup full with init
  begin
   set @backupsql = ''
   set @backupsql = @backupsql + 'backup database ' + @databasename + ' to  disk = N''' + @fullpath + 'BKFULL_' + @apagar + '_' + @databasename + '.bak'' with retaindays = 3,compression'
   exec (@backupsql)
  end
 
  if (select @typebackup) = 2 -- backup diff with init
  begin
   set @backupsql = ''
   set @backupsql = @backupsql + 'backup database ' + @databasename + ' to  disk = N''' + @fullpath + 'BKDIFF_' + @apagar + '_' + @databasename + '.bak'' with init , differential'
   exec (@backupsql)
  end
 
  if (select @typebackup) = 3 -- backup log with init
  begin
 
   set @recoverymodel = ''
   set @recoverymodel =  ( select cast( databasepropertyex(@databasename,'recovery') as varchar(15) ) )
 
   IF ( select @recoverymodel ) = 'FULL'
   begin 
    set @backupsql = ''
    set @backupsql = @backupsql + 'backup log ' + @databasename + ' to  disk = N''' + @fullpath + 'BKLOG_' + @databasename + '.trn'' with init, compression '
    exec (@backupsql)
   end
  end
 
  if (select @typebackup) = 4 -- backup log with noinit
  begin
  
   set @recoverymodel = ''
   set @recoverymodel =  ( select cast( databasepropertyex(@databasename,'recovery') as varchar(15) ) )

   IF ( select @recoverymodel ) = 'FULL'
   begin 
    set @backupsql = ''
    set @backupsql = @backupsql + 'backup log ' + @databasename + ' to  disk = N''' + @fullpath + 'BKLOG_' + @databasename + '_' + convert(varchar(24),getdate(),112)+convert(varchar(2),datepart(hh,getdate()))+ convert(varchar(2),datepart(mi,getdate())) +'.trn'' with noinit,compression '
    exec (@backupsql)
   end
  end

 end

 fetch next from database_cursor
 into @databasename
  
END
close database_cursor
deallocate database_cursor
go