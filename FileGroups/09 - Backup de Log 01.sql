-- Muda o contexto do banco de dados
USE master

-- Faz um Backup de Log (Senão as transação enchem)
BACKUP LOG BDSSD TO DISK = 'C:\SSD\Backups\BDSSDLog01.TRN'