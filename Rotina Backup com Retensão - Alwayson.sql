/*
	SCRIPT	: Rotina de Backup FULL que contempla Databases em Alwayson.
	OWNER	: Luiz Henrique Garetti
	DATE	: 20/03/2015	
	OBS		: Permissões necessárias: Login que roda o agent, Escrita no path do Backup no Windowns e no SQL Server db_BackupOperator.
			  Versão SQL Server 2012 ou superior
			  Nome do Arquivo -: Database + Data = master_20150323
*/

USE master
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- HABILITANDO xp_cmdshell
EXEC sp_configure 'show advanced options',1
GO
RECONFIGURE
GO

EXEC sp_configure 'xp_cmdshell',1
GO
RECONFIGURE
GO

BEGIN

	DECLARE	@databasename		VARCHAR(300),
			@backupsql			VARCHAR(8000),
			@PathUserDatabase	VARCHAR(2500),
			@PathDelBackups		VARCHAR(2500),
			@recoverymodel		VARCHAR(15),
			@dbstatus			VARCHAR(10),
			@apagar				VARCHAR(20),
			@cmd				VARCHAR (4000),
			@DataDel			VARCHAR(15),
			@Data				VARCHAR(15),
			@Retencao			TINYINT
	
	-- SETANDO VARIAVEL INICIAIS
	SET @Retencao			= 3 -- em dias
	SET @PathUserDatabase	= 'O:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\USER_DATABASES\'
	SET @PathDelBackups		= '"O:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\Backup\USER_DATABASES\"'
	SET @DataDel			= REPLACE((CONVERT(VARCHAR,(SELECT GETDATE()- @Retencao),112)),'-','')	
	SET @Data				= REPLACE((CONVERT(VARCHAR,(SELECT GETDATE()),112)),'-','')

	-- EXCLUINDO BACKUPS COM MAIS DE "@Retencao" DIAS
	SET @cmd = 'del '+ @PathDelBackups + '*'+ @DataDel +'*.bak'
	EXEC xp_cmdshell @cmd

	-- BACKUP FULL USER DATABASE
		-- Cursos com os databases que entraram no backup
	DECLARE Backup_UserDatabase_Cursor CURSOR FOR 
	SELECT
		d.name
	FROM sys.databases d 
	WHERE state IN (0,4) -- 0=Onlline | 4=Suspect
	AND name NOT IN ('master','msdb','model','tempdb')
	ORDER BY d.name asc

	-- Regra:
		-- Se o servidor estiver partipando de sessão alwayson
			-- Ser o servidor é o Principal	
				-- Backup com Compression\
			-- Senão
				-- Backup com Compression e Copy_only
		-- Senão
			-- Backup Normal com Compression
	OPEN Backup_UserDatabase_Cursor FETCH NEXT FROM Backup_UserDatabase_Cursor INTO @databasename
	WHILE @@fetch_status = 0
	BEGIN
		IF (SERVERPROPERTY ('IsHadrEnabled') = 1)
		BEGIN
			IF (sys.fn_hadr_is_primary_replica (@databasename) = 1)
			BEGIN
				SET @backupsql	= 'BACKUP DATABASE ' + @databasename + ' TO DISK = N''' + @PathUserDatabase + @databasename +  '_' + @Data + '.bak'' WITH COMPRESSION'
			END
			ELSE
			BEGIN
				SET @backupsql	= 'BACKUP DATABASE ' + @databasename + ' TO DISK = N''' + @PathUserDatabase + @databasename +  '_' + @Data + '.bak'' WITH COMPRESSION, COPY_ONLY'
			END
		END
		ELSE
		BEGIN
			SET @backupsql	= 'BACKUP DATABASE ' + @databasename + ' TO DISK = N''' + @PathUserDatabase + @databasename +  '_' + @Data + '.bak'' WITH COMPRESSION'
		END
		
		EXEC (@backupsql)
		print @databasename

		FETCH NEXT FROM Backup_UserDatabase_Cursor
		INTO @databasename
	END

	CLOSE Backup_UserDatabase_Cursor
	DEALLOCATE Backup_UserDatabase_Cursor
END
GO	

-- DESABILITANDO xp_cmdshell
EXEC sp_configure 'xp_cmdshell',0
GO
RECONFIGURE
GO

EXEC sp_configure 'show advanced options',0
GO
RECONFIGURE
GO