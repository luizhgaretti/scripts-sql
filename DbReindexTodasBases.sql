use master
go

declare @nome_bd varchar (255) 
declare @comando varchar (8000)

declare c_tamanho_bd cursor local for select name from sysdatabases where isnull(version,0) <> 0 and name like 'LO%'
open c_tamanho_bd fetch next from c_tamanho_bd into @nome_bd

while @@fetch_status = 0
begin
  set @comando = 'use '+ @nome_bd + 
           ' declare @comando2 varchar(100)
 
             declare c_tables cursor local for select ''dbcc dbreindex (''''''+ name +'''''','''''''')'' from sys.tables
             open c_tables fetch next from c_tables into @comando2
             while @@fetch_status = 0
             begin
               exec (@comando2)
               fetch next from c_tables into @comando2
             end
             close c_tables
             deallocate c_tables
'


  exec (@comando)
  fetch next from c_tamanho_bd into @nome_bd
end
close c_tamanho_bd
deallocate c_tamanho_bd

