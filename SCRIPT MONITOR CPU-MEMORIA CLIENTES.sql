/*
use monitordba
go

--drop table Tb_MON_Mem_CPU

create table Tb_MON_Mem_CPU
(
codcli int,
--nomecli varchar(100),
servidor varchar(100),
cpu int,
memoria int,
data datetime,
banco varchar(100),
tamanhobd decimal(18,4)
)
*/

declare @codcli int
set @codcli = 2

if exists (select codcli from [200.158.216.85].monitordba.dbo.Tb_MON_Mem_CPU where codcli = @codcli)

update [200.158.216.85].monitordba.dbo.Tb_MON_Mem_CPU
set a.cpu = b.cpu_count, a.memoria = ((b.physical_memory_in_bytes/1024)/1024/1024 + 1), a.data = getdate()
from [200.158.216.85].monitordba.dbo.Tb_MON_Mem_CPU a
join sys.dm_os_sys_info b on a.servidor = (select @@servername) and a.codcli = @codcli

else

insert into [200.158.216.85].monitordba.dbo.Tb_MON_Mem_CPU

select @codcli as cod_cli, (select @@servername) as servidor, cpu_count as cpus, ((physical_memory_in_bytes/1024)/1024/1024 + 1) as memoria_gb, getdate()
from sys.dm_os_sys_info

/**************************************************************************************************************************************************/

select mc.codcli, c.snome as nome_cli, mc.servidor, mc.cpu, mc.memoria, convert(decimal(18,1),sum(bd.tamanho_mb/1024)) as tamanho_total_bd_GB, mc.data as data
into #tb_mon_mem_cpu_tmp
from monitordba..Tb_MON_Mem_CPU mc
join monitordba..Tb_MON_Cad_Clientes c on mc.codcli = c.ncodigo
join monitordba..Tb_MON_Mov_TamanhoBDClientes bd on mc.codcli = bd.ncliente
where convert(varchar,bd.dt_historico, 112) = convert(varchar,getdate(), 112) -1
group by mc.codcli, c.snome, mc.servidor, mc.cpu, mc.memoria, mc.data


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
		<td width="10%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Codigo</font></b></td>
		<td width="18%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Cliente</font></b></td>
		<td width="18%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Servidor</font></b></td>
		<td width="18%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">QTD CPU (Nucleos)</font></b></td>
		<td width="10%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">QTD Mem GB</font></b></td>
		<td width="15%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Tamanho Total DBs GB</font></b></td>
		<td width="25%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Data</font></b></td>
		 </tr>'


select 
@TableHTML =  @TableHTML + 
	'<tr><td><font face="Verdana" size="1">' + isnull(convert(varchar,codcli), '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(convert(varchar,nome_cli), '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(convert(varchar,servidor), '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(convert(varchar,cpu), '') +'</font></td>' +
'<td><font face="Verdana" size="1">' + isnull(convert(varchar,memoria), '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(convert(varchar,tamanho_total_bd_GB), '') +'</font></td>' +
'<td><font face="Verdana" size="1">' + isnull(convert(varchar,data), '') +'</font></td>
	</tr>'  
from #tb_mon_mem_cpu_tmp

SELECT 
	@TableHTML =  @TableHTML + '</table>' +   
	'<p style="margin-top: 0; margin-bottom: 0">&nbsp;</p>
	<hr color="#000000" size="1">
	<p><font face="Verdana" size="2"><b>Responsável: sql.server@capta.com.br </font></p>  
	<p style="margin-top: 0; margin-bottom: 0"><font face="Verdana" size="2">Obrigado. []s,</font></p>  
	<p style="margin-top: 0; margin-bottom: 0"><font face="Verdana" size="2">DBA</font></p>  
	<p>&nbsp;</p>'  

	
--print @TableHTML

--if (select count(cod) from #Tb_MON_Integridade_Backup_Erro_Final) > 0

EXEC msdb.dbo.sp_send_dbmail  
	@profile_name = 'captasql2',    
	@recipients='nelson.hamilton@capta.com.br',    
	@subject = 'CPU / MEMÓRIA SERVIDORES',    
	@body = @TableHTML,    
	@body_format = 'HTML' ;    

/*
else

print 'Backups OK'
*/

--truncate table Tb_MON_Mem_CPU

drop table #tb_mon_mem_cpu_tmp


