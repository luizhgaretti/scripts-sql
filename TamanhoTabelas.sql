create table #tmp_tamanho_tabelas
(
  nome varchar (255),
  qtd_linhas int,
  tamanho_total varchar(20),
  tamanho_dados varchar(20),
  tamanho_indices varchar(20),    
  tamanho_naousado varchar(20)    
)
go

declare @nome_tabela varchar (255) 
declare @comando varchar (8000)
declare c_tamanho_tabela cursor local for select name from sysobjects where xtype = 'U'
open c_tamanho_tabela fetch next from c_tamanho_tabela into @nome_tabela

while @@fetch_status = 0
begin
  set @comando = 'insert into #tmp_tamanho_tabelas exec(''sp_spaceused '+ @nome_tabela + ''')'

  exec (@comando)
  fetch next from c_tamanho_tabela into @nome_tabela
end
close c_tamanho_tabela
deallocate c_tamanho_tabela

select * from #tmp_tamanho_tabelas 
order by cast(substring(tamanho_total,1,charindex(' k',tamanho_total)) as int) desc

select sum(cast(substring(tamanho_total,1,charindex(' k',tamanho_total)) as int)) total
from #tmp_tamanho_tabelas 

drop table #tmp_tamanho_tabelas

--select (size * 8) / 1024, * from sysfiles