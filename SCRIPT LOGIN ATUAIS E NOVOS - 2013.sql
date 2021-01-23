/*ADM*/
/*
-- Login Antigo: capta  ate 06/01/2013
IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE name = N'capta')
Begin 
CREATE LOGIN [capta]
WITH PASSWORD = 0x010067B9E40E972465C1A0349C0E1FB7B8FE97DF59D09F40D50D HASHED, SID = 0x44EE0D18C0AA3F498EB4EC2C5D4E022A,
DEFAULT_DATABASE = [master], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF, DEFAULT_LANGUAGE = ENGLISH
End 
ALTER SERVER ROLE [sysadmin] ADD MEMBER [CAPTA]
Go
*/

-- Login Atual: capta - senha a partir de 07/01/2013 
IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE name = N'capta')
Begin 
CREATE LOGIN [capta]
WITH PASSWORD = 0x01004E693D354370C33CC853886B3C3EEAD8E4B4AF3846221818 HASHED, SID = 0x44EE0D18C0AA3F498EB4EC2C5D4E022A,
DEFAULT_DATABASE = [master], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF
End 
ALTER SERVER ROLE [sysadmin] ADD MEMBER [CAPTA]
Go


/*APLICAÇÃO*/
/*
-- Login Antigo: captarmtdb
IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE name = N'captarmtdb')
Begin 
CREATE LOGIN [captarmtdb]
WITH PASSWORD = 0x0100DE763606BDF5D5F58AEC8F710F7A6594C2824A0F41B70E7A HASHED, SID = 0x6F16A70A812CF248915389F93146E65E,
DEFAULT_DATABASE = [master], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF, DEFAULT_LANGUAGE = ENGLISH
End 
Go
*/

 -- Login Atual: captasisapl 
IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE name = N'captasisapl')
Begin
CREATE LOGIN [captasisapl]
WITH PASSWORD = 0x0100BCD43D28B94425CE16ECF1A5C94F9F8ABFD9B79D4618341C HASHED, SID = 0xBF39757F802EF148A87585C991F5B5A4,
DEFAULT_DATABASE = [master], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF, DEFAULT_LANGUAGE = ENGLISH
End
go


/*CONSULTA DO SUPORTE*/
/*
 -- Login Antigo: captasup 
IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE name = N'captasup')
CREATE LOGIN [captasup]
WITH PASSWORD = 0x010061075363DB58CC13BCA86A509AA73515C769E2C094DB32C1 HASHED, SID = 0xEF6B1E53AFE140439D8390725449BA59,
DEFAULT_DATABASE = [master], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF, DEFAULT_LANGUAGE = ENGLISH
End
Go
*/

 -- Login Atual: captasup  
IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE name = N'captasup')
Begin
CREATE LOGIN [captasup]
WITH PASSWORD = 0x0100ED4E5426B7AF6042710E77A6ABE04F416017BE98664AD834 HASHED, SID = 0xEF6B1E53AFE140439D8390725449BA59,
DEFAULT_DATABASE = [master], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF, DEFAULT_LANGUAGE = ENGLISH
End
Go


/******************************************************************************/


/*ANTIGO*/
/*
Use [banco]
Go

exec sp_dropuser 'captarmtdb'
go
exec sp_dropuser 'captasup'
go

CREATE USER [captarmtdb] FOR LOGIN [captarmtdb]
go
EXEC sp_addrolemember 'db_datareader', 'captarmtdb'
go
EXEC sp_addrolemember 'db_datawriter', 'captarmtdb'
go

CREATE USER [captasup] FOR LOGIN [captasup]
go
EXEC sp_addrolemember 'db_datareader', 'captasup'
go
*/

/*
sp_change_users_login 
@Action='update_one', 
@UserNamePattern='captarmtdb', 
@LoginName='captarmtdb'
go

sp_change_users_login 
@Action='update_one', 
@UserNamePattern='captasup', 
@LoginName='captasup'
go


/******************************************************************************/


/*ATUAL*/

Use [banco]
Go

exec sp_dropuser 'captasisapl'
go
exec sp_dropuser 'captasup'
go

CREATE USER [captasisapl] FOR LOGIN [captasisapl]
go
EXEC sp_addrolemember 'db_datareader', 'captasisapl'
go
EXEC sp_addrolemember 'db_datawriter', 'captasisapl'
go

CREATE USER [captasup] FOR LOGIN [captasup]
go
EXEC sp_addrolemember 'db_datareader', 'captasup'
go


/*
sp_change_users_login 
@Action='update_one', 
@UserNamePattern='captasisapl', 
@LoginName='captasisapl'
go

sp_change_users_login 
@Action='update_one', 
@UserNamePattern='captasup', 
@LoginName='captasup'
go
*/
