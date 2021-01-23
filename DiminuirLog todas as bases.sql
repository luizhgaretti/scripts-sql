use master

go

declare @nome_bd varchar (255) 
declare @comando varchar (8000)
declare @recovery varchar (255)
declare c_tamanho_bd cursor local for select name from sysdatabases where isnull(version,0) <> 0
and name NOT IN ('TEMPDB','MODEL','MSDB','MASTER','ReportServerTempDB')
open c_tamanho_bd fetch next from c_tamanho_bd into @nome_bd

while @@fetch_status = 0
begin
  set @comando = 'use '+ @nome_bd + 
           ' declare @name_ldf varchar (255)
             declare @comando2 varchar (8000)

             select @name_ldf = rtrim(name) from sysfiles where fileid = 2
             
             set @comando2 = ''dbcc shrinkfile ('''''' + @name_ldf + '''''',0)''
             exec (@comando2)
           '            
   set @recovery = 'ALTER DATABASE ' + @nome_bd + ' SET RECOVERY SIMPLE'
  
  exec (@RECOVERY)	
  exec (@comando)
  
  set @recovery = 'ALTER DATABASE ' + @nome_bd + ' SET RECOVERY FULL'
  
  exec (@RECOVERY)	
  
  fetch next from c_tamanho_bd into @nome_bd
end
close c_tamanho_bd
deallocate c_tamanho_bd


--select (size * 8) / 1024, * from sysfiles