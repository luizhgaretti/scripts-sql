-- Historico de Backup
select top 1 backup_start_date
from msdb.dbo.backupset with (nolock)
order by backup_set_id asc
