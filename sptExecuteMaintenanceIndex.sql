SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF ((SELECT COUNT(1) FROM sys.databases WHERE name = 'STI4DBA') = 0)
BEGIN
	RAISERROR('Database STI4DBA not exstis. Please, Create Database STI4DBA for Continue. Contact Administrator.', 9, 42) WITH LOG;
	RETURN;
END

IF EXISTS (SELECT name FROM STI4DBA.sys.procedures WHERE Name = 'sptExecuteMaintenanceIndex')
BEGIN
	DROP PROCEDURE sptExecuteMaintenanceIndex;
END
GO

USE STI4DBA
GO

ALTER PROCEDURE dbo.sptExecuteMaintenanceIndex (@pDatabaseName			NVARCHAR(500),
												 @pQtdMinExecution		INT,
												 @pChangeRecoModel		BIT,
												 @pSortInTempdb			BIT,
												 @pMaxDop				TINYINT)
/*
	## Rotina:
		Executa Manutenção (Rebuild/Reorganize) dos Indices - TJSP - DSE Microsoft @2016
	
	## Schedule:
		Diário (Segunda á Sexta)
	
	## Regra Macro:
		1) Captura Fragmentação (Rebuild ou Reorganize) - sptColetaStatisticsIndex
		2) Captura Indice mais utilizados - sptColetaStatisticsIndex
		3) Captura Estimativa de Tempo de Operação - sptColetaStatisticsIndex
		4) Compara com a Janela (restante) - sptExecuteMaintenanceIndex
		5) Executa Operação Rebuid/Reorganize - sptExecuteMaintenanceIndex
		6) Atualiza Tabela com as novas informações da execução - sptExecuteMaintenanceIndex
	
	## Parametros:
		* sptColetaIndexPhysical @pDatabaseName NVARCHAR(500), @pQtdHoursExecution TINYINT, @pChangeRecoModel BIT, @pSortInTempdb BIT, @pMaxDop TINYINT
				@pDatabaseName		= Especifica um Database ou NULL para todos.
				@@pQtdMinExecution  = Especifica a quantidade de minutos limite para execução - NULL será especificado o default de 240 minutos (4 horas).
				@pChangeRecoModel	= Especifica se altera ou não o Recovery Model de FULL para BULK_LOGGED.
				@pSortInTempdb		= Espeficica se executa Rebuild no Tempdb.
				@pMaxDop			= Expecifica Max Dop para Operação.
	
	## Exemplo de EXEC:
		EXECUTE sptExecuteMaintenanceIndex
									@pDatabaseName		 = NULL,
									@pQtdMinExecution	 = 2,
									@pChangeRecoModel	 = 1, 
									@pSortInTempdb		 = 0,
									@pMaxDop			 = NULL
*/

AS
BEGIN
	SET NOCOUNT ON;
	SET LOCK_TIMEOUT 30000;

	DECLARE @cDatabaseName				VARCHAR(500);
	DECLARE @cDatabaseId				INT;
	DECLARE	@cRecoveryModel				VARCHAR(25);
	DECLARE @ccDatabaseName				VARCHAR(500);
	DECLARE @ccSchemaName				VARCHAR(255);
	DECLARE @ccTableName				VARCHAR(255);
	DECLARE @ccIndexId					BIGINT;
	DECLARE @ccIndexName				VARCHAR(255);
	DECLARE @ccUtilization				BIGINT;
	DECLARE @ccActionType				VARCHAR(255);
	DECLARE @ccAvgExecuteSec			BIGINT;
	DECLARE @CommandMaintenance			NVARCHAR(MAX);
	DECLARE @Command					NVARCHAR(MAX);
	DECLARE @StartRoutine				DATETIME;
	DECLARE @StopRoutine				DATETIME;	
	DECLARE @StartMaintenance			DATETIME;
	DECLARE @StopMaintenance			DATETIME;	
	DECLARE @TimeLeftMin				INT;
	DECLARE @UpdatedRecoveryModel		BIT;
	DECLARE @idListIndex				INT;
	DECLARE @EditionCheck				BIT;
	DECLARE @Message					NVARCHAR(255);
	DECLARE @IndexTypeDesc				VARCHAR(255);
	DECLARE @ccDurationSecondsLastExec	BIGINT;

	IF (@pQtdMinExecution IS NULL)
	BEGIN
		SET @pQtdMinExecution = 240 /*Default = 240 minutes(4horas) de Janela*/
	END;

	IF (@pChangeRecoModel IS NULL)
	BEGIN
		SET @pChangeRecoModel = 1 /*Default = YES*/
	END;

	IF (@pSortInTempdb IS NULL)
	BEGIN
		SET @pSortInTempdb = 0 /*Default = NO*/
	END;

	IF (@pMaxDop IS NULL)
	BEGIN
		SET @pMaxDop = 0 /*Default = 0 (ALL)*/
	END;

	IF ((SELECT ServerProperty('EditionID')) IN (1804890536, 610778273, -2117995310, 1872460670))
		SET @EditionCheck = 1
	ELSE
		SET @EditionCheck = 0

	SET @StartRoutine	= GETDATE();
	SET @StopRoutine	= DATEADD(MINUTE,@pQtdMinExecution,GETDATE()); -- 1° Contexto de validação (Minute)

	IF NOT EXISTS (SELECT 1 FROM STI4DBA.sys.tables WHERE name = 'IndexMaintenanceHistory')
	BEGIN
		SET @Message = 'WARNING!!! - First, Execute Stored Procedure [sptColectInfoIndex]';
		RAISERROR(@Message, 9, 42) WITH LOG;
		RETURN;
	END;
	
	IF OBJECT_ID('tempdb..#LoopDatabase') IS NOT NULL
	BEGIN
		DROP TABLE #LoopDatabase;
	END;

	IF OBJECT_ID('tempdb..#ListIndex') IS NOT NULL
	BEGIN
		DROP TABLE #ListIndex;
	END;

	IF OBJECT_ID('tempdb..#Processor') IS NOT NULL
	BEGIN
		DROP TABLE #Processor;
	END;

	CREATE TABLE #LoopDatabase
	(
		DatabaseId		SMALLINT		NOT NULL,
		DatabaseName	VARCHAR(200)	NOT NULL,
		RecoveryModel	VARCHAR(25)		NOT NULL
	);

	CREATE TABLE #ListIndex
	(
		idListIndex				INT IDENTITY	NOT NULL,
		DatabaseName			VARCHAR(500)	NOT NULL,
		SchemaName				VARCHAR(50)		NOT NULL,
		TableName				VARCHAR(255)	NOT NULL,
		IndexName				VARCHAR(255)	NOT NULL,
		ActionType				VARCHAR(255)	NOT NULL,
		IndexTypeDesc			VARCHAR(255)	NOT NULL,
		Utilization				VARCHAR(50)		NULL,
		AvgExecuteSeconds		BIGINT			NULL,
		DurationSecondsLastExec BIGINT			NULL,
	);

	CREATE TABLE #Processor
	(
		id					INT			 NOT NULL,
        Name				VARCHAR(128) NOT NULL,
        Internal_Value		INT			 NOT NULL,
        Character_Value		INT			 NOT NULL
	);
	
	INSERT #LoopDatabase (DatabaseId, DatabaseName, RecoveryModel)
	SELECT DISTINCT
		SYSDB.database_id			AS DatabaseId,
		IDXHM1.DatabaseName			AS DatabaseName,
		SYSDB.recovery_model_desc	AS RecoveryModel
	FROM STI4DBA.dbo.IndexMaintenanceHistory IDXHM1
	INNER JOIN sys.databases SYSDB
		ON DB_ID(IDXHM1.DatabaseName) = SYSDB.database_id
	WHERE ((IDXHM1.DatabaseName IN (@pDatabaseName)) OR (@pDatabaseName IS NULL));
	
	INSERT #ListIndex (DatabaseName, SchemaName, TableName, IndexName, ActionType, Utilization, AvgExecuteSeconds, IndexTypeDesc, DurationSecondsLastExec)
	SELECT DISTINCT
		IDXHM2.DatabaseName				AS DtabaseName,
		IDXHM2.SchemaName				AS SchemaName,
		IDXHM2.ObjectName				AS ObjectName,
		IDXHM2.IndexName				AS IndexName,
		IDXHM2.ActionType				AS ActionType,
		IDXHM2.IndexUtilization			AS IndexUtilization,
		IDXHM2.AvgExecuteSeconds		AS AvgExecuteSeconds,
		IDXHM2.IndexTypeDesc			AS IndexTypeDesc,
		IDXHM2.DurationSecondsLastExec	AS DurationSecondsLastExec
	FROM STI4DBA.dbo.IndexMaintenanceHistory IDXHM2
	WHERE DatabaseName IN (SELECT DatabaseName FROM #LoopDatabase)
	AND IDXHM2.Executed = 0
	AND IDXHM2.error IS NULL
	AND IDXHM2.ActionType <> 'NO_ACTION_REQUIRED'
	ORDER BY IDXHM2.DatabaseName ASC, IDXHM2.IndexUtilization DESC

	INSERT INTO #Processor
	EXECUTE xp_msver 'ProcessorCount';

	DECLARE cLoopBD CURSOR
	FOR (SELECT DatabaseId, DatabaseName, RecoveryModel FROM #LoopDatabase)

	OPEN cLoopBD
	FETCH NEXT FROM cLoopBD INTO @cDatabaseId, @cDatabaseName, @cRecoveryModel

	IF (
		SELECT
			COUNT(*)
		FROM STI4DBA.dbo.IndexMaintenanceHistory IDXHM2
		WHERE (IDXHM2.Executed = 0 AND IDXHM2.error IS NULL AND IDXHM2.ActionType <> 'NO_ACTION_REQUIRED')
		) >= 1
	BEGIN
		WHILE (@@FETCH_STATUS = 0)
		BEGIN
			IF (GETDATE() < @StopRoutine) -- Database (1° Contexto de Validação)
			BEGIN
				IF (@cRecoveryModel = 'FULL' AND @pChangeRecoModel = 1)
				BEGIN
					SET @Command = N'ALTER DATABASE [' + @cDatabaseName + '] SET RECOVERY BULK_LOGGED WITH NO_WAIT;'
					EXECUTE sp_executeSQL @Command;
					SET @UpdatedRecoveryModel = 1;
				END;

				DECLARE ccDatabaseIndex CURSOR
				FOR (SELECT idListIndex FROM #ListIndex WHERE DatabaseName = @cDatabaseName)

				OPEN ccDatabaseIndex
				FETCH NEXT FROM ccDatabaseIndex INTO @idListIndex

				WHILE (@@FETCH_STATUS = 0)
				BEGIN							
					SELECT 
						@ccDatabaseName				= DatabaseName,
						@ccSchemaName				= SchemaName,
						@ccTableName				= TableName,
						@ccIndexName				= IndexName,
						@ccActionType				= ActionType,
						@ccAvgExecuteSec			= ISNULL(AvgExecuteSeconds,0),
						@IndexTypeDesc				= IndexTypeDesc,
						@ccDurationSecondsLastExec	= ISNULL(DurationSecondsLastExec,0)
					FROM #ListIndex
					WHERE idListIndex = @idListIndex;				

					IF @ccDurationSecondsLastExec IS NULL
						SET @ccDurationSecondsLastExec = 0

					IF ((@ccDurationSecondsLastExec) < (DATEDIFF(SECOND, @StartRoutine, @StopRoutine))) -- Index (2° Contexto de Validação)
					BEGIN
						IF (@ccActionType = 'REBUILD')
						BEGIN											
							SET @CommandMaintenance = N'USE ['+ @cDatabaseName +']' + ' ' +
									N'ALTER INDEX ' + '[' + @ccIndexName + ']' + ' ON ' + @ccSchemaName + '.' + '[' + @ccTableName + ']' + ' ' + @ccActionType
					
							IF (@EditionCheck = 1 AND (@IndexTypeDesc <> 'XML INDEX' OR @IndexTypeDesc <> 'XML INDEX'))
								SET @CommandMaintenance = @CommandMaintenance + N' WITH (ONLINE = ON'
							ELSE
								SET @CommandMaintenance = @CommandMaintenance + N' WITH (ONLINE = OFF'
					
							IF (@pSortInTempdb = 1)
								SET @CommandMaintenance = @CommandMaintenance + N', SORT_IN_TEMPDB = ON'
							ELSE
								SET @CommandMaintenance = @CommandMaintenance + N', SORT_IN_TEMPDB = OFF'
				
							IF (@pMaxDop <> 0 AND @EditionCheck = 1)
								SET @CommandMaintenance = @CommandMaintenance + N', MAXDOP = ' + CAST(@pMaxDop AS VARCHAR(2)) + N')';
							ELSE 
								SET @CommandMaintenance = @CommandMaintenance + N')';
						END
						ELSE
						BEGIN											
							SET @CommandMaintenance = N'USE ['+ @cDatabaseName +']' + ' ' +
									N'ALTER INDEX ' + '[' + @ccIndexName + ']' + ' ON ' + @ccSchemaName + '.' + '[' + @ccTableName + ']' + ' ' + @ccActionType;
						END

						SET @StartMaintenance = GETDATE();																		

						BEGIN TRY						
							EXECUTE sp_executesql @CommandMaintenance;
							SET @StopMaintenance = GETDATE();

							UPDATE STI4DBA.dbo.IndexMaintenanceHistory
								SET DateTimeStartExecute	= @StartMaintenance,
									DateTimeFinishExecute	= @StopMaintenance,
									DurationSecondsLastExec = DATEDIFF(SECOND, @StartMaintenance, @StopMaintenance),
									Executed = 1
								WHERE DatabaseName = @ccDatabaseName
									AND ObjectName = @ccTableName
									AND SchemaName = @ccSchemaName
									AND IndexName = @ccIndexName;

							UPDATE IHM1
								SET CountIndexExecuted = ISNULL((IHM1.CountIndexExecuted + 1), 1)
							FROM STI4DBA.dbo.IndexMaintenanceHistory AS IHM1
							INNER JOIN STI4DBA.dbo.IndexMaintenanceHistory AS IHM2
								ON IHM1.IdIndexMaintenanceHistory = IHM2.IdIndexMaintenanceHistory
							WHERE IHM1.DatabaseName = @ccDatabaseName
								AND IHM1.SchemaName = @ccSchemaName
								AND IHM1.ObjectName = @ccTableName
								AND IHM1.IndexName = @ccIndexName

						END TRY
						BEGIN CATCH
							UPDATE STI4DBA.dbo.IndexMaintenanceHistory
								SET DateTimeStartExecute	= @StartMaintenance,
									DateTimeFinishExecute	= @StopMaintenance,
									DurationSecondsLastExec = DATEDIFF(SECOND, @StartMaintenance, @StopMaintenance),									
									Executed = 0,
									Error = N'An error has occurred executing this command. Objetct ' + @ccDatabaseName + '.' + @ccSchemaName + '.' + @ccTableName + '.' + @ccIndexName
								WHERE DatabaseName = @ccDatabaseName
									AND ObjectName = @ccTableName
									AND SchemaName = @ccSchemaName
									AND IndexName = @ccIndexName;

							RAISERROR(N'An error has occurred executing this command (Rebuild/Reorganize)! Please review the STI4DBA.IndexMaintenanceHistory.', 9, 42) WITH LOG;
							CONTINUE;

						END CATCH
					END
					FETCH NEXT FROM ccDatabaseIndex INTO @idListIndex;
				END;

				CLOSE ccDatabaseIndex;
				DEALLOCATE ccDatabaseIndex;

				IF (@UpdatedRecoveryModel = 1)
				BEGIN
					SET @Command = N'ALTER DATABASE [' + @cDatabaseName + '] SET RECOVERY FULL WITH NO_WAIT;';
					EXECUTE sp_executesql @Command;
					SET @UpdatedRecoveryModel = NULL;
				END

				FETCH NEXT FROM cLoopBD INTO @cDatabaseId, @cDatabaseName, @cRecoveryModel
			END
			ELSE
			BEGIN
				SET @Message = N'TIME OUT: (Rebuild/Reorganize) Time limit has been exceeded! || START: ' + CONVERT(VARCHAR(100),@StartRoutine,103) + ' | Limit: ' + CONVERT(VARCHAR(100),@StopRoutine,103)
				RAISERROR(@Message, 9, 42) WITH LOG;

				IF (@UpdatedRecoveryModel = 1)
				BEGIN
					SET @Command = N'ALTER DATABASE [' + @cDatabaseName + '] SET RECOVERY FULL WITH NO_WAIT;';
					EXECUTE sp_executesql @Command;
					SET @UpdatedRecoveryModel = NULL;
				END

				BREAK;
			END
		END;
	END

	CLOSE cLoopBD;
	DEALLOCATE cLoopBD;
	
	DROP TABLE #LoopDatabase;
	DROP TABLE #ListIndex;
END
GO

IF (@@ERROR = 0)
BEGIN
	PRINT 'Stored Procedure STI4DBA.dbo.sptExecuteMaintenanceIndex Create Success.'
END
ELSE
BEGIN
	RAISERROR('Error object STI4DBA.dbo.sptExecuteMaintenanceIndex. Contact Administrator.', 9, 42) WITH LOG;
END
GO