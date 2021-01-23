/*
O script está configurado para fazer backup full e apagar backup com mais de 3  dias... criando uma retensão de 3 dias.
Utiliza xp_cmdshel para acessar o windows via sql server e apagar os backups
*/


USE [master]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--ALTER PROCEDURE dbo.usp_backup_database 
--AS
	-- Habilitando xp_cmdshell
	EXEC sp_configure 'show advanced options',1
	GO
	RECONFIGURE
	GO

	EXEC sp_configure 'xp_cmdshell',1
	GO
	RECONFIGURE
	GO

	DECLARE	@databasename		VARCHAR(300),
			@backupsql			VARCHAR(8000),
			@PathUserDatabase	VARCHAR(2500),	
			@PathSystemDatabase	VARCHAR(2500),	
			@recoverymodel		VARCHAR(15),
			@dbstatus			VARCHAR(10),
			@apagar				VARCHAR(20),
			@cmd				VARCHAR (4000),
			@DataDel			VARCHAR(15),
			@Data				VARCHAR(15)
	
	-- Setando Variaveis Iniciais
	SET @PathUserDatabase	= 'E:\Program Files\Microsoft SQL Server\MSSQL11.SQL2012\MSSQL\Backup\USER_DATABASES\'
--	SET @PathSystemDatabase = 'E:\Program Files\Microsoft SQL Server\MSSQL11.SQL2012\MSSQL\Backup\SYSTEM_DATABASES\'
	SET @DataDel			= REPLACE((CONVERT(VARCHAR,(SELECT GETDATE()-3),112)),'-','')	
	SET @Data				= REPLACE((CONVERT(VARCHAR,(SELECT GETDATE()),112)),'-','')
	

	-- Excluindo Bakups com mais de 3 dias.
	SET @cmd = 'del '+ @PathUserDatabase + '*'+ @DataDel +'*.bak'
	select @cmd
	EXEC xp_cmdshell @cmd

--	SET @cmd = 'del '+ @PathSystemDatabase + '*'+ @DataDel +'*.bak'
--	EXEC xp_cmdshell @cmd


	-- Rotina Backup Full User Databases
	DECLARE Backup_UserDatabase_Cursor CURSOR FOR 
	SELECT
		d.name
	FROM master..sysdatabases d 
	WHERE d.name NOT IN ('tempdb', 'master','msdb','model')
	AND status NOT IN (128,512,4096,32768)
	AND name NOT LIKE 'Report%' -- 128 = recovering / 512 = offline / 4096 = single user / 32768 = emergency mode
 
	OPEN Backup_UserDatabase_Cursor FETCH NEXT FROM Backup_UserDatabase_Cursor INTO @databasename
	WHILE @@fetch_status = 0
	BEGIN
		SET @backupsql	= 'BACKUP DATABASE ' + @databasename + ' TO DISK = N''' + @PathUserDatabase + @databasename +  '_' + @Data + '.bak'' with compression'
		EXEC (@backupsql)

		FETCH NEXT FROM Backup_UserDatabase_Cursor
		INTO @databasename
	END

	CLOSE Backup_UserDatabase_Cursor
	DEALLOCATE Backup_UserDatabase_Cursor
	GO


	-- Desabilitando xp_cmdshell
	EXEC sp_configure 'xp_cmdshell',0
	GO
	RECONFIGURE
	GO
	
	EXEC sp_configure 'show advanced options',0
	GO
	RECONFIGURE
--GO