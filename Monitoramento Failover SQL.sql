/*
	-- Exemplo de Chamada da Procedure
	EXEC [dbo].[spMonitoringFailover] 'CPTM', 'DBAProdesp', 'outsourcingbd@prodesp.sp.gov.br'
	GO

	OBS: 
		- A Procedure deve Ser configurada para executar no Start do SQL Server ou no Start no SQL Agent(Atraves de JOB).
		- A Tabela foi criada no BD ADMServer
		- Precisa do xp_cmdshell
*/


USE [ADMServer]
GO

-- CRIANDO TABELA (Utilizada para Historico do Failover)
IF (SELECT 1 FROM sys.objects WHERE name = 'MonitoringFailover') = 1
BEGIN
	DROP TABLE MonitoringFailover
END
GO

CREATE TABLE dbo.MonitoringFailover
(
	ID					INT IDENTITY(1,1) NOT NULL,
	ClusterNameWSFC		VARCHAR(50) NULL,
	ClusterNameFCI		VARCHAR(50) NULL,
	InstanceName		VARCHAR(50) NULL,
	[Owner]				VARCHAR(50) NULL,
	[Date]				DATETIME NULL,
	[Status]			VARCHAR(10) NULL
)
GO


-- SCRIPT PROCEDURE [spMonitoringFailover]

USE [ADMServer]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spMonitoringFailover] (@Cliente VARCHAR(50), @ProfileEmail VARCHAR(50), @Recipients VARCHAR(255))
WITH RECOMPILE
AS
	DECLARE	@HTML				VARCHAR(MAX),
			@CurrentNodeName	VARCHAR(123),
			@InstanceName		VARCHAR(123),			
			@ClusterNameFCI		VARCHAR(50),
			@ClusterNameWSFC	VARCHAR(50),
			@Status				VARCHAR(5),
			@Subject			VARCHAR(50),
			@ExecScriptPS		VARCHAR(100)

	IF (SERVERPROPERTY('IsClustered') = 1)
	BEGIN		
		
		CREATE TABLE #ClusterWSFC
		(
			Name VARCHAR(50)
		)

		SELECT
			@InstanceName		= CONVERT(VARCHAR, SERVERPROPERTY('ServerName')),
			@CurrentNodeName	= CONVERT(VARCHAR, SERVERPROPERTY('ComputerNamePhysicalNetBIOS')),
			@ClusterNameFCI		= CONVERT(VARCHAR, SERVERPROPERTY('MachineName')),
			@ExecScriptPS		= 'xp_cmdshell ''PowerShell.exe -noprofile -command "(Get-Cluster).name"'''

		INSERT #ClusterWSFC
		EXEC(@ExecScriptPS)
		
		SELECT 
			@ClusterNameWSFC =  UPPER(Name)
		 FROM #ClusterWSFC
		 WHERE Name IS NOT NULL

		SELECT
			@Status = UPPER(Status_Description)
		FROM sys.dm_os_cluster_nodes
		WHERE is_current_owner = 1
			
		INSERT [ADMServer].[dbo].[MonitoringFailover] (ClusterNameWSFC, ClusterNameFCI ,InstanceName, [Status], [Owner],  [Date])
		VALUES (@ClusterNameWSFC, @ClusterNameFCI, @InstanceName, @Status, @CurrentNodeName, GETDATE());

		SET @HTML =    
			'<body>
				<table width="100%" bgColor="#ffffff">
					<tr>
						<td align="center">
							<p><font face="arial" size="6"><b>.:: Alerta de Failover Cluster - SQL Server ::.</b></font></p>
							<p><font face="arial" size="3"><b> Ambiente: ' + UPPER(@Cliente) + '</b></font></p>
						</td>
						<td align="center">
							<img src= "http://www.e-folha.sp.gov.br/compartilhados/images/prodesp.gif">
						</td>
					</tr>
				</table><br>

				<p>
					<font face="verdana" size="2"><b>Responsável:</b>' + ' Serviço de Suporte e Implantação de Banco de Dados - SIBD' + '</font>
				</p>
				<p>
					<font face="verdana" size="2"><b>Contato:</b>' + ' outsourcingbd@prodesp.sp.gov.br' + '</font>
				</p>
				<p style="margin-top: 0; margin-bottom: 0"></p></style>
				<hr color="#000000" size="2"></hr><br>
		
				<table style="BORDER-COLLAPSE: collapse"  width="40%" bgColor="#ffffff" borderColorLight="#000000"></style>
					<tr>
						<td align="left"> <b> <font face="verdana" size="2" color="#000000Y">CLUSTER WINDOWS (WSFC)</b></font></td>' + '<td align="left" bgcolor="#FFFFFF"> <font face="verdana" size="2" color="#000000Y">' + ':' +  @ClusterNameWSFC + '</td></font>
					</tr>
					<tr>
						<td align="left"> <b> <font face="verdana" size="2" color="#000000Y">CLUSTER WINDOWS (FCI)</b></font></td>' + '<td align="left" bgcolor="#FFFFFF"> <font face="verdana" size="2" color="#000000Y">' + ':' + @ClusterNameFCI + '</td></font>
					</tr>
					<tr>
						<td align="left"> <b> <font face="verdana" size="2" color="#000000Y">INSTANCE NAME</b></font></td>' + '<td align="left" bgcolor="#FFFFFF"> <font face="verdana" size="2" color="#000000Y">' + ':' + @InstanceName + '</td></font>
					</tr>
					<tr>
						<td align="left"> <b> <font face="verdana" size="2" color="#000000Y">DATE(Last Recovery)</b></font></td>' + '<td align="left" bgcolor="#FFFFFF"> <font face="verdana" size="2" color="#000000Y">' + ':' + CONVERT(VARCHAR(255), GETDATE()) + '</td></font>
					</tr>
				</table><br> <br>			

				<table style="BORDER-COLLAPSE: collapse" borderColor="#111111" cellPadding="0" width="50%" bgColor="#ffffff" border="1"></style>
					<tr>
						<th  height="25" colspan=8 bgColor="#000000">
						<font color="#FFFFFF" face="verdana" size="3"><b>.:: Status Atual do Cluster ::.</b></font>
						</th>
					</tr>
					<tr>					
						<td  height="25" align="center" bgcolor="#D3D3D3">
							<font face="verdana" size="1" color="#000000"><b>NODE</b></font>
						</td>
						<td  height="25" align="center" bgcolor="#D3D3D3">
							<font face="verdana" size="1" color="#000000"><b>OWNER</b></font>
						</td>					
						<td  height="25" align="center" bgcolor="#D3D3D3">
							<font face="verdana" size="1" color="#000000"><b>STATUS</b></font>
						</td>
					</tr>'
					SELECT 
						@HTML =  @HTML +
						'<tr>
							 <td align="center"><font face="verdana" size="2">' + ISNULL(CONVERT(VARCHAR(50), tb1.NodeName), '') +'</font></td>' +
							CASE WHEN tb1.is_current_owner = 1
							THEN'<td bgColor="#0000FF" align="center"><font color="#FFFFFF" face="verdana" size="2"><b>' + ISNULL(CONVERT(VARCHAR(50), tb1.is_current_owner ), '') + '</b></font></td>'
							ELSE '<td align="center"><font face="verdana" size="2">' + ISNULL(CONVERT(VARCHAR(50), tb1.is_current_owner ), '') +'</b></font></td>' END + 
							CASE WHEN tb1.status = 0
								THEN '<td bgColor="#33ff33" align="center"><font face="verdana" size="2"><b>' + UPPER(ISNULL(CONVERT(VARCHAR(50), tb1.status_description), '')) + '</b></font></td>'
								ELSE '<td bgColor="#ff0000" align="center"><font face="verdana" size="2"><b>' + UPPER(ISNULL(CONVERT(VARCHAR(50), tb1.status_description), '')) + '</b></font></td>
						</tr>' END
					FROM sys.dm_os_cluster_nodes tb1
						SET @HTML = @HTML +
				'</table><br><br>
			
				<table style="BORDER-COLLAPSE: collapse" borderColor="#111111" cellPadding="0" width="80%" bgColor="#ffffff" border="1"></style>
					<tr>
						<th  height="25" colspan=8 bgColor="#000000">
						<font color="#FFFFFF" face="verdana" size="3"><b>.:: Histórico Failover ::.</b></font>
						</th>
					</tr>
					<tr>					
						<td  height="25" align="center" bgcolor="#D3D3D3">
							<font face="verdana" size="1" color="#000000"><b>CLUSTER WINDOWS (FCI)</b></font>
						</td>
						<td  height="25" align="center" bgcolor="#D3D3D3">
							<font face="verdana" size="1" color="#000000"><b>INSTANCE NAME</b></font>
						</td>
						<td  height="25" align="center" bgcolor="#D3D3D3">
							<font face="verdana" size="1" color="#000000"><b>OWNER</b></font>
						</td>
						<td  height="25" align="center" bgcolor="#D3D3D3">
							<font face="verdana" size="1" color="#000000"><b>DATE</b></font>
						</td>
					</tr>'
					SELECT
						@HTML =  @HTML +
						'<tr>					 
							 <td align="center"><font face="verdana" size="2">' + ISNULL(CONVERT(VARCHAR(50), ClusterNameFCI), '') +'</font></td>' +
							'<td align="center"><font face="verdana" size="2">' + ISNULL(CONVERT(VARCHAR(50), InstanceName), '') +'</font></td>' +
							'<td align="center"><font face="verdana" size="2">' + ISNULL(CONVERT(VARCHAR(50), [OWNER]), '') +'</font></td>' +
							'<td align="center"><font face="verdana" size="2">' + ISNULL(CONVERT(VARCHAR(50), [DATE]), '') +'</font></td>
						</tr>'
					FROM [ADMServer].[dbo].[MonitoringFailover]
					ORDER BY [DATE] ASC
					SET @HTML = @HTML + 
				'</table></body><br><br>'
		
		SET @subject = '[' + @Cliente + '] Alerta de Failover Cluster - SQL SERVER' 

		DROP TABLE #ClusterWSFC

		EXEC msdb.dbo.sp_send_dbmail
			@profile_name = @ProfileEmail,
			@recipients= @Recipients,
			@subject = @subject,
			@body = @HTML,
			@body_format = 'HTML';
	END
GO