/********************************************************************************************************************************************************/
/*********************************************VERIFICACAO DE JOBS ATIVOS (AGENDAR JOB NO CLIENTE)**********************************************/
/********************************************************************************************************************************************************/

/*
--criar no 28.6
create table jobs_ativos
(
cod int,
data datetime,
job varchar(100),
server varchar(50),
[tempo_em_execucao (horas)] int
)
*/

use msdb
go

declare @cod int
set @cod = 999

select
distinct 
@cod as codcli,
getdate() as data,
j.name as job,
h.server, 
a.last_executed_step_date, 
a.next_scheduled_run_date, 
(((DATEPART(MINUTE,getdate())) - (DATEPART(MINUTE,a.start_execution_date))) +
	(((DATEPART(HOUR,getdate())) - (DATEPART(HOUR,a.start_execution_date)))/60) /60) as [tempo_em_execucao (horas)], 
a.stop_execution_date
into #jobs_ativos_tmp
from sysjobactivity a
left join sysjobhistory h on h.job_id = a.job_id
left join sysjobs j on j.job_id = a.job_id
where datediff(MINUTE,start_execution_date,getdate()) > 5
and start_execution_date is not null
and stop_execution_date is null
and a.start_execution_date in (select max(start_execution_date) from sysjobactivity a left join sysjobs j on j.job_id = a.job_id group by j.name)


if (select count(*) from #jobs_ativos_tmp) > 0

insert into [192.168.28.6].monitordba.dbo.jobs_ativos
select 
codcli,
data,
job,
server,
[tempo_em_execucao (horas)]
from #jobs_ativos_tmp

drop table #jobs_ativos_tmp

/********************************************************************************************************************************************************/
/************************************************TRATAMENTO PARA MANDAR EMAIL (AGENDAR JOB NO 28.6)******************************************************/
/********************************************************************************************************************************************************/

use monitordba
go

select j.cod, c.sNome, j.data, j.job, j.server, j.[tempo_em_execucao (horas)]
into #jobs_ativos_tmp
from jobs_ativos j
left join Tb_MON_Cad_Clientes c on c.ncodigo = j.cod and c.flgAtivo = 1
--order by 3 desc
go

DECLARE @TableHTML  VARCHAR(MAX)

SELECT 
	@TableHTML =   
	'</table> 
	<br>
	<br>
	<tr>
	<tr>
	 <table id="AutoNumber1" style="BORDER-COLLAPSE: collapse" borderColor="#111111" height="40" cellSpacing="0" cellPadding="0" width="933" border="1">
	  <tr>
		<td width="35%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Codigo</font></b></td>
		<td width="23%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Cliente</font></b></td>
		<td width="23%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Data</font></b></td>
		<td width="35%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Job</font></b></td>
		<td width="30%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Server</font></b></td>
		<td width="50%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Tempo em Execucao (Min)</font></b></td>
	  </tr>'


select 
@TableHTML =  @TableHTML + 
	'<tr><td><font face="Verdana" size="1">' + isnull(convert(varchar,cod), '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(snome, '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(convert(varchar,data), '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(job, '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(server, '') +'</font></td>'  +
'<td><font face="Verdana" size="1">' + isnull(convert(varchar,[tempo_em_execucao (horas)]), '') +'</font></td></tr>'
from #jobs_ativos_tmp

SELECT 
	@TableHTML =  @TableHTML + '</table>' +   
	'<p style="margin-top: 0; margin-bottom: 0">&nbsp;</p>
	<hr color="#000000" size="1">
	<p><font face="Verdana" size="2"><b>Responsável: sql.server@capta.com.br </font></p>  
	<p style="margin-top: 0; margin-bottom: 0"><font face="Verdana" size="2">Obrigado. []s,</font></p>  
	<p style="margin-top: 0; margin-bottom: 0"><font face="Verdana" size="2">DBA</font></p>  
	<p>&nbsp;</p>'  

	
--print @TableHTML

if (select count(*) from #jobs_ativos_tmp) > 0

EXEC msdb.dbo.sp_send_dbmail  
	@profile_name = 'captasql2',    
	@recipients='sql.server@capta.com.br',    
	@subject = 'Jobs Ativos - ALERTA!!!',    
	@body = @TableHTML,    
	@body_format = 'HTML' ;    

else

print 'Jobs OK'

truncate table jobs_ativos

drop table #jobs_ativos_tmp

