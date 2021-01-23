/****************************************deleta_backups****************************************/

-- exclusao do historico de backup em dias...

--drop table #tb_bd_bancoshist
create table #tb_bd_bancoshist
(
nOrdem int not null identity(1,1)
,cComando varchar(100) null
)

declare @dias_filtro Int
declare @dias_historico Int 

declare @sql2 varchar(400)
insert into #tb_bd_bancoshist (cComando)
select
name
from
sys.databases
order by name

declare @nOrdem int
set @nOrdem = isnull( ( select isnull(MIN(nOrdem),1) from #tb_bd_bancoshist ),1)

declare @dt_historico datetime


declare @bd varchar(100)


while @nOrdem <= isnull( ( select isnull(MAX(nOrdem),1) from #tb_bd_bancoshist ),1)
begin
	set @dt_historico = GETDATE() - 30
	while @dt_historico <= GETDATE() - 4
	begin
		set @bd = ISNULL( ( select cComando from #tb_bd_bancoshist where nOrdem = @nOrdem ),'')
		set @sql2 = 'EXEC master.dbo.xp_cmdshell ' + char(39) + 'del d:\databases\backup_mensal\' + @bd + '\' + @bd + '_backup_' + convert(varchar,datepart(yyyy,@dt_historico)) + '_' + right('00'+convert(varchar,datepart(mm,@dt_historico)),2)+ '_' + right('00'+convert(varchar,datepart(dd,@dt_historico)),2) + '_*.bak' + char(39) + ', NO_OUTPUT'
		exec(@sql2)
		
		set @dt_historico = @dt_historico + 1
	end
	set @nOrdem = @nOrdem + 1	
end
go


/****************************************cria diretorios****************************************/
USE [master]
GO

DECLARE  @CAMINHO VARCHAR(8000), @SSQL VARCHAR(8000)

/*-a variavel @caminho é para armazenar o caminho que vai ser usado para criar as pastas
  -a variavel @ssql é para armazenar o camando para ser executado automaticamente pelo cursor	
  -cbkp é o cursor que esta o transact do select
*/

DECLARE CBKP CURSOR STATIC FOR 

select '''d:\databases\backup_mensal\' +name+ ''''
from sys.databases
where name not in ('northwind','pubs','tempdb', 'adventureworks', 'adventureworksdw',
					'ReportServer', 'ReportServerTempDB') and  state_desc = 'ONLINE'

OPEN CBKP
	FETCH NEXT FROM CBKP INTO @CAMINHO
	WHILE  @@Fetch_Status = 0
	BEGIN
	
	SET @SSQL = 'exec master.dbo.xp_create_subdir' + @CAMINHO
	
	EXECUTE (@SSQL)
		PRINT (@SSQL)
	FETCH NEXT FROM CBKP INTO @CAMINHO
END -- FIM DO WHILE

	CLOSE CBKP
	DEALLOCATE CBKP
	GO


/****************************************faz backups full****************************************/

DECLARE  @BASE varchar(8000),@CAMINHO VARCHAR(8000), @SSQL VARCHAR(8000)

/*-a variavel @caminho é para armazenar o caminho que vai ser usado para criar as pastas
  -a variavel @ssql é para armazenar o camando para ser executado automaticamente pelo cursor	
  -a variavel @base é para armazenar a base a ser feito o backup 
  -cbkp é o cursor que esta o transact do select
*/

DECLARE CBKP CURSOR STATIC FOR 

SELECT   name 
 , + CHAR(39) + 
		'd:\databases\backup_mensal\' + name + '\' + name + '_BACKUP_' + replace(convert(varchar(20),getdate(), 102), '.', '_') + '_.bak' + CHAR(39)
from sys.databases
where name not in ('northwind','pubs','tempdb', 'adventureworks', 'adventureworksdw',
					'ReportServer', 'ReportServerTempDB') and  state_desc = 'ONLINE'

OPEN CBKP
	FETCH NEXT FROM CBKP INTO @BASE, @CAMINHO
	WHILE  @@Fetch_Status = 0
	BEGIN
		SET @SSQL = 'BACKUP DATABASE ' + @BASE + ' TO DISK = ' + @CAMINHO + 
		' WITH NOFORMAT, INIT, SKIP, REWIND, NOUNLOAD, COMPRESSION '
		--' WITH NOFORMAT, INIT, SKIP, REWIND, NOUNLOAD '
		EXECUTE (@SSQL)
		--PRINT (@SSQL)
	FETCH NEXT FROM CBKP INTO  @BASE, @CAMINHO
	END -- FIM DO WHILE

	CLOSE CBKP
	DEALLOCATE CBKP
	GO
	
	
	/****************************************faz monitoramento****************************************/


	Declare @nCliente int
	set @nCliente = 999
	Insert Into [200.158.216.85].[MonitorDBA].[dbo].[Tb_MON_Mov_IndicadoresMonitor] 
				(nCliente, nTipoMonitor, dConclusao )
			Values (@nCliente, 1, getdate())

	If Object_Id ('tempdb..#tmp_ultimo_backup') > 0 Drop Table #tmp_ultimo_backup

	Select bs.database_name, max(bs.backup_finish_date) backup_finish_date
		Into #tmp_ultimo_backup
		From msdb.dbo.backupset bs (NoLock) 
			Inner Join master.dbo.sysdatabases db (NoLock) On bs.database_name Collate SQL_Latin1_General_CP1_CI_AS = db.name And IsNull(db.Version, 0) <> 0
		Group By bs.database_name;

	Insert Into [200.158.216.85].monitordba.dbo.Tb_Mon_Mov_LocalDataTerminoBackup
				(ncodigo, database_name, backup_finish_date, physical_device_name)
			Select @nCliente As ncodigo, bs.database_name, bs.backup_finish_date, bmf.physical_device_name
				From msdb.dbo.backupmediafamily bmf (NoLock)
					Inner Join msdb.dbo.backupset bs (NoLock) On bmf.media_set_id = bs.media_set_id
					Inner Join #tmp_ultimo_backup ub On ub.database_name = bs.database_name And ub.backup_finish_date = bs.backup_finish_date
				Where Convert(VarChar, @nCliente) Collate SQL_Latin1_General_CP1_CI_AS + '_' + Convert(VarChar,bs.database_name) Collate SQL_Latin1_General_CP1_CI_AS + '_' + Convert(VarChar, bs.backup_finish_date,112) Collate SQL_Latin1_General_CP1_CI_AS  + Convert(VarChar, bs.backup_finish_date,108) Collate SQL_Latin1_General_CP1_CI_AS
						Not In
						(Select Convert(VarChar, ncodigo) Collate SQL_Latin1_General_CP1_CI_AS + '_' + Convert(VarChar, database_name) Collate SQL_Latin1_General_CP1_CI_AS + '_' + Convert(VarChar,backup_finish_date,112) Collate SQL_Latin1_General_CP1_CI_AS + Convert(VarChar,backup_finish_date,108) Collate SQL_Latin1_General_CP1_CI_AS
							From [200.158.216.85].monitordba.dbo.Tb_Mon_Mov_LocalDataTerminoBackup
							Where ncodigo = @nCliente)

