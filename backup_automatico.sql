DECLARE @BackupFile varchar(255), @DB varchar(30), @Description varchar(255), @LogFile varchar(50)

DECLARE @Name varchar(30), @MediaName varchar(30), @BackupDirectory nvarchar(200)
SET @BackupDirectory = 'd:\Databases\Backup_automatico\'
--Add a list of all databases you don't want to backup to this.
DECLARE Database_CURSOR CURSOR FOR SELECT name FROM sysdatabases WHERE name <> 'tempdb' AND name <> 'model' AND name <> 'Northwind'

OPEN Database_Cursor
FETCH next FROM Database_CURSOR INTO @DB
WHILE @@fetch_status = 0

BEGIN
SET @Name = @DB + '( Daily BACKUP )'
SET @MediaName = @DB + '_Dump' 
SET @BackupFile = @BackupDirectory + + @DB + '_' + 'Full' + '_'+ '.bak'
SET @Description = 'Normal' + ' BACKUP at ' + CONVERT(varchar, CURRENT_TIMESTAMP) + '.'

IF (SELECT COUNT(*) FROM msdb.dbo.backupset WHERE database_name = @DB) > 0 OR @DB = 'master'
	BEGIN
		SET @BackupFile = @BackupDirectory + @DB + '_' + 'Full' + '_' + '.bak'
		--SET some more pretty stuff for sql server.
		SET @Description = 'Full' + ' BACKUP at ' + CONVERT(varchar, CURRENT_TIMESTAMP) + '.'
	END
ELSE
	BEGIN
		SET @BackupFile = @BackupDirectory + @DB + '_' + 'Full' + '_' + '.bak'
		--SET some more pretty stuff for sql server.
		SET @Description = 'Full' + ' BACKUP at ' + CONVERT(varchar, CURRENT_TIMESTAMP) + '.'
	END





IF(@DB<>'MODEL')
BEGIN
	BACKUP DATABASE @DB TO DISK = @BackupFile
	WITH NAME = @Name, DESCRIPTION = @Description ,
	MEDIANAME = @MediaName, MEDIADESCRIPTION = @Description ,
	STATS = 3, init
END

--Encerramento do cursor
FETCH next FROM Database_CURSOR INTO @DB
END
CLOSE Database_Cursor
DEALLOCATE Database_Cursor
declare @ncodigo int

set @ncodigo = 50

insert into [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor values ( @ncodigo , 1, getdate())

select
bs.database_name
,max(bs.backup_finish_date) backup_finish_date
into #ultimo_backup
from
msdb.dbo.backupset bs (nolock) 
inner join master.dbo.sysdatabases db (nolock) on bs.database_name = db.name and isnull(db.version,0) <> 0
group by
bs.database_name



set @ncodigo = 50

insert into [200.158.216.85].monitordba.dbo.Tb_Mon_Mov_LocalDataTerminoBackup
(
ncodigo, database_name, backup_finish_date, physical_device_name
)
select
@ncodigo
,bs.database_name
,bs.backup_finish_date
,bmf.physical_device_name
from
msdb.dbo.backupmediafamily bmf (nolock)
inner join msdb.dbo.backupset bs (nolock) on bmf.media_set_id = bs.media_set_id
inner join #ultimo_backup ub on ub.database_name = bs.database_name and ub.backup_finish_date = bs.backup_finish_date
where
CONVERT(varchar,@ncodigo) collate SQL_Latin1_General_CP1_CI_AS + '_' + CONVERT(varchar,bs.database_name) collate SQL_Latin1_General_CP1_CI_AS + '_' + convert(varchar,bs.backup_finish_date,112) collate SQL_Latin1_General_CP1_CI_AS +convert(varchar,bs.backup_finish_date,108) collate SQL_Latin1_General_CP1_CI_AS
not in
(
select
CONVERT(varchar,ncodigo) collate SQL_Latin1_General_CP1_CI_AS + '_' + CONVERT(varchar,database_name) collate SQL_Latin1_General_CP1_CI_AS + '_' + convert(varchar,backup_finish_date,112) collate SQL_Latin1_General_CP1_CI_AS +convert(varchar,backup_finish_date,108) collate SQL_Latin1_General_CP1_CI_AS
from
[200.158.216.85].monitordba.dbo.Tb_Mon_Mov_LocalDataTerminoBackup
where
ncodigo = @ncodigo
)
