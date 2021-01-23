--select * from msdb.dbo.sysjobs where name='SB1FSBFSP01-tiffanybr-tiffanybr-ti1FSBFSP01-24'
if ISNULL( ( select COUNT(1) from [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor where ntipomonitor = 2 and dconclusao = CONVERT(varchar,getdate(),112) ),0) = 1
delete [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor where dconclusao >= CONVERT(varchar,getdate(),112) and ncliente = 73 and ntipomonitor =2 

--iguatemi -- cj...
insert into [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor
select
73
,2
,substring(convert(varchar,jh.run_date),1,4)+'-'+
substring(convert(varchar,jh.run_date),5,2)+'-'+
substring(convert(varchar,jh.run_date),7,2)+' '+
substring(right('000000'+convert(varchar,run_time),6),1,2)+':'+
substring(right('000000'+convert(varchar,run_time),6),3,2)+':'+
substring(right('000000'+convert(varchar,run_time),6),5,2)+'.000'
from
[sb1fsbfsp01].msdb.dbo.sysjobhistory jh
where
jh.job_id='B85F181D-37F8-4C79-9768-FCD4212DA05D'
and jh.step_id = 0
and jh.run_status = 1
and substring(convert(varchar,jh.run_date),1,4)+'-'+
substring(convert(varchar,jh.run_date),5,2)+'-'+
substring(convert(varchar,jh.run_date),7,2)+' '+
substring(right('0'+convert(varchar,run_time),6),1,2)+':'+
substring(right('0'+convert(varchar,run_time),6),3,2)+':'+
substring(right('0'+convert(varchar,run_time),6),5,2)+'.000' + '_73_2'
not in
(
select
substring(convert(varchar,dconclusao,112),1,4)
+
'-'
+
substring(convert(varchar,dconclusao,112),5,2)
+
'-'
+
substring(convert(varchar,dconclusao,112),7,2)
+
' ' 
+
convert(varchar,dconclusao,108)+'.000'
+ '_' + CONVERT(varchar,ncliente) + '_2'
from
[200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor
where
ntipomonitor = 2
and dconclusao >= GETDATE()-16
)
--iguatemi -- cj...
go


--iguatemi -- brasilia...
if ISNULL( ( select COUNT(1) from [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor where ntipomonitor = 2 and dconclusao = CONVERT(varchar,getdate(),112) ),0) = 1
delete [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor where dconclusao >= CONVERT(varchar,getdate(),112) and ncliente = 523 and ntipomonitor =2 

insert into [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor
select
523
,2
,substring(convert(varchar,jh.run_date),1,4)+'-'+
substring(convert(varchar,jh.run_date),5,2)+'-'+
substring(convert(varchar,jh.run_date),7,2)+' '+
substring(right('000000'+convert(varchar,run_time),6),1,2)+':'+
substring(right('000000'+convert(varchar,run_time),6),3,2)+':'+
substring(right('000000'+convert(varchar,run_time),6),5,2)+'.000'
from
[sb1fsbfsp01].msdb.dbo.sysjobhistory jh
where
jh.job_id='050B9693-7938-4D8A-9219-80D04FC983FB'
and jh.step_id = 0
and jh.run_status = 1
and substring(convert(varchar,jh.run_date),1,4)+'-'+
substring(convert(varchar,jh.run_date),5,2)+'-'+
substring(convert(varchar,jh.run_date),7,2)+' '+
substring(right('0'+convert(varchar,run_time),6),1,2)+':'+
substring(right('0'+convert(varchar,run_time),6),3,2)+':'+
substring(right('0'+convert(varchar,run_time),6),5,2)+'.000' + '_523_2'
not in
(
select
substring(convert(varchar,dconclusao,112),1,4)
+
'-'
+
substring(convert(varchar,dconclusao,112),5,2)
+
'-'
+
substring(convert(varchar,dconclusao,112),7,2)
+
' ' 
+
convert(varchar,dconclusao,108)+'.000'
+ '_' + CONVERT(varchar,ncliente) + '_2'
from
[200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor
where
ntipomonitor = 2
and dconclusao >= GETDATE()-16
)
--iguatemi - brasilia...
go

--iguatemi -- rj
if ISNULL( ( select COUNT(1) from [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor where ntipomonitor = 2 and dconclusao = CONVERT(varchar,getdate(),112) ),0) = 1
delete [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor where dconclusao >= CONVERT(varchar,getdate(),112) and ncliente = 600 and ntipomonitor =2 

insert into [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor
select
600
,2
,substring(convert(varchar,jh.run_date),1,4)+'-'+
substring(convert(varchar,jh.run_date),5,2)+'-'+
substring(convert(varchar,jh.run_date),7,2)+' '+
substring(right('000000'+convert(varchar,run_time),6),1,2)+':'+
substring(right('000000'+convert(varchar,run_time),6),3,2)+':'+
substring(right('000000'+convert(varchar,run_time),6),5,2)+'.000'
from
[sb1fsbfsp01].msdb.dbo.sysjobhistory jh
where
jh.job_id='1AFE2E0E-275E-45FD-B0FB-DC08EB4F56E8'
and jh.step_id = 0
and jh.run_status = 1
and substring(convert(varchar,jh.run_date),1,4)+'-'+
substring(convert(varchar,jh.run_date),5,2)+'-'+
substring(convert(varchar,jh.run_date),7,2)+' '+
substring(right('0'+convert(varchar,run_time),6),1,2)+':'+
substring(right('0'+convert(varchar,run_time),6),3,2)+':'+
substring(right('0'+convert(varchar,run_time),6),5,2)+'.000' + '_600_2'
not in
(
select
substring(convert(varchar,dconclusao,112),1,4)
+
'-'
+
substring(convert(varchar,dconclusao,112),5,2)
+
'-'
+
substring(convert(varchar,dconclusao,112),7,2)
+
' ' 
+
convert(varchar,dconclusao,108)+'.000'
+ '_' + CONVERT(varchar,ncliente) + '_2'
from
[200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor
where
ntipomonitor = 2
and dconclusao >= GETDATE()-16
)
--iguatemi - rj
go

--iguatemi
insert into [200.158.216.85].monitordba.dbo.Tb_MON_MovEspacoLivreHDClientes
select 
* 
from 
[sb1fsbfsp01].dba.dbo.Tb_MON_MovEspacoLivreHDClientes
where
dt_historico > isnull(
(
select
MAX(dt_historico)
from
[200.158.216.85].monitordba.dbo.Tb_MON_MovEspacoLivreHDClientes
where
codcli = 73
)
,'20100101'
)
--iguatemi



--cidade jardim
insert into [200.158.216.85].monitordba.dbo.Tb_MON_MovEspacoLivreHDClientes
select 
* 
from 
[ti1fsbfsp01].dba.dbo.Tb_MON_MovEspacoLivreHDClientes
where
dt_historico > isnull(
(
select
MAX(dt_historico)
from
[200.158.216.85].monitordba.dbo.Tb_MON_MovEspacoLivreHDClientes
where
codcli = 72
)
,'20100101'
)
--cidade jardim

--brasilia
insert into [200.158.216.85].monitordba.dbo.Tb_MON_MovEspacoLivreHDClientes
select 
* 
from 
[ln1asposp01].dba.dbo.Tb_MON_MovEspacoLivreHDClientes
where
dt_historico > isnull(
(
select
MAX(dt_historico)
from
[200.158.216.85].monitordba.dbo.Tb_MON_MovEspacoLivreHDClientes
where
codcli = 523
)
,'20100101'
)
--brasilia

--rj
insert into [200.158.216.85].monitordba.dbo.Tb_MON_MovEspacoLivreHDClientes
select 
* 
from 
[rj1asposp01].dba.dbo.Tb_MON_MovEspacoLivreHDClientes
where
dt_historico > isnull(
(
select
MAX(dt_historico)
from
[200.158.216.85].monitordba.dbo.Tb_MON_MovEspacoLivreHDClientes
where
codcli = 600
)
,'20100101'
)
--rj
