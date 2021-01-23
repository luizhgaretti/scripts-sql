--procedure para apagar dados historicos de backups caso precise, como por exemplo, dados incorretos de backup
--os dados incorretos tbm pode ser pq o msdb esta corrompido

use msdb
-- teste

http://msdn.microsoft.com/pt-br/library/ms188328.aspx
--exclui todas entradas dos backups da data do parametro para tras
EXEC msdb..sp_delete_backuphistory @oldest_date = '2012-05-10'


http://msdn.microsoft.com/pt-br/library/ms178645.aspx
exclui todas entradas dos backups de uma base especifica
exec sp_delete_database_backuphistory @database_name = 'cepe_2012'