
-- Retorna caminho fisico onde o backup foi feito
SELECT          physical_device_name,
                backup_start_date,
                backup_finish_date,
                backup_size/1024.0 AS BackupSizeKB
FROM msdb.dbo.backupset b
JOIN msdb.dbo.backupmediafamily m ON b.media_set_id = m.media_set_id
WHERE database_name = 'iss_osasco'
ORDER BY backup_finish_date DESC