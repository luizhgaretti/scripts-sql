CREATE TRIGGER TRU_TB_MONITOR_CPTAGEND

ON TB_MONITOR_CPTAGEND

AFTER UPDATE

AS



DECLARE @NR_PROCESSOS_OLD INT,

		@NR_PROCESSOS_NEW INT,

		@SUBJECT VARCHAR(150),

		@BODY VARCHAR(500)



SELECT	@NR_PROCESSOS_OLD = D.NR_PROCESSOS, 

		@NR_PROCESSOS_NEW = A.NR_PROCESSOS

FROM TB_MONITOR_CPTAGEND A (NOLOCK)

INNER JOIN DELETED D (NOLOCK)

	ON A.CLIENTE = D.CLIENTE 

	AND A.SQLINSTANCE = D.SQLINSTANCE 

	AND A.NICKNAME = D.NICKNAME



IF (@NR_PROCESSOS_OLD <> @NR_PROCESSOS_NEW) BEGIN

	IF (@NR_PROCESSOS_NEW < 1) BEGIN

		SELECT	@SUBJECT = 'Capta Processos Parado no Cliente ' + '''' + A.CLIENTE + '''' ,

				@BODY = 'Capta Processos parado: ' + CHAR(13) + CHAR(13) + 

						'Instância do SQL Server: ' + A.SQLINSTANCE + CHAR(13) + CHAR(13) + 

						'Hostname do SQL Server: ' + A.SQLHOSTNAME + CHAR(13) + CHAR(13) + 

						'IP do SQL Server: ' + A.IPSQL + CHAR(13) + CHAR(13) + CHAR(13) + 

						'Hostname do Capta Processos: ' + A.NICKNAME + CHAR(13) + CHAR(13) +

						'Favor Verificar Urgente!'

		FROM TB_MONITOR_CPTAGEND A (NOLOCK)

		INNER JOIN DELETED D (NOLOCK)

			ON A.CLIENTE = D.CLIENTE 

			AND A.SQLINSTANCE = D.SQLINSTANCE 

			AND A.NICKNAME = D.NICKNAME



		EXEC msdb.dbo.sp_send_dbmail  

			@profile_name = 'captasql2',

			@recipients='marcos.miyata@capta.com.br ; captamon@capta.com.br',

			@subject = @SUBJECT,

			@body = @BODY,   

			@body_format = 'text'

	 END

	 ELSE BEGIN

		SELECT	@SUBJECT = 'Capta Processos Iniciado no Cliente ' + '''' + A.CLIENTE + '''',

				@BODY = 'Capta Processos iniciado: ' + CHAR(13) + CHAR(13) + 

						'Instância do SQL Server: ' + A.SQLINSTANCE + CHAR(13) + CHAR(13) + 

						'Hostname do SQL Server: ' + A.SQLHOSTNAME + CHAR(13) + CHAR(13) + 

						'IP do SQL Server: ' + A.IPSQL + CHAR(13) + CHAR(13) + 

						'Hostname do Capta Processos: ' + A.NICKNAME + CHAR(13) + CHAR(13) 

		FROM TB_MONITOR_CPTAGEND A (NOLOCK)

		INNER JOIN DELETED D (NOLOCK)

			ON A.CLIENTE = D.CLIENTE 

			AND A.SQLINSTANCE = D.SQLINSTANCE 

			AND A.NICKNAME = D.NICKNAME



		EXEC msdb.dbo.sp_send_dbmail  

			@profile_name = 'captasql2',

			@recipients='marcos.miyata@capta.com.br ; captamon@capta.com.br',

			@subject = @SUBJECT,

			@body = @BODY,   

			@body_format = 'text'

	 END

END



UPDATE TB_MONITOR_CPTAGEND SET DT_ALT = GETDATE()

FROM TB_MONITOR_CPTAGEND A INNER JOIN DELETED D 

ON A.CLIENTE = D.CLIENTE AND A.SQLINSTANCE = D.SQLINSTANCE AND A.NICKNAME = D.NICKNAME





---------------------------------------------------------------------
Create Procedure sp_cpt_mon_atualiza_backup_capta  @nCliente INT = NULL
AS	 
 Insert Into [200.158.216.85].[MonitorDBA].[dbo].[Tb_MON_Mov_IndicadoresMonitor] (nCliente
 , nTipoMonitor
 , dConclusao )
 Values (@nCliente, 1, getdate())
 If Object_Id ('tempdb..#tmp_ultimo_backup') > 0 Drop Table #tmp_ultimo_backup
	Select bs.database_name, max(bs.backup_finish_date) backup_finish_date
		Into #tmp_ultimo_backup
		From msdb.dbo.backupset bs (NoLock) 
        Inner Join master.dbo.sysdatabases db (NoLock) 
        On bs.database_name Collate SQL_Latin1_General_CP1_CI_AS = db.name 
        And IsNull(db.Version, 0) <> 0
        Group By bs.database_name;
    Insert Into [200.158.216.85].monitordba.dbo.Tb_Mon_Mov_LocalDataTerminoBackup(ncodigo
    , database_name
    , backup_finish_date
    , physical_device_name)
	Select @nCliente As ncodigo
	, bs.database_name
	, bs.backup_finish_date
	, bmf.physical_device_name
    From msdb.dbo.backupmediafamily bmf (NoLock)
    Inner Join msdb.dbo.backupset bs (NoLock) 
    On bmf.media_set_id = bs.media_set_id
    Inner Join #tmp_ultimo_backup ub 
    On ub.database_name = bs.database_name 
    And ub.backup_finish_date = bs.backup_finish_date
    Where Convert(VarChar, @nCliente) Collate SQL_Latin1_General_CP1_CI_AS + '_' + Convert(VarChar,bs.database_name) Collate SQL_Latin1_General_CP1_CI_AS + '_' + Convert(VarChar, bs.backup_finish_date,112) Collate SQL_Latin1_General_CP1_CI_AS  + Convert(VarChar, bs.backup_finish_date,108) Collate SQL_Latin1_General_CP1_CI_AS
    Not In
		(Select Convert(VarChar, ncodigo) Collate SQL_Latin1_General_CP1_CI_AS + '_' + Convert(VarChar, database_name) Collate SQL_Latin1_General_CP1_CI_AS + '_' + Convert(VarChar,backup_finish_date,112) Collate SQL_Latin1_General_CP1_CI_AS + Convert(VarChar,backup_finish_date,108) Collate SQL_Latin1_General_CP1_CI_AS
         From [200.158.216.85].monitordba.dbo.Tb_Mon_Mov_LocalDataTerminoBackup
         Where ncodigo = @nCliente)
GO


EXEC master.dbo.sp_droplinkedsrvlogin @rmtsrvname= N'200.158.216.85', @locallogin = NULL

EXEC master.dbo.sp_dropserver @server = N'200.158.216.85'

EXEC master.dbo.sp_addlinkedserver @server = N'200.158.216.85', @srvproduct=N'', @provider=N'SQLNCLI', @datasrc=N'sql.capta.com.br'

EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'200.158.216.85',@useself=N'False',@locallogin=NULL,@rmtuser=N'monitor',@rmtpassword='ADf5d065#Adi'

EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'collation compatible', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'data access', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'dist', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'pub', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'rpc', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'rpc out', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'sub', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'connect timeout', @optvalue=N'0'
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'collation name', @optvalue=null
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'lazy schema validation', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'query timeout', @optvalue=N'0'
EXEC master.dbo.sp_serveroption @server=N'200.158.216.85', @optname=N'use remote collation', @optvalue=N'true'



