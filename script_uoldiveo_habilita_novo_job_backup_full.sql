use msdb
go

update msdb.dbo.sysjobs
set   [enabled] = 1
where [Name] = 'UOLDIVEO: Backup Full'

go
