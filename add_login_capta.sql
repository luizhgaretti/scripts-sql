IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE name = N'capta')
BEGIN
EXEC master.dbo.sp_addlogin @loginame = N'capta', @passwd = 'db2010sql', @defdb = N'master', @deflanguage = N'us_english'
ALTER LOGIN [capta] WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
EXEC sp_addsrvrolemember 'capta', 'sysadmin'
END
Go

IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE name = N'captarmtdb')
BEGIN
EXEC master.dbo.sp_addlogin @loginame = N'captarmtdb', @passwd = 'UGhvZW5peEdyZWVuVmlsbGU===', @defdb = N'master', @deflanguage = N'us_english'
ALTER LOGIN [captarmtdb] WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
END
Go 

--Criar uma conta para equipe de suporte, com acesso apenas de LEITURA nas bases dos sistemas.
IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE name = N'captasup')
begin
	EXEC master.dbo.sp_addlogin @loginame = N'captasup', @passwd = 'suporte', @defdb = N'master', @deflanguage = N'us_english'
	ALTER LOGIN [captasup] WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF		
end 
Go 

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
