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
