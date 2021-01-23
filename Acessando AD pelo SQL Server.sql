/*
********************************************************************************
					Acessando AD pelo SQL Server
********************************************************************************
*/
---------------------------------------------------
	-- 1. SQL Commands for Creating linked Server  
----------------------------------------------------

EXEC master.dbo.sp_addlinkedserver @server = N'ADSI', 
                                                       @srvproduct=N'Directory Services', 
                                                       @provider=N'ADsDSOObject'
 
 EXEC master.dbo.sp_addlinkedsrvlogin  @rmtsrvname=N'ADSI',
                                                          @useself=N'False',
                                                          @locallogin=NULL,
                                                          @rmtuser=N' paraiso\luizhgr',
                                                          @rmtpassword='Wfarma6141' 
/* For security reasons the linked server remote logins password is changed with ######## */

EXEC master.dbo.sp_serveroption @server=N'ADSI',
                                                  @optname=N'collation compatible',
                                                  @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'ADSI',  @optname=N'data access', @optvalue=N'true'
GO
EXEC master.dbo.sp_serveroption @server=N'ADSI', @optname=N'dist', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'ADSI', @optname=N'pub', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'ADSI', @optname=N'rpc', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'ADSI', @optname=N'rpc out', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'ADSI', @optname=N'sub', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'ADSI', @optname=N'connect timeout', @optvalue=N'0'
GO
EXEC master.dbo.sp_serveroption @server=N'ADSI', @optname=N'collation name', @optvalue=null
GO
EXEC master.dbo.sp_serveroption @server=N'ADSI', @optname=N'lazy schema validation', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'ADSI', @optname=N'query timeout', @optvalue=N'0'
GO
EXEC master.dbo.sp_serveroption @server=N'ADSI', @optname=N'use remote collation', @optvalue=N'true' 
 

 -------------------------------------------------
	-- 2. SQL for Accessing LDAP information	
 -------------------------------------------------
 SELECT * FROM OPENQUERY(ADSI, 'SELECT CN,displayname,mail,userPrincipalName
								FROM ''LDAP://DC=synapse,DC=com''
								WHERE objectCategory = ''Person''
								and mail=''abc.xyz@globallogic.com''')


 -------------------------------------------------
	-- 3. Select Utilizado na RGM	
 -------------------------------------------------
SELECT * FROM OPENQUERY (ADSI,'SELECT CN,displayname,mail,userPrincipalName FROM ''LDAP://DC=paraiso''
								WHERE objectCategory = ''Person''')