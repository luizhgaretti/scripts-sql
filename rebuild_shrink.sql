use master
--IF(SELECT CAST(GETDATE() AS DATE)) = CAST(DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE())+1,0)) AS DATE) -- Verificar se é o ultimo dia  do mes <SQL 2008 
--IF(SELECT CONVERT(varchar(20),GETDATE(),103)) = CONVERT(VARCHAR(20),DATEADD(s,-1,DATEADD(mm, DATEDIFF(m,0,GETDATE())+1,0)),103) --Verificar se é o ultimo dia util do mes < SQL2005 
IF(SELECT DATEPART(DW,GETDATE()))= 3 --Verifica se é segunda feira
BEGIN

SET NOCOUNT ON;
DECLARE @objectid int;
DECLARE @indexid int;
DECLARE @partitioncount bigint;
DECLARE @schemaname nvarchar(130);
DECLARE @objectname nvarchar(130);
DECLARE @indexname nvarchar(130);
DECLARE @partitionnum bigint;
DECLARE @partitions bigint;
DECLARE @frag float;
DECLARE @command nvarchar(4000);
DECLARE @dbname varchar(MAX);
DECLARE @dbid INT;
DECLARE @COMANDO VARCHAR(MAX)
set  @dbname =   (SELECT TOP 1 REPLACE(DAT.NAME,'_DATA','') -- Esse select pega a maior base....
					FROM SYSALTFILES AS SY
					INNER JOIN SYS.DATABASES AS DAT
					ON SY.dbid = DAT.database_id 
					WHERE DAT.state = 0
					AND SY.filename LIKE '%MDF'
					ORDER BY SIZE DESC )
					--print @dbname
					select dbid from sys.sysdatabases where name = @dbname

set @dbid = (select dbid from sys.sysdatabases where name = @dbname) -- Aqui é colocado o dbid da maior base na variavel

print @dbid

-- Coleta as informações de fragmentação e traz também os nomes
SELECT
object_id AS objectid,
index_id AS indexid,
partition_number AS partitionnum,
avg_fragmentation_in_percent AS frag
INTO #work_to_do
FROM sys.dm_db_index_physical_stats (@dbid, NULL, NULL , NULL, 'LIMITED')
WHERE avg_fragmentation_in_percent > 10.0 AND index_id > 0;

--Armazena em uma tabela temporária
DECLARE partitions CURSOR FOR SELECT * FROM #work_to_do;
OPEN partitions;
WHILE (1=1)
BEGIN;
FETCH NEXT
FROM partitions
INTO @objectid, @indexid, @partitionnum, @frag;
IF @@FETCH_STATUS < 0 BREAK;
SELECT @objectname = QUOTENAME(o.name), @schemaname = QUOTENAME(s.name)
FROM sys.objects AS o
JOIN sys.schemas as s ON s.schema_id = o.schema_id
WHERE o.object_id = @objectid;
SELECT @indexname = QUOTENAME(name)
FROM sys.indexes
WHERE object_id = @objectid AND index_id = @indexid;
SELECT @partitioncount = count (*)
FROM sys.partitions
WHERE object_id = @objectid AND index_id = @indexid;

-- Ajuste aqui o nível de fragmentação para REORGANIZE ou REBUILD
IF @frag < 30
SET @command = N'ALTER INDEX ' + @indexname + N' ON ' + @schemaname + N'.' + @objectname + N' REORGANIZE';
Print 'OK'
IF @frag >= 30
SET @command = N'ALTER INDEX ' + @indexname + N' ON ' + @schemaname + N'.' + @objectname + N' REBUILD';
IF @partitioncount > 1
SET @command = @command + N' PARTITION=' + CAST(@partitionnum AS nvarchar(10));
EXEC (@command);
PRINT N'Executed: ' + @command;
END;
CLOSE partitions;
DEALLOCATE partitions;
select * from #work_to_do

-- Apaga a tabela temporária
DROP TABLE #work_to_do;

IF (
	SELECT  
	(SIZE * 8/1024) - (fileproperty(Name,'SpaceUsed')/128) AS SPACE_FREE_MB
	FROM        sys.database_files  
	WHERE FILE_ID = 1) >= 1000 --1gb

BEGIN 


PRINT 'EXECUTANDO SHRINK...'
SET @COMANDO = 'USE '+ @DBNAME + ' DBCC SHRINKFILE(1,0)'
EXEC (@COMANDO)
SET @COMANDO = 'USE '+ @DBNAME + ' DBCC SHRINKFILE(2,0)'
EXEC (@COMANDO)
END 
ELSE

PRINT 'Não foi necessario o shrink'
END

