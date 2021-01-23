-- Declarando a variavel
DECLARE @namedatabase VARCHAR (MAX)
DECLARE @COMANDO VARCHAR (MAX)
-- Declarando o Cursor
DECLARE CRIAR_LOGIN CURSOR LOCAL FOR

 -- Faz o Select
    SELECT NAME 
		FROM SYSDATABASES
		WHERE name NOT IN('TESTE','MASTER','tempdb','MSDB','MODEL','REPORTSERVER','ReportServerTempDB')

-- Abre o cursor  
OPEN CRIAR_LOGIN 
-- Le a proxima linha

FETCH NEXT FROM CRIAR_LOGIN INTO @namedatabase
-- Enquanto tiver a proxima linha continua....
WHILE @@FETCH_STATUS = 0

BEGIN
SET @COMANDO = 'USE ' + @namedatabase + '
IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE name = N''capta'')
	BEGIN
	CREATE LOGIN [capta]
		WITH PASSWORD = 0x01004E693D354370C33CC853886B3C3EEAD8E4B4AF3846221818 HASHED, SID = 0x44EE0D18C0AA3F498EB4EC2C5D4E022A,
			DEFAULT_DATABASE = [master], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF
	END
'	 
EXEC (@COMANDO)

SET @COMANDO = 'USE ' + @namedatabase + '
	EXEC master..sp_addsrvrolemember @loginame = N''capta''
		, @rolename = N''sysadmin''
    ' 
    
EXEC (@COMANDO)    
SET @COMANDO = 'USE ' + @namedatabase + '
IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE name = N''captasisapl'')
	BEGIN
	CREATE LOGIN [captasisapl]
		WITH PASSWORD = 0x0100BCD43D28B94425CE16ECF1A5C94F9F8ABFD9B79D4618341C HASHED, SID = 0xBF39757F802EF148A87585C991F5B5A4,
			DEFAULT_DATABASE = [master], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF, DEFAULT_LANGUAGE = ENGLISH
	END
'
EXEC (@COMANDO)

SET @COMANDO = 'USE ' + @namedatabase + '
EXEC SP_DROPUSER''captasisapl''

CREATE USER [captasisapl] FOR LOGIN [captasisapl]

EXEC sp_addrolemember ''db_datareader'', ''captasisapl''

EXEC sp_addrolemember ''db_datawriter'', ''captasisapl''

'

EXEC (@COMANDO)

SET @COMANDO = 'USE ' + @namedatabase + '
	IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE name = N''captasup'')
		BEGIN
		CREATE LOGIN [captasup]
			WITH PASSWORD = 0x0100ED4E5426B7AF6042710E77A6ABE04F416017BE98664AD834 HASHED, SID = 0xEF6B1E53AFE140439D8390725449BA59,
			DEFAULT_DATABASE = [master], CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF, DEFAULT_LANGUAGE = ENGLISH
		END
'

EXEC (@COMANDO)

SET @COMANDO = 'USE ' + @namedatabase + '
EXEC SP_DROPUSER ''captasup''

CREATE USER [captasup] FOR LOGIN [captasup]

EXEC sp_addrolemember ''db_datareader'', ''captasup''

'
    
EXEC (@COMANDO)
	--DELETE 
	 --SELECT NAME 
		--FROM SYSDATABASES
		--WHERE name NOT IN('MASTER','tempdb','MSDB','MODEL','REPORTSERVEER')

    -- Lendo a próxima linha
FETCH NEXT FROM CRIAR_LOGIN INTO @namedatabase
END

-- Fechando Cursor para leitura
CLOSE CRIAR_LOGIN

-- Desalocando o cursor
DEALLOCATE CRIAR_LOGIN
                                       
