
-- efetua copia das bases para pasta de historico...
print 1
go
use master
go
set dateformat ymd
declare @sql varchar(400)
set @sql = 'EXEC master.dbo.xp_cmdshell ' + char(39) + 'xcopy D:\Databases\backup\*.* D:\Databases\backup_historico\ /E /A /C /I /H /Y' + CHar(39)+ ', NO_OUTPUT'
exec(@sql)
