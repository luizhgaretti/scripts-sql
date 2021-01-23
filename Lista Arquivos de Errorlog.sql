declare @datIni datetime,
		@datFin datetime,
		@arc int

create table #errorlog (
	ldate datetime,
	pinfo varchar(50),
	ltext nvarchar(2000)
)


-- Primeiro usar sp_enumerrorlogs para determinar o arquivo de log em que será realizada a busca:
exec sp_enumerrorlogs

-- Depois, indicar o arquivo e as datas inicial e final:
set @arc = 0
set @datIni = '2010-01-01 00:00'
set @datFin = '2010-02-04 17:00'

-- Inserção do log na tabela temporária.
insert into #errorlog
	exec sp_readerrorlog @arc

-- Query realizada na tabela temporária, de acordo com as datas.
select * from #errorlog
where ldate between @datIni and @datFin
	and ltext like '%fail%'			-- aqui é realizada mais uma filtragem, para buscar
									-- por uma mensagem específica.
order by ldate desc

drop table #errorlog
