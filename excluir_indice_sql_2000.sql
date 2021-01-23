
DECLARE  @indexName VARCHAR(128) 

DECLARE  @tableName VARCHAR(128) 

DECLARE  [indexes] CURSOR FOR SELECT  [sysindexes].[index_x] AS [Index],  [sysobjects].[name] AS [Table] 
			FROM (select c.name as index_x, a.name as table_x,c.status,c.id
					from sysobjects a,master.dbo.spt_values b,sysindexes c
					where  a.xtype=substring(b.name,1,2) collate database_default and b.type='O9T' and a.xtype in ('U ','PK') and c.id=a.id
						and c.indid > 0 and c.indid < 255 and (c.status & 64)=0) [sysindexes]
			INNER JOIN [sysobjects] 
                           ON  [sysindexes].[id] = [sysobjects].[id] 
                           WHERE [sysindexes].[index_x] IS NOT NULL AND [sysobjects].[type] = 'U' And ([sysindexes].[status] & 2048)=0

OPEN [indexes]
 

FETCH NEXT FROM [indexes] INTO @indexName, @tableName 

WHILE @@FETCH_STATUS = 0 

 
BEGIN PRINT 'DROP INDEX [' + @tableName + '].[' + @indexName + ']' 
 

FETCH NEXT FROM [indexes] INTO @indexName, @tableName END CLOSE [indexes]

 

DEALLOCATE [indexes]
