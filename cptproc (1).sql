--****************************************************************************************************************************
--Capta Processos
--****************************************************************************************************************************

declare @nr_processos int
set @nr_processos = isnull(
(
select
count(1)
from
master.dbo.sysprocesses p
inner join master.dbo.sysdatabases d on d.dbid = p.dbid and d.name like 'cptprocs%'
where
p.spid >= 50
)
,0)
print @nr_processos

if isnull(@nr_processos,0) = 0
begin
	insert into [200.158.216.85].monitordba.dbo.Tb_Mon_CadOcorrenciaProcessos values ( 33, getdate(), null )   
end
--****************************************************************************************************************************
--Capta Processos
--****************************************************************************************************************************


