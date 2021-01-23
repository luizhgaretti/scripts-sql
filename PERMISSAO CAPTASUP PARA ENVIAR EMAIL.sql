USE MSDB
GO
CREATE USER [captasup] FOR LOGIN [captasup]
go
EXEC sp_addrolemember 'db_datareader', 'captasup'
go

GRANT EXECUTE ON MSDB..sp_send_dbmail TO CAPTASUP
GO