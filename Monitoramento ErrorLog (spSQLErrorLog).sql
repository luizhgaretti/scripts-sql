/*
	SCRIPT	: Rotina de monitoramento do ERRORLog
	DATA	: 15/12/2015
	VERSÕES	: SQL Server 2008R2, 2012, 2014, 2016
	
	Observações:
	*Agendar o JOB para executar a cada 30 min, incluindo o chamada para a procedure spSQLErrorLog*
	EXEC [SQLErrorLog] Minutos, 'Prodiler DatabaseMail', 'Destinatarios', 'Cliente'

EXEC spSQLErrorLog 30, 'DBAProdesp', 'lhgrosario@apoioprodesp.sp.gov.br', 'CPTM'
										outsourcingbd@prodesp.sp.gov.br
GO
*/

USE ADMServer
GO

ALTER PROCEDURE [dbo].[spSQLErrorLog] ( @Minutes		INT = NULL,
										@ProfileMail	VARCHAR(50),
										@Recipients		VARCHAR(255),
										@Cliente		VARCHAR(50))
WITH RECOMPILE
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ERRORMSG	VARCHAR(8000)
	DECLARE @SUBJECT	VARCHAR(8000)
	DECLARE @MSGBODY	VARCHAR(8000)
	DECLARE @SQLVERSION VARCHAR(4)	
	DECLARE @Mins		INT			

	CREATE TABLE #SQLErrorLog
	(
		[TEXT] [varchar](8000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
	)
			
	CREATE TABLE #ErrorLog
	(
		LogDate		DATETIME,
		ProcessInfo	VARCHAR(50),
		[Text]		VARCHAR(4000)
	)

	SET @SUBJECT = '[' + @Cliente + ']' + ' SQL Server Error Log [' + @@SERVERNAME + ']'
	
	IF @Minutes IS NULL
		SET @Mins = 10 -- Default 10min
	ELSE
		SET @Mins = @Minutes -- Parametro Entrada

	INSERT INTO #ErrorLog 
	EXEC sp_readerrorlog
	
	DELETE FROM #ErrorLog 
		WHERE LogDate < CAST(DATEADD(MI,-@Mins, GETDATE()) AS VARCHAR(23))
		 OR ([Text] LIKE '%Intel X86%')
		 OR ([Text] LIKE '%Copyright%')
		 OR ([Text] LIKE '%All rights reserved.%')
		 OR ([Text] LIKE '%Server Process ID is %')
		 OR ([Text] LIKE '%Logging SQL Server messages in file %')
		 OR ([Text] LIKE '%Errorlog has been reinitialized%')
		 OR ([Text] LIKE '%This instance of SQL Server has been using a process ID %')
		 OR ([Text] LIKE '%Starting up database %')
		 OR ([Text] LIKE '%SQL Server Listening %')
		 OR ([Text] LIKE '%SQL Server is ready %')
		 OR ([Text] LIKE '%Clearing tempdb %')
		 OR ([Text] LIKE '%to execute extended stored procedure %')
		 OR ([Text] LIKE '%Analysis of database %')
		 OR ([Text] LIKE 'SQL Trace %')
		 OR ([Text] LIKE 'DBCC TRACEON 2528 %')
		 OR ([Text] LIKE 'DBCC TRACEOFF 2528 %')
		 OR ([Text] LIKE '%Ole Automation Procedures%')	 
		 OR ([Text] LIKE '%show advanced options%')	
		 OR (ProcessInfo = 'BACKUP')
	 
	SELECT
		@ERRORMSG = COALESCE(@ERRORMSG + CHAR(13) , '')  + CAST(LogDate AS VARCHAR(23)) + '  '  + [Text]
	FROM #ErrorLog
  
	IF (@ERRORMSG IS NOT NULL)
		INSERT INTO #SQLErrorLog
		SELECT @ERRORMSG

	DECLARE CURSOR1 CURSOR FOR SELECT [TEXT] FROM #SQLErrorLog
	OPEN CURSOR1 FETCH NEXT FROM CURSOR1 INTO @MSGBODY
	
	WHILE (@@FETCH_STATUS = 0)
	BEGIN  	
		EXEC msdb.dbo.sp_send_dbmail
		@profile_name = @ProfileMail,
		@recipients =	@Recipients,
		@body =			@MSGBODY,
		@subject =		@SUBJECT;
	
		FETCH NEXT FROM CURSOR1
		INTO @MSGBODY
	END 

	CLOSE CURSOR1
	DEALLOCATE CURSOR1
 		
	DROP TABLE #SQLErrorLog
	DROP TABLE #ErrorLog
END
GO