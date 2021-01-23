-- Muda o contexto do banco de dados
USE Master

-- Faz um Backup do FILEGROUP CORP
BACKUP DATABASE BDSSD FILEGROUP = 'CORP'
TO DISK = 'C:\SSD\Backups\BDSSD_FGCORP.BAK'