 /****************************************************************************************************************
																									CONFIGURAR NO SQLEXPRESS
****************************************************************************************************************/
/*
declare @cliente varchar(50)
set @cliente = 'CAPTA'

 insert into [200.158.216.85].monitordba.dbo.tb_monitor_cptagend
select
@cliente,
@@SERVERNAME,
count(1)
from
master.dbo.sysprocesses p
inner join master.dbo.sysdatabases d on d.dbid = p.dbid 
--and d.name like 'cptprocs%'
and p.program_name like '%cptagend.exe%'
where p.spid >= 50
*/

/****************************************************************************************************************
																									CONFIGURAR NO 28.6
****************************************************************************************************************/

/*
use monitordba
go

create table tb_monitor_cptagend
(
cliente varchar(50),
servername varchar (50),
nr_processos int
)
*/

DECLARE @DBProfile VARCHAR(100)
SELECT @DBProfile=Name FROM msdb.dbo.sysmail_profile WHERE Profile_ID=1

declare @string varchar(50)
select @string = 'Capta Processos Parado no Cliente' 

declare @string3 varchar(50)
set @string3 = 'Favor Verificar Urgente!!!'


declare @string2 varchar(800)
set @string2 =  ' Capta Processos parado no(s) Servidor(s): ' 
select @string2 =  @string2 + char(13) +  char(13) +
 '" '+ servername +  ' "' 
   from tb_monitor_cptagend 

   declare @string4 varchar(800)
   set @string4 = @string2 + char(13) + char(13) + @string3

   --print @string2 + char(13) + char(13) + @string3

--select @string2 + char(13) + char(13) + @string3

if exists (select nr_processos from tb_monitor_cptagend where nr_processos = 0) 

begin
	EXEC msdb.dbo.sp_send_dbmail  
	--@profile_name = 'captasql2',    
	@profile_name = @DBProfile,
	@recipients='nelson.hamilton@capta.com.br',    
	--@subject =  'Capta Processos Parado ',
	@subject = @string,
	--@body = 'Verificar os Processos!!!',    
	@body = @string4,   
	@body_format = 'text' ;   
end
go

--select * from tb_monitor_cptagend

--truncate table monitordba..tb_monitor_cptagend