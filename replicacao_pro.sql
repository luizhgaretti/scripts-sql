if ISNULL( ( select COUNT(1) from [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor where ntipomonitor = 3 and dconclusao = CONVERT(varchar,getdate(),112) ),0) = 1
delete [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor where dconclusao >= CONVERT(varchar,getdate(),112) and ncliente = 73 and ntipomonitor =3 

--iguatemi -- cj...
insert into [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor
select
73
,3
,substring(convert(varchar,jh.run_date),1,4)+'-'+
substring(convert(varchar,jh.run_date),5,2)+'-'+
substring(convert(varchar,jh.run_date),7,2)+' '+
substring(right('000000'+convert(varchar,run_time),6),1,2)+':'+
substring(right('000000'+convert(varchar,run_time),6),3,2)+':'+
substring(right('000000'+convert(varchar,run_time),6),5,2)+'.000'
from
[sb1fsbfsp01].msdb.dbo.sysjobhistory jh
where
jh.job_id='C66F3E2E-CC1D-4E6F-A79C-8A50934BFABE'
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
ntipomonitor = 3
and dconclusao >= GETDATE()-16
)
--iguatemi -- cj...
go


--iguatemi -- brasilia...
if ISNULL( ( select COUNT(1) from [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor where ntipomonitor = 3 and dconclusao = CONVERT(varchar,getdate(),112) ),0) = 1
delete [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor where dconclusao >= CONVERT(varchar,getdate(),112) and ncliente = 523 and ntipomonitor =3 

insert into [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor
select
523
,3
,substring(convert(varchar,jh.run_date),1,4)+'-'+
substring(convert(varchar,jh.run_date),5,2)+'-'+
substring(convert(varchar,jh.run_date),7,2)+' '+
substring(right('000000'+convert(varchar,run_time),6),1,2)+':'+
substring(right('000000'+convert(varchar,run_time),6),3,2)+':'+
substring(right('000000'+convert(varchar,run_time),6),5,2)+'.000'
from
[sb1fsbfsp01].msdb.dbo.sysjobhistory jh
where
jh.job_id='FBD3BBAE-0868-4EC7-8945-00F2A41AAF9E'
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
ntipomonitor = 3
and dconclusao >= GETDATE()-16
)
--iguatemi - brasilia...
go

--iguatemi -- rj
if ISNULL( ( select COUNT(1) from [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor where ntipomonitor = 3 and dconclusao = CONVERT(varchar,getdate(),112) ),0) = 1
delete [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor where dconclusao >= CONVERT(varchar,getdate(),112) and ncliente = 600 and ntipomonitor =3 

insert into [200.158.216.85].monitordba.dbo.tb_mon_mov_indicadoresmonitor
select
600
,3
,substring(convert(varchar,jh.run_date),1,4)+'-'+
substring(convert(varchar,jh.run_date),5,2)+'-'+
substring(convert(varchar,jh.run_date),7,2)+' '+
substring(right('000000'+convert(varchar,run_time),6),1,2)+':'+
substring(right('000000'+convert(varchar,run_time),6),3,2)+':'+
substring(right('000000'+convert(varchar,run_time),6),5,2)+'.000'
from
[sb1fsbfsp01].msdb.dbo.sysjobhistory jh
where
jh.job_id='F25A3EEC-9ABF-47A7-9ECB-1E37AD1E6A86'
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
ntipomonitor = 3
and dconclusao >= GETDATE()-16
)
--iguatemi - rj
go
