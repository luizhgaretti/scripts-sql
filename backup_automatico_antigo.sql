DECLARE @NOME_CLI VARCHAR(255)
SET @NOME_CLI = 'Corsage Center Norte'

DECLARE @COUNT INT, @INICIO INT
DECLARE @BackupFile varchar(255), @DB varchar(30), @Description varchar(255), @LogFile varchar(50)
DECLARE @Name varchar(30), @MediaName varchar(30), @BackupDirectory nvarchar(200)

SET @BackupDirectory = 'c:\Databases\Backup_Automatico\'

USE TEMPDB
IF EXISTS(SELECT * FROM TEMPDB..SYSOBJECTS WHERE NAME LIKE '%BANCOS')
BEGIN
	DROP TABLE ##BANCOS
END
SELECT NAME,DBID INTO ##BANCOS FROM MASTER..SYSDATABASES ORDER BY DBID

SET @INICIO = 1
SET @COUNT = (SELECT MAX(DBID) FROM ##BANCOS)
WHILE (@INICIO <= @COUNT)
BEGIN
	SET @DB = (SELECT NAME FROM ##BANCOS WHERE DBID = @INICIO)
	IF(@DB = 'MODEL' OR @DB = 'TEMPDB')
	BEGIN
		PRINT 'NÃO É REALIZADO BACKUP DO TEMPDB E DO MODEL'
	END
	ELSE
	BEGIN
		SET @Name = @DB + '( Backup Diário )'
		SET @MediaName = @DB + '_Dump' 
		SET @BackupFile = @BackupDirectory + + @DB + '_' + 'Full' + '.bak'	
		SET @Description = 'Backup Full' + ' feito às ' + CONVERT(VARCHAR(30),GETDATE())
		
		BEGIN TRY
			use master exec sp_killuser 'usuarios'
			use master exec sp_killuser 'captarmtdb'
			use master exec sp_killuser 'user'
			use master exec sp_killuser 'usuprocs'
		END TRY
		BEGIN CATCH
		END CATCH

		BEGIN TRY
			EXEC('USE '+ @DB + ' TRUNCATE TABLE CPTLIC')
			EXEC('USE '+ @DB + ' TRUNCATE TABLE cptgtmpd')
			EXEC('USE '+ @DB + ' TRUNCATE TABLE cptgtmpc')
			EXEC('USE '+ @DB + ' TRUNCATE TABLE cptgtmpr')
			EXEC('USE '+ @DB + ' TRUNCATE TABLE cptgtmpt')
			PRINT 'TABELAS TRUNCADAS'
		END TRY
		BEGIN CATCH
			PRINT 'ESTE BANCO NÃO TEM ESTAS TABLEAS'
		END CATCH

		BEGIN TRY
			
			EXEC('USE '+@DB + 'DBCC SHRINKFILE(2,1)')
		END TRY
		BEGIN CATCH
		END CATCH
		
		BEGIN TRY
			DBCC SHRINKDATABASE(@DB)
		END TRY
		BEGIN CATCH
		END CATCH
		
		BEGIN TRY
						BACKUP DATABASE @DB TO DISK = @BackupFile WITH INIT,
						NAME = @Name, DESCRIPTION = @Description ,
						MEDIANAME = @MediaName, MEDIADESCRIPTION = @Description ,
						STATS = 3
						insert into [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor values ( 33, 1, getdate())

				
						DECLARE @VERSAO VARCHAR(255)
						DECLARE @HOJE VARCHAR(20)
						DECLARE @CODIGO_SRV VARCHAR(100)
						DECLARE @EXECUTAR VARCHAR(8000)
						DECLARE @CONSULTA VARCHAR(7000)
						DECLARE @TIPO CHAR(3)
						DECLARE @FISICO_ARQ VARCHAR(8000)
						DECLARE @TAMANHO decimal(10,1)
						DECLARE @FILE INT
						SET @VERSAO = CASE	WHEN @@VERSION LIKE '%EXPRESS%' THEN 'EXPRESS'
											ELSE 'FULL' END
						SET @HOJE = CONVERT(VARCHAR(20),GETDATE())
						
							  BEGIN TRY
								drop table ##info_numero_datafiles
							  END TRY
							  BEGIN CATCH
							  END CATCH
							  Create Table ##info_numero_datafiles
							  (
									numero int
							  )

						insert into ##info_numero_datafiles(numero)
						exec('SELECT COUNT(*) FROM '+@db+'..SYSFILES')
						
						SET @FILE = (select numero from ##info_numero_datafiles)
						WHILE @FILE>0	
						BEGIN
							  BEGIN TRY
								drop table ##info_datafile
							  END TRY
							  BEGIN CATCH
							  END CATCH
							  Create Table ##info_datafile
							  (
									Filename varchar(255),
									tamanho decimal(10,1)
							  )
							  INSERT into ##info_datafile(filename,tamanho)
							  EXEC('SELECT FILENAME,CONVERT(decimal(10,1),SIZE)*8/1024 FROM '+@DB+'..SYSFILES WHERE FILEID = '+@FILE)

							  SET @FISICO_ARQ  = (SELECT FILENAME FROM ##info_datafile)
							  SET @TAMANHO = (SELECT TAMANHO FROM ##info_datafile)
							  SET @TIPO = (CASE        WHEN  @FISICO_ARQ LIKE '%LOG%' THEN 'LOG'
			   										   WHEN  @FISICO_ARQ LIKE '%MDF%' THEN 'DAT'
													   ELSE  '_?_'	 END)
							  SET @CODIGO_SRV = @NOME_CLI + '_' +  @@SERVERNAME + '_' + @VERSAO
							  SET @CONSULTA = 'EXEC USP_INSERE_SERVER '
							  SET @CONSULTA = @CONSULTA + '''' +   @NOME_CLI  + ''','
							  SET @CONSULTA = @CONSULTA + '''' +   CONVERT(VARCHAR(255),@CODIGO_SRV)  + ''','
							  SET @CONSULTA = @CONSULTA + '''' +   @@SERVERNAME + ''','
							  SET @CONSULTA = @CONSULTA + '''' +   @VERSAO      + ''','
							  SET @CONSULTA = @CONSULTA + '''' +   @DB			+ ''','
							  SET @CONSULTA = @CONSULTA + '''' +   @TIPO        + ''','
							  SET @CONSULTA = @CONSULTA + '' +   CONVERT(VARCHAR(10),@TAMANHO)     + ','
							  SET @CONSULTA = @CONSULTA + '''' +   @FISICO_ARQ  + ''','
							  SET @CONSULTA = @CONSULTA + '''' +   @BACKUPFILE  + ''','
							  SET @CONSULTA = @CONSULTA + '''' +   @HOJE        + ''','
							  SET @CONSULTA = @CONSULTA + ' 1'
							  SET @EXECUTAR = 'osql -S200.158.216.85 -d MONITORDBA -Q "'+@CONSULTA+'" -UMonitorDBA -PMonitorDBA'
							  EXEC	master..XP_CMDSHELL @EXECUTAR
							  SET @FILE = @FILE - 1		
						END
				END TRY
				BEGIN CATCH
				END CATCH
	
	
	END
	SET @INICIO = @INICIO + 1
END
--exec corsage_cidjardim.dbo.sp_dba_tamanhoarquivobd
--exec corsage_cidjardim.dbo.sp_dba_espacolivretotal

--create procedure sp_dba_localdataterminobackup
--as
declare @ncodigo int
set @ncodigo = 33

--drop table #ultimo_backup
select
bs.database_name
,max(bs.backup_finish_date) backup_finish_date
into #ultimo_backup
from
msdb.dbo.backupset bs (nolock) 
inner join master.dbo.sysdatabases db (nolock) on bs.database_name = db.name and isnull(db.version,0) <> 0
group by
bs.database_name



insert into [200.158.216.85].monitordba.dbo.Tb_Mon_Mov_LocalDataTerminoBackup
(
ncodigo, database_name, backup_finish_date, physical_device_name
)
select
@ncodigo
,bs.database_name
,bs.backup_finish_date
,bmf.physical_device_name
from
msdb.dbo.backupmediafamily bmf (nolock)
inner join msdb.dbo.backupset bs (nolock) on bmf.media_set_id = bs.media_set_id
inner join #ultimo_backup ub on ub.database_name = bs.database_name and ub.backup_finish_date = bs.backup_finish_date
where
CONVERT(varchar,@ncodigo) collate SQL_Latin1_General_CP1_CI_AS + '_' + CONVERT(varchar,bs.database_name) collate SQL_Latin1_General_CP1_CI_AS + '_' + convert(varchar,bs.backup_finish_date,112) collate SQL_Latin1_General_CP1_CI_AS +convert(varchar,bs.backup_finish_date,108) collate SQL_Latin1_General_CP1_CI_AS
not in
(
select
CONVERT(varchar,ncodigo) collate SQL_Latin1_General_CP1_CI_AS + '_' + CONVERT(varchar,database_name) collate SQL_Latin1_General_CP1_CI_AS + '_' + convert(varchar,backup_finish_date,112) collate SQL_Latin1_General_CP1_CI_AS +convert(varchar,backup_finish_date,108) collate SQL_Latin1_General_CP1_CI_AS
from
[200.158.216.85].monitordba.dbo.Tb_Mon_Mov_LocalDataTerminoBackup
where
ncodigo = @ncodigo
)



