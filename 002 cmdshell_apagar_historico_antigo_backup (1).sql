
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
	while @dt_historico <= GETDATE()- 4
	begin
		set @bd = ISNULL( ( select cComando from #tb_bd_bancoshist where nOrdem = @nOrdem ),'')
		set @sql2 = 'EXEC master.dbo.xp_cmdshell ' + char(39) + 'del d:\databases\backup_historico\' + @bd + '\' + @bd + '_backup_' + convert(varchar,datepart(yyyy,@dt_historico)) + '_' + right('00'+convert(varchar,datepart(mm,@dt_historico)),2)+ '_' + right('00'+convert(varchar,datepart(dd,@dt_historico)),2) + '_*.bak' + char(39) + ', NO_OUTPUT'
		exec(@sql2)
		
		set @dt_historico = @dt_historico + 1
	end
	set @nOrdem = @nOrdem + 1	
end



