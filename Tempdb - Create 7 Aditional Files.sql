/*	Cria + 7 arquivos para o tempdb caso ela só possua 2
	
	Partindo das indicações que apontam para utilização de 8 arquivos no tempdb
*/ 

USE tempdb
GO


--DBCC SHRINKFILE (N'tempdev' , 1024)


ALTER DATABASE [tempdb] MODIFY FILE ( NAME = N'tempdev', SIZE = 1GB, FILEGROWTH = 512MB )
ALTER DATABASE [tempdb] MODIFY FILE ( NAME = N'templog', SIZE = 1GB, FILEGROWTH = 512MB )
GO


IF (SELECT COUNT(1) FROM sys.database_files) = 2
BEGIN 

	DECLARE	
		@physical_name VARCHAR(200),
		@cpus TINYINT


	SELECT @cpus = cpu_count FROM sys.dm_os_sys_info

	SELECT
		@physical_name = REPLACE(physical_name,
								 REVERSE(SUBSTRING(REVERSE(physical_name), 1, CHARINDEX('\', REVERSE(physical_name)) - 1)),
								 '')
	FROM
		sys.database_files
	WHERE
		name = 'tempdev'


	-- Cria os arquivos de acordo com a quantidade de cpus
	IF @cpus >= 2
	BEGIN
		EXEC ('ALTER DATABASE tempdb ADD FILE (NAME = tempdev02, FILENAME = ''' + @physical_name + 'tempdb02.ndf'', SIZE = 1GB, FILEGROWTH = 512MB)')
	END
	
	IF @cpus >= 4
	BEGIN
		EXEC ('ALTER DATABASE tempdb ADD FILE (NAME = tempdev03, FILENAME = ''' + @physical_name + 'tempdb03.ndf'', SIZE = 1GB, FILEGROWTH = 512MB)')
		EXEC ('ALTER DATABASE tempdb ADD FILE (NAME = tempdev04, FILENAME = ''' + @physical_name + 'tempdb04.ndf'', SIZE = 1GB, FILEGROWTH = 512MB)')
	END
	
	IF @cpus >= 8
	BEGIN
		EXEC ('ALTER DATABASE tempdb ADD FILE (NAME = tempdev05, FILENAME = ''' + @physical_name + 'tempdb05.ndf'', SIZE = 1GB, FILEGROWTH = 512MB)')
		EXEC ('ALTER DATABASE tempdb ADD FILE (NAME = tempdev06, FILENAME = ''' + @physical_name + 'tempdb06.ndf'', SIZE = 1GB, FILEGROWTH = 512MB)')
		EXEC ('ALTER DATABASE tempdb ADD FILE (NAME = tempdev07, FILENAME = ''' + @physical_name + 'tempdb07.ndf'', SIZE = 1GB, FILEGROWTH = 512MB)')
		EXEC ('ALTER DATABASE tempdb ADD FILE (NAME = tempdev08, FILENAME = ''' + @physical_name + 'tempdb08.ndf'', SIZE = 1GB, FILEGROWTH = 512MB)')
	END

	RAISERROR ('Arquivos criados com sucesso', 10, 1)

END
ELSE
	
	RAISERROR ('O tempdb já possui mais que 2 arquivos, analise e crie manualmente', 10, 1)