-- Muda o contexto do banco de dados
USE master

-- Faz um Backup de Log (Sen�o as transa��o enchem)
BACKUP LOG BDSSD TO DISK = 'C:\SSD\Backups\BDSSDLog02.TRN'