-- SCRIPT QUE COLOCA NO JOB
exec master.dbo.sp_ADMServerInfo '10.146.56.11'
GO




--- PROCEDURE
USE [master]
GO
/****** Object:  StoredProcedure [dbo].[sp_ADMServerInfo]    Script Date: 09/06/2015 09:45:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_ADMServerInfo] (@ServerIP VARCHAR(100))
AS
BEGIN
	SET NOCOUNT ON

	--> Preparando Estruturas
	CREATE TABLE #url
	(
		idd INT IDENTITY (1,1), 
		url VARCHAR(1000)
	)

	CREATE TABLE #dirpaths 
	(
		files VARCHAR(2000)
	)
	
	CREATE TABLE #diskspace
	(
		drive VARCHAR(200), 
		diskspace INT
	)
	
	CREATE TABLE #jobs_status    
	(    
		job_id					UNIQUEIDENTIFIER,    		 
		name					SYSNAME,    
		enabled					TINYINT,    
		last_run_outcome		INT  
	)    
	
	DECLARE @TableHTML			VARCHAR(MAX),    
			@StrSubject			VARCHAR(100),    
			@Oriserver			VARCHAR(100),
			@Version			VARCHAR(250),
			@Edition			VARCHAR(100),
			@ISClustered		VARCHAR(100),
			@SP					VARCHAR(100),
			@ServerCollation	VARCHAR(100),
			@SingleUser			VARCHAR(5),
			@LicenseType		VARCHAR(100),
			@StartDate			DATETIME,
			@EndDate			DATETIME,
			@Cnt				INT,
			@URL				varchar(1000),
			@Str				varchar(1000),
			@Uptime				VARCHAR(50),
			@starttime			DATETIME,
			@currenttime		DATETIME,
			@difference_dd		INT,
			@difference_hh		INT,
			@difference_mi		INT,
			@IsHadr				VARCHAR(5)


	INSERT #jobs_status (job_id, name, enabled, last_run_outcome)
	SELECT
		A.job_id,
		C.name,
		B.enabled,
		A.last_run_outcome		
	FROM msdb.dbo.sysjobservers A, msdb.dbo.sysjobs_view B, msdb.dbo.sysjobs C
	WHERE A.job_id = B.job_id
	AND A.job_id = C.job_id
	AND C.name not in ('ADM_ServerInfo','syspolicy_purge_history')
	ORDER BY C.name ASC

	
	-- Parte UPTIME	
	SET @starttime		= (SELECT crdate FROM master..sysdatabases WHERE name = 'tempdb' )
	SET @currenttime	= GETDATE()
	SET @difference_mi	= (SELECT DATEDIFF(mi, @starttime, @currenttime))
	SET @difference_dd	= (@difference_mi/60/24)
	SET @difference_mi	= @difference_mi - (@difference_dd*60)*24	
	SET @difference_hh	= (@difference_mi/60)
	SET @difference_mi	= @difference_mi - (@difference_hh*60)
	SET @Uptime			= CONVERT(VARCHAR, @difference_dd) + ' Dia(s) ' +  CONVERT(VARCHAR, @difference_hh) + ' hora(s) ' + CONVERT(VARCHAR, @difference_mi) + ' minuto(s).'


	--> Parte Servidor	
	SELECT @OriServer	= CONVERT(VARCHAR(50), SERVERPROPERTY('servername'))
	SELECT @Version		= @@VERSION
	SELECT @Edition		= CONVERT(VARCHAR(100), SERVERPROPERTY('Edition'))
	SELECT @SP			= CONVERT(VARCHAR(100), SERVERPROPERTY ('productlevel'))
		
	IF SERVERPROPERTY('IsClustered') = 0 
	BEGIN
		SELECT @ISClustered = 'NO'
	END
	ELSE
	BEGIN
		SELECT @ISClustered = 'YES'
	END

	IF SERVERPROPERTY('IsHadrEnabled') = 0 
	BEGIN
		SELECT @IsHadr = 'NO'
	END
	ELSE
	BEGIN
		SELECT @IsHadr = 'YES'
	END

	
	--> Parte Discos
	INSERT #diskspace(drive, diskspace) EXEC xp_fixeddrives     

	SET @TableHTML =    
	'<font face="Verdana" size="4"> .:: Server Info ::. </font> <br>
	<table style="BORDER-COLLAPSE: collapse" borderColor="#111111" cellPadding="0" width="933" bgColor="#ffffff" borderColorLight="#000000" border="1">
		<tr> 
			<td width="12%" height="25" align="center" bgcolor="#696969"><b>  
			<font face="Verdana" size="2" color="#FFFFFF">SERVER IP</font></b></td>  
			<td width="13%" height="25" align="center" bgcolor="#696969"><b>  
			<font face="Verdana" size="2" color="#FFFFFF">SERVER NAME</font></b></td>
			<td width="22%" height="25" align="center" bgcolor="#696969"><b>  
			<font face="Verdana" size="2" color="#FFFFFF">VERSION</font></b></td>
			<td width="8%" height="25" align="center" bgcolor="#696969"><b>  
			<font face="Verdana" size="2" color="#FFFFFF">SP</font></b></td>
			<td width="14%" height="25" align="center" bgcolor="#696969"><b> 
			<font face="Verdana" size="2" color="#FFFFFF">CLUSTERED FCI</font></b></td>
			<td width="12%" height="25" align="center" bgcolor="#696969"><b> 
			<font face="Verdana" size="2" color="#FFFFFF">ALWAYS ON</font></b></td>
			<td width="21%" height="25" align="center" bgcolor="#696969"><b> 
			<font face="Verdana" size="2" color="#FFFFFF">UPTIME SQL SERVER</font></b></td>
		</tr>
		<tr>
			<td width="12%" align="center" height="27"><font face="Verdana" size="1">' + @ServerIP+'</font></td>
			<td width="13%" align="center" height="27"><font face="Verdana" size="1">' + @OriServer +'</font></td>
			<td width="22%" height="27"><font face="Verdana" size="1">' + 'SQL Server 2012 ' + @edition +'</font></td>
			<td width="8%" align="center" height="27"><font face="Verdana" size="1">' + @SP +'</font></td>
			<td width="14%" align="center" height="27"><font face="Verdana" size="1">' + @isclustered +'</font></td>
			<td width="12%" align="center" height="27"><font face="Verdana" size="1">' + @IsHadr +'</font></td>
			<td width="21%" align="center" height="27"><font face="Verdana" size="1">' + @Uptime +'</font></td>			
		</tr>
	</table>
	
	
	<br> <font face="Verdana" size="4"> .:: JOBs Info ::. </font>
	<!--<p style="margin-top: 0; margin-bottom: 0">&nbsp;</p> -->'  +
	'<table style="BORDER-COLLAPSE: collapse" borderColor="#111111" cellPadding="0" width="933" bgColor="#ffffff" borderColorLight="#000000" border="1">
		<tr>  
			<th width="15%" height="25" align="center" bgcolor="#696969">
			<font face="Verdana" size="2" color="#FFFFFF">JOB NAME</font></th>
			<th width="15%" height="25" align="center" bgcolor="#696969">
			<font face="Verdana" size="2" color="#FFFFFF">ENABLED</font></th>
			<th width="15%" height="25" align="center" bgcolor="#696969">
			<font face="Verdana" size="2" color="#FFFFFF">LAST RUN</font></th>'
		SELECT 
			@TableHTML = @TableHTML + '<tr><td><font face="Verdana" size="1">' + ISNULL(CONVERT(VARCHAR(100), A.name), '') +'</font></td>' +    
							CASE a.enabled 
								WHEN 0 THEN '<td align="center" bgcolor="#FFCC99"><b><font face="Verdana" size="1">False</font></b></td>'  
								WHEN 1 THEN '<td align="center"><font face="Verdana" size="1">True</font></td>'  
							ELSE '<td align="center" ><font face="Verdana" size="1">Unknown</font></td>' END  +   
							CASE last_run_outcome     
								WHEN 0 THEN '<td bgColor="#ff0000"><b><blink><font face="Verdana" size="2">
								<a href="mailto:servicedesk@mycompany.com?subject=Job failure - ' + @Oriserver + '(' + @ServerIP + ') '+ CONVERT(VARCHAR(15), GETDATE(), 101) +'&cc=db.support@mycompany.com&body = SD please log this call to DB support,' + '%0A %0A' + '<<' + ISNULL(CONVERT(VARCHAR(100), name),'''') + '>> Job Failed on ' + @OriServer + '(' + @ServerIP + ')'+ '.' +'%0A%0A Regards,'+'">Failed</a></font></blink></b></td>'
								WHEN 1 THEN '<td align="center"><font face="Verdana" size="1">Success</font></td>'  
								WHEN 3 THEN '<td align="center"><font face="Verdana" size="1">Cancelled</font></td>'  
								WHEN 5 THEN '<td align="center"><font face="Verdana" size="1">Unknown</font></td>'  
							ELSE '<td align="center"><font face="Verdana" size="1">Other</font></td>'  
							END  + '</tr>'   
		FROM #jobs_status A

		SELECT 
			@TableHTML =  @TableHTML + 
			'
			</table> 
			<br>
			<tr>
			<tr>
				<font face="Verdana" size="4"> .:: Database Info ::. </font> <br>
				<table style="BORDER-COLLAPSE: collapse" borderColor="#111111" cellPadding="0" width="933" bgColor="#ffffff" borderColorLight="#000000" border="1">
					<tr>
						<td width="15%" height="25" align="center" bgcolor="#696969"><b>
						<font face="Verdana" size="2" color="#FFFFFF">DATABASE NAME</font></b></td>
						<td width="15%" height="25" align="center" bgcolor="#696969"><b>
						<font face="Verdana" size="2" color="#FFFFFF">CREATE DATE</font></b></td>
						<td width="15%" height="25" align="center" bgcolor="#696969"><b>
						<font face="Verdana" size="2" color="#FFFFFF">DB SIZE(MB)</font></b></td>
						<td width="15%" height="25" align="center" bgcolor="#696969"><b>
						<font face="Verdana" size="2" color="#FFFFFF">STATE</font></b></td>
						<td width="15%" height="25" align="center" bgcolor="#696969"><b>
					<font face="Verdana" size="2" color="#FFFFFF">RECOVEY MODEL</font></b></td>
					</tr>'
		SELECT
			@TableHTML =  @TableHTML +
			'<tr>
				<td><font face="Verdana" size="1">' + ISNULL(name, '') +'</font></td>' +    
			   '<td align="center"><font face="Verdana" size="1">' + CONVERT(VARCHAR(2), DATEPART(dd, create_date)) + '-' + CONVERT(VARCHAR(3),DATENAME(mm,create_date)) + '-' + CONVERT(VARCHAR(4),DATEPART(yy,create_date)) +'</font></td>' +    
			   '<td align="center"><font face="Verdana" size="1">' + ISNULL(CONVERT(VARCHAR(10), AA.[Total Size MB]), '') +'</font></td>' +    
			   '<td align="center"><font face="Verdana" size="1">' + ISNULL(state_desc, '') +'</font></td>' +    
			   '<td align="center"><font face="Verdana" size="1">' + ISNULL(recovery_model_desc, '') +'</font></td>
			 </tr>'
		FROM sys.databases MST
		INNER JOIN (SELECT b.name [LOG_DBNAME], 
					CONVERT(DECIMAL(10,2),SUM(CONVERT(DECIMAL(10,2),(a.size * 8)) /1024)) [Total Size MB]
					FROM sys.sysaltfiles A
					INNER JOIN sys.databases B on A.dbid = B.database_id
					GROUP BY b.name)AA on AA.[LOG_DBNAME] = MST.name
		ORDER BY MST.name

		SELECT
			@TableHTML =  @TableHTML + 
			'
			</table> 
			<br>
			<tr>
			<tr>
				<font face="Verdana" size="4"> .:: Disk Info ::. </font> <br>
				<table id="AutoNumber1" style="BORDER-COLLAPSE: collapse" borderColor="#111111" height="40" cellSpacing="0" cellPadding="0" width="24%" border="1">				
				 <tr>
					<td align="center" width="15%" height="25" align="center" bgcolor="#696969"><b>
					<font face="Verdana" size="2" color="#FFFFFF">DISK</font></b></td>
					<td align="center" width="15%" height="25" align="center" bgcolor="#696969"><b>
					<font face="Verdana" size="2" color="#FFFFFF">FREE SPACE(GB)</font></b></td>
				  </tr>'
		SELECT
			@TableHTML =  @TableHTML +   
			'<tr>
				<td align="center"><font face="Verdana" size="1">' + ISNULL(CONVERT(VARCHAR(100), drive), '') +'</font></td>' +    
			   '<td align="center"><font face="Verdana" size="1">' + ISNULL(CONVERT(VARCHAR(100), ISNULL(CAST(CAST(diskspace AS DECIMAL(10,2))/1024 AS DECIMAL(10,2)), 0)),'') +'</font></td>
			 </tr>' 
		FROM 
			#diskspace

		SELECT @TableHTML =  @TableHTML + '</table>'

		SELECT
			@TableHTML =  @TableHTML + '
			</table>' +   
				'<p style="margin-top: 0; margin-bottom: 0">&nbsp;</p>
				 <hr color="#000000" size="1">
				 <p><font face="Verdana" size="2"><b>Responsável:</b> '+ 'Equipe Banco de Dados Prodesp' +'</font></p>
			<p>&nbsp;</p>'

	-- Parte E-mail
	SELECT @strSubject	= '[IAMSPE] Relatório Semanal Servidor ('+ CONVERT(VARCHAR(50), SERVERPROPERTY('servername')) + ')'
	
	EXEC msdb.dbo.sp_send_dbmail  
		@profile_name = ADM_DBAProdesp,    
		@recipients='luizh.rosario@gmail.com;lhgrosario@apoioprodesp.sp.gov.br;outsourcingbd@prodesp.sp.gov.br',
		@subject = @strSubject,    
		@body = @TableHTML,    
		@body_format = 'HTML';
		
		SET NOCOUNT OFF

	DROP TABLE #diskspace
	DROP TABLE #dirpaths
	DROP TABLE #url
END
