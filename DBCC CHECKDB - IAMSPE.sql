
-- Cria Job com o script:
DECLARE
	@DatabaseName	VARCHAR(100),
	@Command	NVARCHAR(250)

DECLARE DBCCDB CURSOR FOR
	SELECT name FROM sys.databases WHERE NAME NOT IN ('tempdb','model')

OPEN DBCCDB
FETCH NEXT FROM DBCCDB INTO @databasename

WHILE (@@FETCH_STATUS = 0)
BEGIN
	SET @Command = 'DBCC CHECKDB ('+ 'N' + '''' + @DatabaseName + '''' + ')'
	EXECUTE sp_executesql @Command

	FETCH NEXT FROM DBCCDB INTO @DatabaseName
END

CLOSE DBCCDB
DEALLOCATE DBCCDB
GO
