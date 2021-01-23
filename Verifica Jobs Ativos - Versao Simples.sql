use msdb
go

select
distinct 
j.name as job,
h.server, 
a.last_executed_step_date, 
a.next_scheduled_run_date, 
(((DATEPART(MINUTE,getdate())) - (DATEPART(MINUTE,a.start_execution_date))) +
	(((DATEPART(HOUR,getdate())) - (DATEPART(HOUR,a.start_execution_date)))/60) /60) as [tempo_em_execucao (horas)], 
a.stop_execution_date
into #jobs_ativos
from sysjobactivity a
left join sysjobhistory h on h.job_id = a.job_id
left join sysjobs j on j.job_id = a.job_id
where datediff(MINUTE,start_execution_date,getdate()) > 5
and start_execution_date is not null
and stop_execution_date is null
and a.start_execution_date in (select max(start_execution_date) from sysjobactivity a left join sysjobs j on j.job_id = a.job_id group by j.name)


if (select count(*) from #jobs_ativos) > 0

select 
job,
server,
[tempo_em_execucao (horas)]
from #jobs_ativos

drop table #jobs_ativos