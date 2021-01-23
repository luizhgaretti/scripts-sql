DECLARE  @indexName VARCHAR(128) 

DECLARE  @tableName VARCHAR(128) 

DECLARE  [indexes] CURSOR FOR SELECT  [sysindexes].[name] AS [Index],  [sysobjects].[name] AS [Table] 
			FROM [sys].[indexes] [sysindexes]
			INNER JOIN [sysobjects] 
                           ON  [sysindexes].[object_id] = [sysobjects].[id] 
                           WHERE [sysindexes].[name] IS NOT NULL AND [sysobjects].[type] = 'U'  And [sysindexes].[is_primary_key] = 0

OPEN [indexes]
 

FETCH NEXT FROM [indexes] INTO @indexName, @tableName 

WHILE @@FETCH_STATUS = 0 

 
BEGIN PRINT 'DROP INDEX [' + @indexName + '] ON [' + @tableName + ']' 
 

FETCH NEXT FROM [indexes] INTO @indexName, @tableName END CLOSE [indexes]

 

DEALLOCATE [indexes]
