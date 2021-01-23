Use [BANCO]

GO
/****** Object:  StoredProcedure [dbo].[TRANSACTION_LOG_SHRINK]    Script Date: 06/10/2011 13:54:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[TRANSACTION_LOG_SHRINK] as 

DECLARE @TempVirtualLogFile AS TABLE ( FileId TINYINT, FileSize BIGINT, StartOffset BIGINT, FSeqNo INT, [Status] TINYINT, Parity TINYINT, CreateLSN VARCHAR(50))     
DECLARE @BackupPathName VARCHAR(1000)  
DECLARE @BackupTime VARCHAR(50)  
DECLARE @LogFileName VARCHAR(250)     
DECLARE @DB_Name VARCHAR(250)     
DECLARE @CommandShell VARCHAR(250)

INSERT @TempVirtualLogFile     
EXEC ('DBCC LOGINFO')        

SELECT  TOP 1 @LogFileName = [name] 
FROM    sys.database_files 
WHERE   type = 1   

WHILE (            
		SELECT  COUNT(*) AS Nb            
			FROM   @TempVirtualLogFile fu            
				INNER JOIN sys.database_files fd ON fu.FileId = fd.[file_id]
							AND [Status] = 2  -- VLF actives        
		GROUP BY fd.name           
	) > 1    
BEGIN 
	SET @BackupTime = CONVERT(VARCHAR, GETDATE(), 112) + REPLACE(CONVERT(VARCHAR, GETDATE(), 114), ':', '')      
--	SET @BackupPathName = 'e:\' + DB_NAME() + '_' + @BackupTime + '.TRN'  
	SET @BackupPathName = 'e:\backup_log_' + DB_NAME() + '.TRN'  
	SET @CommandShell = 'del ' + @BackupPathName
	SET @DB_Name = DB_NAME()
	
	-- !!! Remplacer le nom de la base de données en miroir    
	BACKUP LOG @DB_Name TO DISK = @BackupPathName      
	
	WAITFOR DELAY '00:00:01'
	       
	DELETE FROM @TempVirtualLogFile            
	INSERT @TempVirtualLogFile         
	EXEC ('DBCC LOGINFO')         

	EXEC master.dbo.xp_cmdshell @CommandShell

END     

DBCC SHRINKFILE(@LogFileName , 0) WITH NO_INFOMSGS
