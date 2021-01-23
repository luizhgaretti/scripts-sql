use uoldiveodb
go

/****** Object:  StoredProcedure [dbo].[usp_zabbix_job_status_ultima_execucao_backup_log]    Script Date: 07/12/2013 19:05:44 ******/
if exists (select * from sysobjects where id = OBJECT_ID(N'[dbo].[usp_zabbix_job_status_ultima_execucao_backup_log]') and xtype in (N'P', N'PC'))
drop procedure [dbo].[usp_zabbix_job_status_ultima_execucao_backup_log]
go

create procedure [dbo].[usp_zabbix_job_status_ultima_execucao_backup_log]
as

 begin

   if exists (select id_job_execution      
              from 
              dbo.uoldiveo_job_monitor 
              where job_name = 'UOLDIVEO: Backup Log'
              and   status_last_execution='Falha'
              and   id_job_execution in(select max(id_job_execution) from dbo.uoldiveo_job_monitor where job_name = 'UOLDIVEO: Backup Log'))

begin
select 1 as Valor ---Existem erros na última execução do job do backup log
end

else 
select 0 as Valor ---Não existem erros na última execução do job do backup log

end





GO


