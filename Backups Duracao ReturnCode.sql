use msdb
go

declare @stmt nvarchar(2000),
		@collation_tempdb varchar(50)

/***********************************************************************************************
			Retorna início, término, duração dos backups realizados e return code
			das 18:00 do dia anterior às 08:00 do dia atual, por banco.
			Return code:
				0 -> backup realizado
				1 -> backup não realizado
***********************************************************************************************/



-- Obtendo collation do tempdb, para não dar problema na comparação entre os campos data tabela temporária e os da t4b_procadm_param
CREATE TABLE #Collation (
	coll varchar(50)
)

IF NOT REPLACE(@@VERSION, '  ', ' ') LIKE 'Microsoft SQL Server 7%'
BEGIN
	insert into #Collation (coll)
	exec('SELECT CONVERT(varchar, DATABASEPROPERTYEX(''tempdb'', ''Collation''))')
END

SELECT @collation_tempdb = ISNULL(coll, '') FROM #Collation

DROP TABLE #Collation

create table #bkpTemp (
	database_name varchar(128),
	backup_start_date datetime,
	backup_finish_date datetime,
	duracao varchar(20),
	returnCode int
)

-- Insere na tabela temporária os registros dos bancos dos quais foram realizados backups no
-- período estipulado:
insert into #bkpTemp
	select
		database_name,
		backup_start_date,
		backup_finish_date,
		REPLICATE('0', 2 - LEN(CONVERT(varchar, DATEDIFF(HOUR, backup_start_date, backup_finish_date)))) + 
			CONVERT(varchar, DATEDIFF(HOUR, backup_start_date, backup_finish_date)) + ':' + 
		REPLICATE('0', 2 - LEN(CONVERT(varchar, DATEDIFF(MINUTE, backup_start_date, backup_finish_date) % 60))) + 
			CONVERT(varchar, DATEDIFF(MINUTE, backup_start_date, backup_finish_date) % 60) + ':' +
		REPLICATE('0', 2 - LEN(CONVERT(varchar, DATEDIFF(SECOND, backup_start_date, backup_finish_date) % 60))) +
			CONVERT(varchar, DATEDIFF(SECOND, backup_start_date, backup_finish_date) % 60) as duracao,
		0 as returnCode
	from backupset 
	where type = 'D'
		and backup_start_date between
			DATEADD(HOUR, -6, CONVERT(datetime, CONVERT(varchar(12), getdate()))) and 
			DATEADD(HOUR, 8, CONVERT(datetime, CONVERT(varchar(12), getdate())))
	order by backup_start_date desc

IF NOT REPLACE(@@VERSION, '  ', ' ') LIKE 'Microsoft SQL Server 7%'
BEGIN
	set @stmt = '
	select sd.name, 1
	from master..sysdatabases sd
	left join #bkpTemp bkp on bkp.database_name = sd.name COLLATE ' + @collation_tempdb + '
	where bkp.database_name is null
		and sd.name != ''tempdb'''
END
ELSE
BEGIN
	set @stmt = '
	select sd.name, 1
	from master..sysdatabases sd
	left join #bkpTemp bkp on bkp.database_name = sd.name
	where bkp.database_name is null
		and sd.name != ''tempdb'''
END

-- Insere na tabela temporária os registros dos bancos dos quais não foram realizados backups
-- no período estipulado, com returnCode = 1:
insert into #bkpTemp (database_name, returnCode)
	exec(@stmt)
	
select * from #bkpTemp
order by database_name

drop table #bkpTemp