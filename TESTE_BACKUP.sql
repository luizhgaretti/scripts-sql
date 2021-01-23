declare @dbsize int, @dbsize_unallocated int
set @dbsize = (SELECT DBSIZE = (SUM(SIZE * 8)/1024) from sysfiles)
--set @dbsize_unallocated = (SELECT (SIZE * 8/1024) - (fileproperty(Name,'SpaceUsed')/128) AS SPACE_FREE_MB FROM sys.database_files WHERE FILE_ID = 1)
IF (SELECT  @dbsize) > 1
SELECT top 1'BACKUP DATABASE '+ 'TESTE '+ 'TO  DISK = N'''+ backup_full_path +  database_name +'_BACKUP_' + replace(convert(varchar(20),getdate(), 102), '.', '_') + '_.bak' + CHAR(39)
	FROM uoldiveodb.[dbo].[uoldiveo_backup_config]
ELSE 
SELECT 'O BANCO É MUITO GRANDE PARA FAZER O BACKUP AGORA...'

