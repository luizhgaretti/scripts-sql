IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE name = N'captasisapl')
Begin
CREATE LOGIN [captasisapl]
WITH PASSWORD = 0x0100BCD43D28B94425CE16ECF1A5C94F9F8ABFD9B79D4618341C HASHED, SID = 0xBF39757F802EF148A87585C991F5B5A4,
DEFAULT_DATABASE = [master], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF, DEFAULT_LANGUAGE = ENGLISH
End
go

USE CEP
GO
CREATE USER [captasisapl] FOR LOGIN [captasisapl]
go
EXEC sp_addrolemember 'db_datareader', 'captasisapl'
go
EXEC sp_addrolemember 'db_datawriter', 'captasisapl'
go
