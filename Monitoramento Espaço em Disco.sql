/*
	Script: Monitoramento Espaço livre dos arquivos dos banco de dados
	Objetivo: Monitorar os espaço disponivel em disco e disparar alerta quando o disco chegar em x% de espaço livre
	OBS: Criar JOB com essa rotina.
*/

BEGIN
	SET NOCOUNT ON

	CREATE TABLE #DBINFORMATION
	(
		ServerName			VARCHAR(100)	NOT NULL, 
		DatabaseName		VARCHAR(100)	NOT NULL, 
		LogicalFileName		SYSNAME			NOT NULL, 
		PhysicalFileName	NVARCHAR(520)	NULL, 
		FileSizeMB			INT				NULL,
		Status				SYSNAME			NULl,
		RecoveryMode		SYSNAME			NULL,
		FreeSpaceMB			INT				NULL, 
		FreeSpacePct		INT				NULL,
		Dateandtime			VARCHAR(10)		NOT NULL
	)

	ALTER TABLE #DBINFORMATION
	ADD CONSTRAINT Comb_SNDNDT2 UNIQUE(ServerName, DatabaseName, Dateandtime,LogicalFileName)

	ALTER TABLE #DBINFORMATION
	ADD CONSTRAINT Pk_SNDNDT2 PRIMARY KEY (ServerName, DatabaseName, Dateandtime,LogicalFileName)

	/* I found the code snippet below on the web from another DB Forum and tweaked it as per my need. So Lets take a moment to appreciate the person who has made this available for us*/
	DECLARE @command			VARCHAR(5000),
			@Pct				SMALLINT,
			@PctSet				SMALLINT,
			@servername			VARCHAR(100),
			@DatabaseName		VARCHAR(100),
			@FileSizeMB			INT,
			@Status				SYSNAME, 
			@RecoveryMode		SYSNAME,
			@FreeSpaceMB		INT, 
			@FreeSpacePct		INT, 
			@Dateandtime		VARCHAR(10),
			@CONTROLE			SMALLINT,
			@LogicalFileName	VARCHAR(5000),
			@PhysicalFileName	VARCHAR(5000),
			@HTML_Body			VARCHAR(MAX),
			@HTML_Head			VARCHAR(MAX),
			@HTML_Tail			VARCHAR(MAX) 
        
	SET @PctSet = 10 -- Percentual de alerta
        
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
						AS decimal(4,2))) as Int) AS FreeSpacePct, CONVERT(VARCHAR(10),GETDATE(),103) as dateandtime 
						FROM dbo.sysfiles' 

	INSERT INTO #DBINFORMATION 
	 (
		ServerName, 
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

	DECLARE CONTROLETAMANHO CURSOR LOCAL FAST_FORWARD FOR
		SELECT	
			FreeSpacePct
		FROM 
			#dbinformation
		WHERE filesizemb > 0
		AND databasename NOT IN ('master','model','msdb')
		--AND logicalfilename NOT IN ('iss_osasco_imagem02','iss_osasco_imagem03','iss_osasco03','iss_osasco_imagem04','iss_osasco02','iss_osasco_imagem05')

	OPEN CONTROLETAMANHO
	FETCH NEXT FROM CONTROLETAMANHO INTO @Pct
	
	SET @CONTROLE = 0
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @PCT <= @PctSet
		BEGIN
			SET @CONTROLE = @CONTROLE + 1
		END
		FETCH NEXT FROM CONTROLETAMANHO INTO @Pct
	END

	IF @CONTROLE > 0
	BEGIN 
		SET @HTML_Head = '<html>'
		SET @HTML_Head = @HTML_Head + '<head>' + CHAR(13) + CHAR(10) ;
		SET @HTML_Head = @HTML_Head + ' <style>' + CHAR(13) + CHAR(10) ;
		SET @HTML_Head = @HTML_Head + ' body{font-family: arial; font-size: 13px;}table{font-family: arial; font-size: 13px; border-collapse: collapse;width:100%} td {padding: 2px;height:15px;border:solid 1px black;} th {padding: 2px;background-color:black;color:white;border:solid 1px black;}' + CHAR(13) + CHAR(10) ;
		SET @HTML_Head = @HTML_Head + ' </style>' + CHAR(13) + CHAR(10) ;
		SET @HTML_Head = @HTML_Head + '</head>' + CHAR(13) + CHAR(10) ;
		SET @HTML_Head = @HTML_Head + '<body><b>Abaixo lista dos logical files com pouco espaço.</b><hr />' + CHAR(13) + CHAR(10) ;
		SET @HTML_Head = @HTML_Head + '<table>' + CHAR(13) + CHAR(10) ;
		SET @HTML_Head = @HTML_Head + ' <tr>' + CHAR(13) + CHAR(10) ;
		SET @HTML_Head = @HTML_Head + ' <th>ServerName</th>' + CHAR(13) + CHAR(10) ;
		SET @HTML_Head = @HTML_Head + ' <th>DatabaseName</th>' + CHAR(13) + CHAR(10) ;
		SET @HTML_Head = @HTML_Head + ' <th>LogicalFileName</th>' + CHAR(13) + CHAR(10) ;
		SET @HTML_Head = @HTML_Head + ' <th>FileSizeMb</th>' + CHAR(13) + CHAR(10) ;
		SET @HTML_Head = @HTML_Head + ' <th>RecoveryMode</th>' + CHAR(13) + CHAR(10) ;
		SET @HTML_Head = @HTML_Head + ' <th>FreeSpaceMB</th>' + CHAR(13) + CHAR(10) ;
		SET @HTML_Head = @HTML_Head + ' <th>FreeSpacePct</th>' + CHAR(13) + CHAR(10) ;
		SET @HTML_Head = @HTML_Head + ' <th>Date</th>' + CHAR(13) + CHAR(10) ;
		SET @HTML_Head = @HTML_Head + ' </tr>' + CHAR(13) + CHAR(10) ;
		SET @HTML_Tail = '</table></body></html>' ; 

		SET @HTML_Body = @HTML_Head +(SELECT ServerName AS [TD],DatabaseName AS [TD],LogicalFileName AS [TD],FileSizeMB AS [TD],RecoveryMode AS [TD],FreeSpaceMB AS [TD],FreeSpacePct AS [TD],Dateandtime AS [TD]
										FROM #DBINFORMATION
										WHERE filesizemb > 0
										AND databasename NOT IN ('master','model','msdb')
										--AND logicalfilename NOT IN ('iss_osasco_imagem02','iss_osasco_imagem03','iss_osasco03','iss_osasco_imagem04','iss_osasco02','iss_osasco_imagem05')-> BDs que ficam fora da Monitoria
										AND FreeSpacePct <= @PctSet 
										order by 7 asc  FOR XML RAW('tr') ,ELEMENTS) + @HTML_Tail


		EXEC MSDB..SP_SEND_DBMAIL
		@profile_name = 'LuizhRosario', -- Alterar o Profile
		@RECIPIENTS = 'luizh.rosario@gmail.com',
	   	@body = @HTML_Body,
   		@body_format = 'HTML',
   		@SUBJECT = 'ALERTA FALTA DE ESPAÇO' -- Incluir o nome do servidor

	END
	
	CLOSE CONTROLETAMANHO
	DEALLOCATE CONTROLETAMANHO
	
	DROP TABLE #DBINFORMATION
	SET NOCOUNT OFF
END
GO