CREATE PROCEDURE sp_TamanhoBancos
AS

SET NOCOUNT ON

CREATE TABLE #DBINFORMATION2
( ServerName VARCHAR(100)Not Null, 
DatabaseName VARCHAR(100)Not Null, 
LogicalFileName sysname Not Null, 
PhysicalFileName NVARCHAR(520), 
FileSizeMB INT,
Status sysname, 
RecoveryMode sysname, 
FreeSpaceMB INT, 
FreeSpacePct INT, 
Dateandtime varchar(10) not null
)


Alter table #DBINFORMATION2 ADD CONSTRAINT Comb_SNDNDT2_3 UNIQUE(ServerName, DatabaseName, Dateandtime,LogicalFileName)
Alter table #DBINFORMATION2 ADD CONSTRAINT Pk_SNDNDT2_3 PRIMARY KEY (ServerName, DatabaseName, Dateandtime,LogicalFileName)

/* I found the code snippet below on the web from another DB Forum and tweaked it as per my need. So Lets take a moment to appreciate the person who has made this available for us*/
DECLARE @command VARCHAR(5000),
        @Pct SMALLINT,
        @servername VARCHAR(100),
        @DatabaseName VARCHAR(100),
        @FileSizeMB INT,
        @Status sysname, 
        @RecoveryMode sysname,
        @FreeSpaceMB INT, 
        @FreeSpacePct INT, 
        @Dateandtime varchar(10),
        @CONTROLE SMALLINT
        
SELECT @command = 'Use [' + '?' + '] SELECT 
@@servername as ServerName, 
' + '''' + '?' + '''' + ' AS DatabaseName, 
Cast (sysfiles.size/128.0 AS int) AS FileSizeMB, 
sysfiles.name AS LogicalFileName, sysfiles.filename AS PhysicalFileName, 
CONVERT(sysname,DatabasePropertyEx(''?'',''Status'')) AS Status, 
CONVERT(sysname,DatabasePropertyEx(''?'',''Recovery'')) AS RecoveryMode, 
CAST(sysfiles.size/128.0 - CAST(FILEPROPERTY(sysfiles.name, ' + '''' + 
 'SpaceUsed' + '''' + ' ) AS int)/128.0 AS int) AS FreeSpaceMB, 
CAST(100 * (CAST (((sysfiles.size/128.0 -CAST(FILEPROPERTY(sysfiles.name, 
' + '''' + 'SpaceUsed' + '''' + ' ) AS int)/128.0)/(sysfiles.size/128.0)) 
AS decimal(4,2))) as Int) AS FreeSpacePct, CONVERT(VARCHAR(10),GETDATE(),111) as dateandtime 
FROM dbo.sysfiles' 
INSERT INTO #DBINFORMATION2
 (ServerName, 
 DatabaseName,
 FileSizeMB, 
 LogicalFileName, 
 PhysicalFileName, 
 Status, 
 RecoveryMode, 
 FreeSpaceMB, 
 FreeSpacePct,
 dateandtime 
 ) 
EXEC sp_MSForEachDB @command


 SELECT	
			convert(varchar(100),LTRIM(RTRIM(servername))) AS 'SERVERNAME',
			convert(varchar(100),LTRIM(RTRIM(databasename))) AS 'DATABASENAME',
			convert(varchar(100),LTRIM(RTRIM(LogicalFileName)))AS 'LOGICALFILENAME',
			convert(varchar(100),LTRIM(RTRIM(PhysicalFileName)))AS 'PHYSICALFILENAME', 
			FileSizeMB,
			convert(varchar(100),LTRIM(RTRIM(Status)))AS 'STATUS',
			convert(varchar(100),LTRIM(RTRIM(RecoveryMode)))AS 'RECOVERYMODE',
			FreeSpaceMB,
			FreeSpacePct,
			Dateandtime
	FROM 
        #dbinformation2

SET NOCOUNT OFF

drop table #DBINFORMATION2