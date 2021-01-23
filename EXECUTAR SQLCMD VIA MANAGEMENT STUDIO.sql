--http://rafaelunp.wordpress.com/tag/sql-server-xp_cmdshell-sqlcmd/

declare @servidor varchar(30), @usuario varchar(20), @senha varchar(20), @banco varchar(30), @procedure varchar(80), @arquivoFisico varchar(30), @comando varchar(250)

set @servidor = 'localhost'
set @usuario = 'capta'
set @senha = 'sql@2013adm'
set @banco = 'db'
set @procedure = 'exec teste' --poderia ser uma stored Procedure também
set @arquivoFisico = 'c:\saida.csv'
--set @comando = 'sqlcmd -S '+@servidor+' -U '+@usuario+' -P '+@senha+' -d '+@banco+' -q "'+@Procedure+'"  -s ";" -f 65001 -o '+@arquivoFisico
set @comando = 'sqlcmd -S '+@servidor+' -U '+@usuario+' -P '+@senha+' -d '+@banco+' -q "'+@Procedure+'" -s ";" -f 65001 -o '+@arquivoFisico

exec master.dbo.xp_cmdshell @comando