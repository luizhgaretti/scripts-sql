use master
go
create table #tmp_tamanho_BD
(
  nome varchar (255),
  tamanho_mdf float,
  tamanho_ldf float    
)
go

declare @nome_bd varchar (255) 
declare @comando varchar (8000)
declare c_tamanho_bd cursor local for select name from sysdatabases where isnull(version,0) <> 0
open c_tamanho_bd fetch next from c_tamanho_bd into @nome_bd

while @@fetch_status = 0
begin
  set @comando = 'use '+ @nome_bd + 
           ' declare @size_mdf float
             declare @size_ldf float
             select @size_mdf = (size * 8) / 1024 from sysfiles where fileid = 1 
             select @size_ldf = (size * 8) / 1024 from sysfiles where fileid = 2

             insert into master..#tmp_tamanho_BD values 
             (db_name(),@size_mdf, @size_ldf)'

  execute (@comando)
  fetch next from c_tamanho_bd into @nome_bd
end
close c_tamanho_bd
deallocate c_tamanho_bd

select * from #tmp_tamanho_BD order by 2 desc

select 
  sum(tamanho_mdf) total_mdf,
  sum(tamanho_ldf) total_ldf,
  sum(tamanho_mdf) + sum(tamanho_ldf)
from #tmp_tamanho_BD 

drop table #tmp_tamanho_BD

--select (size * 8) / 1024, * from sysfiles

