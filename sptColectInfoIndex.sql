/*
	## Rotina:
		Coleta Informações de fragmentação dos Indices - TJSP - DSE Microsoft @2016
	## Objetivo:
		Coletar dados e níveis de fragmentações dos indices que seram analisados e posteriormente entraram na rotina de Reorganize/Rebuild	
	## Schedule Atual:
		Todas as intancias estão com agendamento "Semanal - JOB (Saturday) on 02:00:00 AM" (obs: A Janela padrão é 4horas, porem isso é configuravel por instancia)
	## Regra:
			Utiliza a "sys.dm_db_index_physical_stats" para coleta das informações:
				- MODE SAMPLED	-> Para tabelas não particionadas.
				- MODE DATAILED -> Para tabelas particionadas.
	## Parametros:
			sptColectInfoIndex @pDatabaseName VARCHAR(500), @pQtdHoursExecution TINYINT.
				@pDatabaseName		= Especifica um Database ou NULL para todos.
				@pQtdMinExecution	= Especifica a quantidade de horas limite para execução - (Obs: "NULL" será especificado o default de 6 horas).
	## Exemplo:
			- EXECUTE sptColectInfoIndex NULL, 480			-> All Databases
			- EXECUTE sptColectInfoIndex Corporativo, 480	-> Specific Database
	## Importante:
			- A execução pode ser custosa dependendo do tamanho da base e quantidade de indices, com isso, é importante avaliar a janela de execução para não impactar
			  o ambiente produtivo negativamente.
			- Fragmentation >= 10.0 (%)
*/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF ((SELECT COUNT(1) FROM sys.databases WHERE name = 'STI4DBA') = 0)
BEGIN
	RAISERROR('Database STI4DBA not exstis. Please, Create Database STI4DBA for Continue. Contact Administrator.', 9, 42) WITH LOG;
	RETURN;
END;

USE STI4DBA
GO

IF EXISTS (SELECT name FROM STI4DBA.sys.procedures WHERE Name = 'sptColectInfoIndex')
BEGIN
	DROP PROCEDURE sptColectInfoIndex;
END
GO

CREATE PROCEDURE dbo.sptColectInfoIndex (@pDatabaseName VARCHAR(500), @pQtdMinExecution INT)
WITH RECOMPILE
AS
BEGIN

	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 30000;

	DECLARE @cSeq				BIGINT;
	DECLARE @cDatabaseName		VARCHAR(500);
	DECLARE @ccDatabaseName		VARCHAR(500);
	DECLARE @ccObjectName		VARCHAR(500);
	DECLARE @ccIndexName		VARCHAR(500);
	DECLARE @ccSchemaName		VARCHAR(100);
	DECLARE @Command			NVARCHAR(MAX);
	DECLARE @Message			NVARCHAR(255);
	DECLARE @LobSQL				NVARCHAR(MAX);
    DECLARE @LobSQLParam		NVARCHAR(1000);
	DECLARE @StartRoutine		DATETIME;
	DECLARE @StopRoutine		DATETIME;
	DECLARE @MinFragmentation   FLOAT;
	DECLARE @RebuildThreshold	FLOAT;
	DECLARE @ContainsLOB		BIT;
	DECLARE @Count				INT;
	
	IF (@pQtdMinExecution IS NULL)
	BEGIN
		SET @pQtdMinExecution = 240 -- Default
	END;	

	SET @StartRoutine		= GETDATE();
	SET @StopRoutine		= DATEADD(MINUTE,@pQtdMinExecution,GETDATE());
	SET @MinFragmentation	= 10.0 -- Default
	SET @RebuildThreshold	= 30.0 -- Default

	IF NOT EXISTS (SELECT 1 FROM sys.all_objects WHERE name = 'IndexMaintenanceHistory')
	BEGIN
		CREATE TABLE STI4DBA.dbo.IndexMaintenanceHistory
		(
			IdIndexMaintenanceHistory			INT IDENTITY (1,1) PRIMARY KEY,
			InstanceName						VARCHAR (255),		-- Instance Name
			DatabaseName						VARCHAR (500),		-- Database Name
			SchemaName							VARCHAR (50),		-- Schema Name
			ObjectId							INT,				-- Number Object ID (Table ID)
			ObjectName							VARCHAR (500),		-- Table Name
			IndexId								INT,				-- Number Index ID
			IndexName							VARCHAR (500),		-- Index Name
			ObjectSizeMB						BIGINT,				-- Size Table in MB
			TableQtdRows						BIGINT,				-- Quantity Rows in Table
			IndexSizeMB							BIGINT,				-- Size Index
			IndexDepth							TINYINT,			-- Level Depth Index 
			IndexLevel							TINYINT,			-- Level Index (Raiz, Folha e Intermediario)
			TableIsPartitioned					BIT,				-- 1 = Partioned | 0 = Not Partioned
			PartitionNumber						TINYINT,			-- Number Partition Object
			ContainsLOB							BIT,				-- 1 = Contains Lob | 0 = Not Contains Lob
			IndexTypeDesc						VARCHAR (50),		-- Index Type Description
			AvgFragmentationInPercent			DECIMAL (10,2),		-- Avg Fragmentation In Percent
			AvgPageSpaceUsedInPercent			DECIMAL (10,2),		-- Avg Page Space Used In Percent
			AvgFragmentSizeInPages				DECIMAL (10,2),		-- Avg Fragment Size In Pages
			[PageCount]							BIGINT,				-- Page Count
			ActionType							VARCHAR (150),		-- No Action | Rebuild | Reorganize
			IndexUtilization					BIGINT,				-- Index Scan + Seek + Table Scan + DML (UPD, INS, DEL)
			DataLastCollect						DATETIME,			-- Last Collect
			CountIndexCollect					INT,				-- Count Index Collected
			Executed							BIT,				-- IF Execute(Rebuild/Reorganize) = 1, Else = 0
			DateTimeStartExecute				DATETIME,			-- Date Time Start
			DateTimeFinishExecute				DATETIME,			-- Date Time End
			DurationSecondsLastExec				INT,				-- Duration Execution in Second
			AvgExecuteSeconds					INT,				-- AVG(Second) between AvgExecuteMin and CountIndexExecuted
			CountIndexExecuted					INT,				-- Count Index Executed
			Error								NVARCHAR (3000)		-- Message Error
		)
	END;
	
	IF OBJECT_ID('tempdb..#LoopDatabase') IS NOT NULL
	BEGIN
		DROP TABLE #LoopDatabase
	END;

	IF OBJECT_ID('tempdb..#IndexHistoryTemp') IS NOT NULL
	BEGIN
		DROP TABLE #IndexHistoryTemp
	END;

	IF OBJECT_ID('tempdb..#TempSizing') IS NOT NULL
	BEGIN
		DROP TABLE #TempSizing
	END;

	IF OBJECT_ID('tempdb..#LoopDatabaseObject') IS NOT NULL
	BEGIN
		DROP TABLE #LoopDatabaseObject
	END;

	CREATE TABLE #LoopDatabase
	(
		Seq				SMALLINT		NOT NULL,
		DatabaseName	VARCHAR(500)	NOT NULL
	);

	CREATE TABLE #LoopDatabaseObject
	(
		DatabaseName		VARCHAR(500)	NOT NULL,
		SchemaName			VARCHAR(100)	NOT NULL,
		ObjectName			VARCHAR(500)	NOT NULL,
		IndexName			VARCHAR(500)	NOT NULL,
		CountIndexCollect	INT
	);

	CREATE TABLE #IndexHistoryTemp
	(
		DatabaseName				VARCHAR(500),
		ObjectId 					BIGINT,
		SchemaName					VARCHAR(50),
		ObjectName					VARCHAR(500),
		ObjectSizeMB				BIGINT,
		TableQtdrows				BIGINT,
		[PageCount]					BIGINT,
		IndexId						BIGINT,
		IndexName					VARCHAR (500),
		IndexSizeMB					BIGINT,
		IndexDepth					TINYINT,
		IndexLevel					TINYINT,
		Lobcolumn					VARCHAR (30),
		PartitionNumber				TINYINT,
		ContainsLOB					BIT,
		TableIsPartitioned			BIT,
		CountIndexCollect			INT,
		IndexTypeDesc				VARCHAR (30),
		AvgFragmentationInPercent	DECIMAL (10,2),
		AvgPageSpaceUsedInPercent	DECIMAL (10,2),
		AvgFragmentSizeInPages		DECIMAL (10,2),
		ActionType					VARCHAR (100),
		IndexUtilization			BIGINT
	)

	CREATE TABLE #TempSizing
	(
		objectId		BIGINT	NOT NULL,
		ReservedPages	BIGINT	NULL,
		UsedPages		BIGINT	NULL,
		Pages			BIGINT	NULL
	)
	
	INSERT #LoopDatabase (Seq, DatabaseName)
	SELECT 
		ROW_NUMBER() OVER(ORDER BY name)	AS Seq,
		Name								AS DatabaseName
	FROM sys.databases db
	WHERE db.database_id > 4
	AND db.state = 0
	AND db.is_read_only = 0
	AND db.name NOT LIKE 'ReportServer$%'
	AND ((db.name IN (@pDatabaseName)) OR (@pDatabaseName IS NULL));

	DECLARE cLoopDatabase CURSOR
	FOR (SELECT Seq, DatabaseName FROM #LoopDatabase)

	OPEN cLoopDatabase
	FETCH NEXT FROM cLoopDatabase INTO @cSeq, @cDatabaseName

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		IF (GETDATE() < @StopRoutine)
		BEGIN
			SET @Command = '

				USE ['+ @cDatabaseName +']

				INSERT #IndexHistoryTemp (	DatabaseName, SchemaName, ObjectName, ObjectId, IndexId, IndexName, IndexTypeDesc, IndexDepth, IndexLevel,
											AvgFragmentationInPercent, AvgPageSpaceUsedInPercent, AvgFragmentSizeInPages, [PageCount], TableIsPartitioned)
				SELECT
					DB_NAME(DB_ID())					AS [DatabaseName],
					SC.name								AS [SchamaName],
					OBJECT_NAME(STA.object_id)			AS [ObjectName],
					STA.object_id						AS [ObjectId],
					IDX.index_id						AS [IndexId],
					IDX.name							AS [IndexName],
					STA.index_type_desc					AS [IndexTypeDesc],
					STA.index_depth						AS [IndexDepth],
					STA.index_level						AS [IndexLevel],
					STA.avg_fragmentation_in_percent	AS [AvgFragmentationInPercent],
					STA.avg_page_space_used_in_percent	AS [AvgPageSpaceUsedInPercent],
					STA.avg_fragment_size_in_pages		AS [AvgFragmentSizeInPages],
					STA.page_count						AS [PageCount],
					0									AS [TableIsPartitioned]
				FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, ''SAMPLED'') STA
				INNER JOIN sys.indexes IDX
					ON STA.object_id = IDX.object_id
					AND STA.index_id = IDX.index_id
				INNER JOIN sys.objects OB
					ON STA.object_id = OB.object_id
					AND OB.type = ''U''
				INNER JOIN sys.schemas SC
					ON OB.schema_id = SC.schema_id
				LEFT JOIN sys.partition_schemes PS			
					ON IDX.data_space_id = PS.data_space_id
				WHERE STA.index_type_desc <> ''HEAP''
				AND PS.data_space_id IS NULL
				AND STA.page_count >= 5000

				INSERT #IndexHistoryTemp (	DatabaseName, SchemaName, ObjectName, ObjectId, IndexId, IndexName, PartitionNumber, IndexTypeDesc, IndexDepth, IndexLevel,
											AvgFragmentationInPercent, AvgPageSpaceUsedInPercent, AvgFragmentSizeInPages, [PageCount], TableIsPartitioned)
				SELECT
					DB_NAME(DB_ID())					AS [DatabaseName],
					SC.name								AS [SchamaName],
					OBJECT_NAME(STA.object_id)			AS [ObjectName],
					STA.object_id						AS [ObjectId],
					IDX.index_id						AS [IndexId],
					IDX.name							AS [IndexName],
					STA.partition_number				AS [PartitionNumber],
					STA.index_type_desc					AS [IndexTypeDesc],
					STA.index_depth						AS [IndexDepth],
					STA.index_level						AS [IndexLevel],
					STA.avg_fragmentation_in_percent	AS [AvgFragmentationInPercent],	
					STA.avg_page_space_used_in_percent	AS [AvgPageSpaceUsedInPercent],
					STA.avg_fragment_size_in_pages		AS [AvgFragmentSizeInPages],
					STA.page_count						AS [PageCount],
					1									AS [TableIsPartitioned]
				FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, ''DETAILED'') STA
				INNER JOIN sys.indexes IDX
					ON STA.object_id = IDX.object_id
					AND STA.index_id = IDX.index_id
				INNER JOIN sys.objects OB
					ON STA.object_id = OB.object_id
					AND OB.type = ''U''
				INNER JOIN sys.schemas SC
					ON OB.schema_id = SC.schema_id
				LEFT JOIN sys.partition_schemes PS			
					ON IDX.data_space_id = PS.data_space_id
				WHERE STA.index_type_desc <> ''HEAP''
				AND PS.data_space_id IS NOT NULL
				AND STA.page_count >= 5000

				UPDATE #IndexHistoryTemp
				SET IndexUtilization = (
										SELECT
												ISNULL(SUM(ISNULL(U.user_scans,0) + (ISNULL(U.user_lookups,0)) + ISNULL(U.user_seeks,0) + ISNULL(U.user_seeks,0) + ISNULL(U.user_updates,0)),0) AS [IndexUtilization]
										FROM ' + @cDatabaseName + '.sys.dm_db_index_usage_stats U
										INNER JOIN ' + @cDatabaseName + '.sys.objects O
											ON O.OBJECT_ID = U.OBJECT_ID
										WHERE U.index_id = #IndexHistoryTemp.[IndexId]
										AND U.object_id = #IndexHistoryTemp.[ObjectId]
										AND U.database_id = DB_ID()
										GROUP BY O.OBJECT_ID
										)

				UPDATE #IndexHistoryTemp
					SET TableQtdRows = B.rows
				FROM #IndexHistoryTemp A
				INNER JOIN ' + @cDatabaseName + ' .sys.sysindexes B
					ON A.ObjectId = B.id

				INSERT #TempSizing
					SELECT
						A.object_Id,
						SUM (A.reserved_page_count) AS ReservedPages,
						SUM (A.used_page_count) AS UsedPages,
						SUM (CASE WHEN (A.index_id < 2) THEN (A.in_row_data_page_count + A.lob_used_page_count + A.row_overflow_used_page_count)
									ELSE A.lob_used_page_count + A.row_overflow_used_page_count end)*8 AS Pages
					FROM ' + @cDatabaseName + '.sys.dm_db_partition_stats A
					INNER JOIN ' + @cDatabaseName + '.sys.indexes B
						ON A.object_id = B.object_id
						AND A.index_id = B.index_id
					GROUP BY A.object_id;
			
				UPDATE #IndexHistoryTemp
					SET ObjectSizeMB = B.pages
				FROM #IndexHistoryTemp A INNER JOIN #TempSizing B
					ON A.objectId = B.objectId

				TRUNCATE TABLE #TempSizing;'
			
			EXEC sp_executesql @command

			FETCH NEXT FROM cLoopDatabase INTO @cSeq, @cDatabaseName
		END;
		ELSE
		BEGIN
			SET @Message = N'TIME OUT: Exec Proc (sptColectInfoIndex) Time limit has been exceeded! || START: ' + CONVERT(VARCHAR(100),@StartRoutine,103) + ' | Limit: ' + CONVERT(VARCHAR(100),@StopRoutine,103)
			RAISERROR(@Message, 9, 42) WITH LOG;
			BREAK;
		END
	END;
	CLOSE cLoopDatabase;
	DEALLOCATE cLoopDatabase;

	INSERT #LoopDatabaseObject (DatabaseName, SchemaName, ObjectName, IndexName)
	SELECT DISTINCT
		DatabaseName	AS DatabaseName,
		SchemaName		AS SchemaName,
		ObjectName		AS ObjectName,
		IndexName		AS IndexName
	FROM #IndexHistoryTemp
	ORDER BY 1 ASC,2 ASC,3 ASC,4 ASC

	DECLARE cLoopDatabaseObject CURSOR
	FOR (SELECT DatabaseName, SchemaName, ObjectName, IndexName FROM #LoopDatabaseObject)

	OPEN cLoopDatabaseObject
	FETCH NEXT FROM cLoopDatabaseObject INTO @ccDatabaseName, @ccSchemaName, @ccObjectName, @ccIndexName

	WHILE (@@FETCH_STATUS = 0)
	BEGIN
		SET @LobSQL = '			
			USE ['+ @ccDatabaseName +']' 
			
			SELECT @LobSQL = @LobSQL + '
				SELECT
					@ContainsLobOUT = COUNT(*)
				FROM ' + @ccDatabaseName + '.sys.columns WITH (NoLock)
				WHERE [object_id] = ' + CAST(OBJECT_ID(@ccObjectName)	 AS VARCHAR(10)) + '
				AND (system_type_id IN (34, 35, 99) OR max_length = -1);', @LobSQLParam = '@ContainsLobOUT INT OUTPUT';
					            
		EXECUTE sp_executesql @LobSQL, @LobSQLParam, @ContainsLobOUT = @containsLOB OUTPUT

		IF (@containsLOB >=1)
		BEGIN
			UPDATE #IndexHistoryTemp
				SET ContainsLOB = 1
			WHERE DatabaseName = @ccDatabaseName
			AND SchemaName = @ccSchemaName
			AND ObjectName = @ccObjectName
		END
		ELSE
		BEGIN
			UPDATE #IndexHistoryTemp
				SET containsLOB = 0
			WHERE DatabaseName = @ccDatabaseName
			AND SchemaName = @ccSchemaName
			AND ObjectName = @ccObjectName
		END;
		
		UPDATE #IndexHistoryTemp
			SET ActionType = (CASE WHEN (AvgFragmentationInPercent < @MinFragmentation)
										THEN 'NO_ACTION_REQUIRED'
								   WHEN ((AvgFragmentationInPercent < @RebuildThreshold) OR ISNULL(@ContainsLOB,0) >= 1)
										THEN 'REORGANIZE'
										ELSE 'REBUILD'
							   END)
		WHERE DatabaseName = @ccDatabaseName
		AND SchemaName = @ccSchemaName
		AND ObjectName = @ccObjectName
		AND IndexName = @ccIndexName

		IF EXISTS (SELECT 1 FROM STI4DBA.dbo.IndexMaintenanceHistory
				   WHERE DatabaseName = @ccDatabaseName
						AND SchemaName = @ccSchemaName
						AND ObjectName = @ccObjectName
						AND IndexName = @ccIndexName
					)
		BEGIN
			UPDATE TB1
				SET TB1.DatabaseName				= TB2.DatabaseName,
					TB1.SchemaName					= TB2.SchemaName,
					TB1.ObjectId					= TB2.ObjectId,
					TB1.ObjectName					= TB2.ObjectName,
					TB1.IndexId						= TB2.IndexId,
					TB1.IndexName					= TB2.IndexName,
					TB1.ObjectSizeMB				= TB2.ObjectSizeMB,
					TB1.TableQtdRows				= TB2.TableQtdRows,
					TB1.IndexSizeMB					= TB2.IndexSizeMB,
					TB1.IndexDepth					= TB2.IndexDepth,
					TB1.IndexLevel					= TB2.IndexLevel,
					TB1.TableIsPartitioned			= TB2.TableIsPartitioned,
					TB1.PartitionNumber				= TB2.PartitionNumber,
					TB1.ContainsLOB					= TB2.ContainsLOB,
					TB1.IndexTypeDesc				= TB2.IndexTypeDesc,
					TB1.AvgFragmentationInPercent	= TB2.AvgFragmentationInPercent,
					TB1.AvgPageSpaceUsedInPercent	= TB2.AvgPageSpaceUsedInPercent,
					TB1.AvgFragmentSizeInPages		= TB2.AvgFragmentSizeInPages,
					TB1.[PageCount]					= TB2.[PageCount],
					TB1.ActionType					= TB2.ActionType,
					TB1.IndexUtilization			= ISNULL(TB2.IndexUtilization,0),
					TB1.DataLastCollect				= GETDATE(),
					TB1.Executed					= 0,					
					TB1.Error						= NULL
			FROM STI4DBA.dbo.IndexMaintenanceHistory AS TB1
			INNER JOIN #IndexHistoryTemp AS TB2
				ON TB1.DatabaseName = TB2.DatabaseName
				AND TB1.SchemaName  = TB2.SchemaName
				AND TB1.ObjectName  = TB2.ObjectName
				AND TB1.IndexName   = TB2.IndexName
			WHERE TB2.DatabaseName = @ccDatabaseName
				AND TB2.SchemaName = @ccSchemaName
				AND TB2.ObjectName = @ccObjectName
				AND TB2.IndexName  = @ccIndexName

			UPDATE IHM1
				SET CountIndexCollect = ISNULL((IHM1.CountIndexCollect + 1),0)
			FROM STI4DBA.dbo.IndexMaintenanceHistory AS IHM1
			INNER JOIN STI4DBA.dbo.IndexMaintenanceHistory AS IHM2
				ON IHM1.IdIndexMaintenanceHistory = IHM2.IdIndexMaintenanceHistory
			WHERE IHM1.DatabaseName = @ccDatabaseName
			AND IHM1.SchemaName = @ccSchemaName
			AND IHM1.ObjectName = @ccObjectName
			AND IHM1.IndexName = @ccIndexName
		END
		ELSE
		BEGIN
			INSERT STI4DBA.dbo.IndexMaintenanceHistory (InstanceName, DatabaseName, SchemaName, ObjectId, ObjectName, IndexId, IndexName, ObjectSizeMB,
														TableQtdRows,IndexSizeMB, IndexDepth, IndexLevel, TableIsPartitioned, PartitionNumber, ContainsLOB,
														IndexTypeDesc,AvgFragmentationInPercent, AvgPageSpaceUsedInPercent, AvgFragmentSizeInPages, [PageCount],
														ActionType, IndexUtilization, DataLastCollect, CountIndexCollect, Executed, DateTimeStartExecute,
														DateTimeFinishExecute, DurationSecondsLastExec, CountIndexExecuted, Error)
			SELECT	@@SERVERNAME, DatabaseName, SchemaName, ObjectId, ObjectName, IndexId, IndexName, ObjectSizeMB, TableQtdrows, IndexSizeMB, IndexDepth, IndexLevel,
					TableIsPartitioned, PartitionNumber, ContainsLOB, IndexTypeDesc, AvgFragmentationInPercent, AvgPageSpaceUsedInPercent, AvgFragmentSizeInPages,
					[PageCount], ActionType, ISNULL(IndexUtilization,0), GETDATE(), 1, 0, NULL, NULL, NULL, NULL, NULL
			FROM #IndexHistoryTemp
			WHERE DatabaseName = @ccDatabaseName
				AND SchemaName = @ccSchemaName
				AND ObjectName = @ccObjectName
				AND IndexName = @ccIndexName
		END

		FETCH NEXT FROM cLoopDatabaseObject INTO @ccDatabaseName, @ccSchemaName, @ccObjectName, @ccIndexName
	END
	
	CLOSE cLoopDatabaseObject
	DEALLOCATE cLoopDatabaseObject	

	DROP TABLE #LoopDatabase
	DROP TABLE #IndexHistoryTemp
	DROP TABLE #TempSizing
	DROP TABLE #LoopDatabaseObject
END
GO

IF (@@ERROR = 0)
BEGIN
	PRINT 'Stored Procedure STI4DBA.dbo.sptColectInfoIndex Create Success.'
END
ELSE
BEGIN
	RAISERROR('Error object STI4DBA.dbo.sptColectInfoIndex. Contact Administrator.', 9, 42) WITH LOG;
END
GO