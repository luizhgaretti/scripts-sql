declare @spid int
declare @db_name varchar(100)
set @db_name = ‘NomeDaBase’ – coloque o nome da base aqui

declare spid cursor for

select spid
from master.dbo.sysprocesses(nolock)
where dbid = db_id(@db_name) and spid > 50
union
select distinct request_session_id
from sys.dm_tran_locks (nolock)
where resource_database_id = db_id(@db_name) and request_session_id > 50
open spid

fetch next from spid into @spid

while @@fetch_status = 0
begin
exec (‘kill ‘ + @spid)
fetch next from spid into @spid
end

 

close spid
deallocate spid







USE @db_name
GO

ALTER DATABASE @db_name SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

Não se esqueça de, depois do seu procedimento, voltar a base para MULTI_USER:

ALTER DATABASE @db_name SET MULTI_USER
GO