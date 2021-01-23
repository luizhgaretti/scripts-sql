--script que desanexa bases para migração
SELECT 'EXEC sp_detach_db ''' + name + ''', ''false''' FROM sysdatabases where name not in ('master','tempdb','model','msdb','northwind')

/****************************************************************************************************************************************/

--script que anexa bases pós migração
DECLARE @dbname varchar(50)
DECLARE @dbname_prev varchar(50)
DECLARE @file varchar(150)
SET @dbname_prev = ' '
DECLARE cAttach CURSOR
READ_ONLY
FOR SELECT a.name, b.filename FROM sysdatabases a inner join sysaltfiles b on a.dbid = b.dbid where a.name not in ('master','tempdb','model','msdb','northwind', 'pubs') order by 1
OPEN cAttach
FETCH NEXT FROM cAttach INTO @dbname, @file
WHILE (@@fetch_status = 0)
BEGIN
	IF (@dbname_prev <> @dbname) 
	BEGIN
		IF (@dbname_prev <> ' ')  PRINT 'FOR ATTACH ';
		PRINT '';
		PRINT 'CREATE DATABASE [' + @dbname + '] ON';
		PRINT '( FILENAME =  ''' + rtrim(@file) + ''') ';
	END
	ELSE PRINT ', ( FILENAME =  ''' + rtrim(@file) + ''') ';
	SET @dbname_prev = @dbname
FETCH NEXT FROM cAttach INTO @dbname, @file
END
CLOSE cAttach
DEALLOCATE cAttach
PRINT 'FOR ATTACH ';
GO

/****************************************************************************************************************************************/

--script para salvar as configurações de roles dos logins
select 'EXEC master..sp_addsrvrolemember @loginame = N''' + [name] + ''', @rolename = N''sysadmin''' as script from syslogins
where sysadmin = 1
union
select 'EXEC master..sp_addsrvrolemember @loginame = N''' + [name] + ''', @rolename = N''securityadmin''' as script from syslogins
where securityadmin = 1
union
select 'EXEC master..sp_addsrvrolemember @loginame = N''' + [name] + ''', @rolename = N''serveradmin''' as script from syslogins
where serveradmin = 1
union
select 'EXEC master..sp_addsrvrolemember @loginame = N''' + [name] + ''', @rolename = N''setupadmin''' as script from syslogins
where setupadmin = 1
union
select 'EXEC master..sp_addsrvrolemember @loginame = N''' + [name] + ''', @rolename = N''processadmin''' as script from syslogins
where processadmin = 1
union
select 'EXEC master..sp_addsrvrolemember @loginame = N''' + [name] + ''', @rolename = N''diskadmin''' as script from syslogins
where diskadmin = 1
union
select 'EXEC master..sp_addsrvrolemember @loginame = N''' + [name] + ''', @rolename = N''dbcreator''' as script from syslogins
where dbcreator = 1
union
select 'EXEC master..sp_addsrvrolemember @loginame = N''' + [name] + ''', @rolename = N''bulkadmin''' as script from syslogins
where bulkadmin = 1 

/****************************************************************************************************************************************/

--salva logins e senhas dos mesmos
USE master
GO
IF OBJECT_ID ('sp_hexadecimal') IS NOT NULL
  DROP PROCEDURE sp_hexadecimal
GO
CREATE PROCEDURE sp_hexadecimal
    @binvalue varbinary(256),
    @hexvalue varchar (514) OUTPUT
AS
DECLARE @charvalue varchar (514)
DECLARE @i int
DECLARE @length int
DECLARE @hexstring char(16)
SELECT @charvalue = '0x'
SELECT @i = 1
SELECT @length = DATALENGTH (@binvalue)
SELECT @hexstring = '0123456789ABCDEF'
WHILE (@i <= @length)
BEGIN
  DECLARE @tempint int
  DECLARE @firstint int
  DECLARE @secondint int
  SELECT @tempint = CONVERT(int, SUBSTRING(@binvalue,@i,1))
  SELECT @firstint = FLOOR(@tempint/16)
  SELECT @secondint = @tempint - (@firstint*16)
  SELECT @charvalue = @charvalue +
    SUBSTRING(@hexstring, @firstint+1, 1) +
    SUBSTRING(@hexstring, @secondint+1, 1)
  SELECT @i = @i + 1
END
 

SELECT @hexvalue = @charvalue
GO

IF OBJECT_ID ('sp_help_revlogin') IS NOT NULL
  DROP PROCEDURE sp_help_revlogin
GO
CREATE PROCEDURE sp_help_revlogin @login_name sysname = NULL AS
DECLARE @name sysname
DECLARE @type varchar (1)
DECLARE @hasaccess int
DECLARE @denylogin int
DECLARE @is_disabled int
DECLARE @PWD_varbinary  varbinary (256)
DECLARE @PWD_string  varchar (514)
DECLARE @SID_varbinary varbinary (85)
DECLARE @SID_string varchar (514)
DECLARE @tmpstr  varchar (1024)
DECLARE @is_policy_checked varchar (3)
DECLARE @is_expiration_checked varchar (3)
 

DECLARE @defaultdb sysname

IF (@login_name IS NULL)
  DECLARE login_curs CURSOR FOR
 

      SELECT p.sid, p.name, p.type, p.is_disabled, p.default_database_name, l.hasaccess, l.denylogin FROM 
sys.server_principals p LEFT JOIN sys.syslogins l
      ON ( l.name = p.name ) WHERE p.type IN ( 'S', 'G', 'U' ) AND p.name <> 'sa'
ELSE
  DECLARE login_curs CURSOR FOR
 

 

      SELECT p.sid, p.name, p.type, p.is_disabled, p.default_database_name, l.hasaccess, l.denylogin FROM 
sys.server_principals p LEFT JOIN sys.syslogins l
      ON ( l.name = p.name ) WHERE p.type IN ( 'S', 'G', 'U' ) AND p.name = @login_name
OPEN login_curs
 

FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @type, @is_disabled, @defaultdb, @hasaccess, @denylogin
IF (@@fetch_status = -1)
BEGIN
  PRINT 'No login(s) found.'
  CLOSE login_curs
  DEALLOCATE login_curs
  RETURN -1
END
SET @tmpstr = '/* sp_help_revlogin script '
PRINT @tmpstr
SET @tmpstr = '** Generated ' + CONVERT (varchar, GETDATE()) + ' on ' + @@SERVERNAME + ' */'
PRINT @tmpstr
PRINT ''
WHILE (@@fetch_status <> -1)
BEGIN
  IF (@@fetch_status <> -2)
  BEGIN
    PRINT ''
    SET @tmpstr = '-- Login: ' + @name
    PRINT @tmpstr
    IF (@type IN ( 'G', 'U'))
    BEGIN -- NT authenticated account/group
 

      SET @tmpstr = 'CREATE LOGIN ' + QUOTENAME( @name ) + ' FROM WINDOWS WITH DEFAULT_DATABASE = [' + @defaultdb + ']'
    END
    ELSE BEGIN -- SQL Server authentication
        -- obtain password and sid
            SET @PWD_varbinary = CAST( LOGINPROPERTY( @name, 'PasswordHash' ) AS varbinary (256) )
        EXEC sp_hexadecimal @PWD_varbinary, @PWD_string OUT
        EXEC sp_hexadecimal @SID_varbinary,@SID_string OUT

        -- obtain password policy state
        SELECT @is_policy_checked = CASE is_policy_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END FROM sys.sql_logins WHERE name = @name
        SELECT @is_expiration_checked = CASE is_expiration_checked WHEN 1 THEN 'ON' WHEN 0 THEN 'OFF' ELSE NULL END FROM sys.sql_logins WHERE name = @name

            SET @tmpstr = 'CREATE LOGIN ' + QUOTENAME( @name ) + ' WITH PASSWORD = ' + @PWD_string + ' HASHED, SID = ' + @SID_string + ', DEFAULT_DATABASE = [' + @defaultdb + ']'
 

        IF ( @is_policy_checked IS NOT NULL )
        BEGIN
          SET @tmpstr = @tmpstr + ', CHECK_POLICY = ' + @is_policy_checked
        END
        IF ( @is_expiration_checked IS NOT NULL )
        BEGIN
          SET @tmpstr = @tmpstr + ', CHECK_EXPIRATION = ' + @is_expiration_checked
        END
    END
    IF (@denylogin = 1)
    BEGIN -- login is denied access
      SET @tmpstr = @tmpstr + '; DENY CONNECT SQL TO ' + QUOTENAME( @name )
    END
    ELSE IF (@hasaccess = 0)
    BEGIN -- login exists but does not have access
      SET @tmpstr = @tmpstr + '; REVOKE CONNECT SQL TO ' + QUOTENAME( @name )
    END
    IF (@is_disabled = 1)
    BEGIN -- login is disabled
      SET @tmpstr = @tmpstr + '; ALTER LOGIN ' + QUOTENAME( @name ) + ' DISABLE'
    END
    PRINT @tmpstr
  END
 

  FETCH NEXT FROM login_curs INTO @SID_varbinary, @name, @type, @is_disabled, @defaultdb, @hasaccess, @denylogin
   END
CLOSE login_curs
DEALLOCATE login_curs
RETURN 0
GO
 

EXEC sp_help_revlogin

/****************************************************************************************************************************************/

--associa os usuario orfãos aos logins

Use master
Go
Create Table #Orphans 
 (
  RowID     int not null primary key identity(1,1) ,
  TDBName varchar (100),
  UserName varchar (100),
  UserSid varbinary(85)
 )
SET NOCOUNT ON 
 DECLARE @DBName sysname, @Qry nvarchar(4000)
 SET @Qry = ''
 SET @DBName = ''
 WHILE @DBName IS NOT NULL
 BEGIN
   SET @DBName = 
     (
  SELECT MIN(name) 
   FROM master..sysdatabases 
   WHERE
   /** to exclude named databases add them to the Not In clause **/
   name NOT IN 
     (
      'model', 'msdb', 
      'distribution'
     ) And 
     DATABASEPROPERTY(name, 'IsOffline') = 0 
     AND DATABASEPROPERTY(name, 'IsSuspect') = 0 
     AND name > @DBName
      )
   IF @DBName IS NULL BREAK
         
                Set @Qry = 'select ''' + @DBName + ''' as DBName, name AS UserName, 
                sid AS UserSID from [' + @DBName + ']..sysusers 
                where issqluser = 1 and (sid is not null and sid NOT IN (0x0, 0x01)) 
                and suser_sname(sid) is null order by name'
 Insert into #Orphans Exec (@Qry)
 
 End
--Select * from #Orphans

/** To drop orphans uncomment this section 
Declare @SQL as varchar (200)
Declare @DDBName varchar (100)
Declare @Orphanname varchar (100)
Declare @DBSysSchema varchar (100)
Declare @From int
Declare @To int
Select @From = 0, @To = @@ROWCOUNT 
from #Orphans
--Print @From
--Print @To
While @From < @To
 Begin
  Set @From = @From + 1
  
  Select @DDBName = TDBName, @Orphanname = UserName from #Orphans
   Where RowID = @From
      
   Set @DBSysSchema = '[' + @DDBName + ']' + '.[sys].[schemas]'
   print @DBsysSchema
   Print @DDBname
   Print @Orphanname
   set @SQL = 'If Exists (Select * from ' + @DBSysSchema 
                          + ' where name = ''' + @Orphanname + ''')
    Begin
     Use ' + @DDBName 
                                        + ' Drop Schema [' + @Orphanname + ']
    End'
   print @SQL
   Exec (@SQL)
     
    Begin Try
     Set @SQL = 'Use ' + @DDBName 
                                        + ' Drop User [' + @Orphanname + ']'
     Exec (@SQL)
    End Try
    Begin Catch
    End Catch
   
 End
**/
select '--primeiro rodar o nome do banco, depois o comando do usuario orfão' 
select 'use ' + tdbname + char(10) +
'sp_change_users_login 
@Action=''update_one'', 
@UserNamePattern= ''' + username + ''', 
@LoginName=''' + username + '''' + CHAR(10)
from #Orphans
WHERE UserName <> 'DBO'

--SELECT * FROM #Orphans

Drop table #Orphans