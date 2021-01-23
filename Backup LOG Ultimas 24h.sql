set nocount on

select convert(varchar(30), database_name) as banco,
	backup_start_date,
	backup_finish_date
from msdb..backupset
where type = 'L'
	and backup_start_date between dateadd(day, -1, getdate()) and getdate()
order by database_name, backup_start_date desc



set nocount off