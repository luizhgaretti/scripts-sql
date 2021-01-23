alter procedure [dbo].[SP_MON_SEL_ReplicacaoParadaTiffany_PRO]

as

declare @ultima_replicacao datetime

set @ultima_replicacao = ( select MAX(i.dConclusao) from Tb_MON_Mov_IndicadoresMonitor i where i.nCliente = 73 and i.nTipoMonitor = 3 ) --tipo 3 é replicação do PRO

print datediff(minute,@ultima_replicacao, getdate())

if datediff(minute,@ultima_replicacao, getdate()) > 30

begin

 declare @TableHTML varchar(max)

 	SET @TableHTML =    
	'<font face="Verdana" size="4">Replicação Parada/Em execução Tiffany</font>  
	
	<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#111111" width="16%" id="AutoNumber1" height="50">  
		<tr>  
		
	<td width="33%" height="22" bgcolor="#000080"><b>  
	
	<font face="Verdana" size="2" color="#FFFFFF">Codigo</font></b></td>  
	
	<td width="34%" height="22" bgcolor="#000080"><b>  
	
	<font face="Verdana" size="2" color="#FFFFFF">Cliente</font></b></td>  
	
	<td width="33%" height="22" bgcolor="#000080"><b>  
	
	<font face="Verdana" size="2" color="#FFFFFF">Dt. Conclusão</font></b></td>
		</tr>  
			<tr>  
				'
					if exists (select name from tempdb..sysobjects where name like '#tb_dba_replicacaotiffany_pro%')
						drop table #tb_dba_replicacaotiffany_pro
						 
	select
	top 10
	c.ncodigo
	,c.sNome
	,i.dConclusao
		into #tb_dba_replicacaotiffany_pro
	from
	Tb_MON_Mov_IndicadoresMonitor i
	inner join Tb_MON_Cad_Clientes c on c.ncodigo = i.nCliente
	where
	i.nCliente = 73
	and i.nTipoMonitor = 3 --somente replicação
	order by 3 desc
	
	select 
	@TableHTML = @TableHTML + '<tr><td><font face="Verdana" size="1">' + 
	ISNULL(CONVERT(VARCHAR(100), t.ncodigo), '') +'</font></td>' +    
	'<td><font face="Verdana" size="1">' + ISNULL(t.sNome,'') + '</font></td>' +   
	'<td><font face="Verdana" size="1">' + ISNULL(convert(varchar,t.dConclusao,103) + ' ' + convert(varchar,t.dConclusao,108),'') + '</font></td>'
	+' </tr>'
	from
	#tb_dba_replicacaotiffany_pro t
	SELECT @TableHTML =  @TableHTML + '</table>'
	
	EXEC msdb.dbo.sp_send_dbmail  
	@profile_name = 'captasql2',    
	@recipients='sql.server@capta.com.br; antonio.caldeira@capta.com.br; nelson.hamilton@capta.com.br',    
	@subject = 'Replicação Parada/Em execução (Tiffany PRO)',    
	@body = @TableHTML,    
	@body_format = 'HTML' ;	
	end	
	