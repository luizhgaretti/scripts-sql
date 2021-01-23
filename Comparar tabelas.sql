use LOFINASA


DECLARE @schema_name sysname
SET @schema_name = 'dbo'
	 
	DECLARE @table_name sysname
	SET @table_name = 'cadcontr'
	 
DECLARE @column_list VARCHAR(MAX)
	 
	SELECT @column_list =
	    COALESCE(@column_list + ', ', '') + QUOTENAME(COLUMN_NAME)
	FROM INFORMATION_SCHEMA.COLUMNS
	WHERE TABLE_NAME = @table_name
	AND TABLE_SCHEMA = @schema_name
 
	DECLARE @sql VARCHAR(MAX)
	SET @sql = 'SELECT CHECKSUM_AGG(CHECKSUM({@column_list})) FROM [{@schema_name}].[{@table_name}]'
	 
	SET @sql = REPLACE(@sql, '{@column_list}', @column_list)
	SET @sql = REPLACE(@sql, '{@schema_name}', @schema_name)
	SET @sql = REPLACE(@sql, '{@table_name}', @table_name)
	 
	EXEC (@sql)