
-- SCRIPT JOB
USE master
GO

SET XACT_ABORT ON
GO

EXEC master.dbo.sp_ADMBaseLineTamBanco
GO




-- SCRIPT
USE [master]
GO
/****** Object:  StoredProcedure [dbo].[sp_ADMBaseLineTamBanco]    Script Date: 09/06/2015 09:50:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_ADMBaseLineTamBanco]
WITH RECOMPILE
AS
	SET NOCOUNT ON
 
	CREATE TABLE #DBINFORMATION2
	( 
		ServerName			VARCHAR(100)	NOT NULL,
		DatabaseName		VARCHAR(100)	NOT NULL,
		LogicalFileName		SYSNAME			NOT NULL,
		PhysicalFileName	NVARCHAR(520),
		FileSizeMB			INT,
		RecoveryMode		SYSNAME,
		FreeSpaceMB			INT,
		FreeSpacePct		INT,
		Dateandtime			DATETIME		NOT NULL
	)

	ALTER TABLE #DBINFORMATION2
	ADD CONSTRAINT Comb_SNDNDT2_3 UNIQUE(ServerName, DatabaseName, Dateandtime,LogicalFileName)

	ALTER TABLE #DBINFORMATION2
	ADD CONSTRAINT Pk_SNDNDT2_3 PRIMARY KEY (ServerName, DatabaseName, Dateandtime,LogicalFileName)

	DECLARE @command		VARCHAR(5000),
			@Pct			SMALLINT,
			@servername		VARCHAR(100),
			@DatabaseName	VARCHAR(100),
			@FileSizeMB		INT,
			@RecoveryMode	SYSNAME,
			@FreeSpaceMB	INT,
			@FreeSpacePct	INT,
			@Dateandtime	VARCHAR(10),
			@CONTROLE		SMALLINT

	SELECT @command = 'Use [' + '?' + '] SELECT
						@@servername as ServerName,
						' + '''' + '?' + '''' + ' AS DatabaseName,
						Cast (sysfiles.size/128.0 AS int) AS FileSizeMB,
						sysfiles.name AS LogicalFileName, sysfiles.filename AS PhysicalFileName,
						CONVERT(sysname,DatabasePropertyEx(''?'',''Recovery'')) AS RecoveryMode,
						CAST(sysfiles.size/128.0 - CAST(FILEPROPERTY(sysfiles.name, ' + '''' +
						 'SpaceUsed' + '''' + ' ) AS int)/128.0 AS int) AS FreeSpaceMB,
						CAST(100 * (CAST (((sysfiles.size/128.0 -CAST(FILEPROPERTY(sysfiles.name,
						' + '''' + 'SpaceUsed' + '''' + ' ) AS int)/128.0)/(sysfiles.size/128.0))
						AS decimal(4,2))) as Int) AS FreeSpacePct, GETDATE() as dateandtime
						FROM dbo.sysfiles'

	INSERT INTO [SERV-DBPRODCL04].[ADM_DBAMonitoria].[dbo].[BaseLineTamBanco]
	(
		ServerName,
		DatabaseName,
		FileSizeMB,
		LogicalFileName,
		PhysicalFileName,
		RecoveryMode,
		FreeSpaceMB,
		FreeSpacePct,
		dateandtime
	)

	EXEC sp_MSForEachDB @command
 
	SET NOCOUNT OFF
 
	DROP TABLE #DBINFORMATION2

