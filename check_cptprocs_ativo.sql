select
COUNT(1)
from
SYS.DATABASES d 
 where d.name like '%cptproc%'
and STATE_DESC='ONLINE'
and DATABASE_ID not in (select dbid from master.dbo.sysprocesses where program_name like '%cptagend%')
