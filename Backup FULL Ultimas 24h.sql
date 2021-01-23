set nocount on

select convert(varchar(30), database_name) as banco,
	max(backup_start_date) as inicio_ultimo_bkp,
	max(backup_finish_date) as termino_ultimo_bkp
from msdb..backupset
where type = 'D'
and backup_start_date between dateadd(day, -1, getdate()) and getdate()
group by database_name
order by max(backup_start_date)

-- Resultado do @@rowcount = resultado do count da sysdatabases indica que foram realizados backups de todos os bancos 
select @@rowcount as total

select count(*) as total_bancos
from master..sysdatabases
where name != 'tempdb'


set nocount off



--- Mostra o caminho do arquivo tbm
SELECT          physical_device_name,
                backup_start_date,
                backup_finish_date,
                backup_size/1024.0 AS BackupSizeKB
FROM msdb.dbo.backupset b
JOIN msdb.dbo.backupmediafamily m ON b.media_set_id = m.media_set_id
WHERE database_name = 'iss_osasco'
ORDER BY backup_finish_date DESC