if exists (select * from master.sys.sysservers where srvname = '200.158.216.85')

EXEC master.dbo.sp_droplinkedsrvlogin @rmtsrvname= N'200.158.216.85', @locallogin = NULL
GO 
EXEC master.dbo.sp_dropserver @server = N'200.158.216.85'


EXEC master.dbo.sp_addlinkedserver @server = N'200.158.216.85', @srvproduct=N'', @provider=N'SQLNCLI', @datasrc=N'sql.capta.com.br'
GO
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'200.158.216.85',@useself=N'False',@locallogin=NULL,@rmtuser=N'monitor',@rmtpassword='ADf5d065#Adi'
GO
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'collation compatible', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'data access', @optvalue=N'true'
GO
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'dist', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'pub', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'rpc', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'rpc out', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'sub', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'connect timeout', @optvalue=N'0'
GO
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'collation name', @optvalue=null
GO
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'lazy schema validation', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'query timeout', @optvalue=N'0'
GO
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'use remote collation', @optvalue=N'true'
