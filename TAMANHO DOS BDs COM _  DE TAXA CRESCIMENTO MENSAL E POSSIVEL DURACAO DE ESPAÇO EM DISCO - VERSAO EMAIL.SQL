use MonitorDBA
go

--hoje
select 
c.ncodigo,
c.sNome,
'C' as 'hoje',
bd.nomebd, 
bd.tamanho_MB,
upper(left(isnull(t.caminho_fisico,' '),1)) as unidade,
convert(varchar,(isnull(e.[Espaço Livre (GB)],0))) as Espaco_Livre_GB  
--t.caminho_fisico
into #tb_TamanhoBDClientes_hoje 
from (

select Tb_MON_Mov_TamanhoBDClientes.NCLIENTE,getdate() AS DT_HISTORICO,Tb_MON_Mov_TamanhoBDClientes.versao,
Tb_MON_Mov_TamanhoBDClientes.TIPO,Tb_MON_Mov_TamanhoBDClientes.nomebd ,Tb_MON_Mov_TamanhoBDClientes.tamanho_MB ,Tb_MON_Mov_TamanhoBDClientes.ARQUIVO,Tb_MON_Mov_TamanhoBDClientes.caminho_fisico from Tb_MON_Mov_TamanhoBDClientes
inner join (
select ncliente,nomebd,max(dt_historico) as dt_historico from Tb_MON_Mov_TamanhoBDClientes where 
--nomebd='DL_CPT2009' and 
dt_historico<=getdate()
and caminho_fisico like '%mdf' 
group by ncliente,nomebd) as mov on Tb_MON_Mov_TamanhoBDClientes.nCliente = mov.nCliente 
and Tb_MON_Mov_TamanhoBDClientes.dt_historico=mov.dt_historico

) as bd
join Tb_MON_Cad_Clientes c on c.ncodigo = bd.nCliente
join Tb_DBA_tamanhobdclienteatual t on t.ncliente = c.ncodigo and t.nomebd = bd.nomebd and t.caminho_fisico = bd.caminho_fisico --and t.dt_historico = bd.dt_historico
join Tb_DBA_EspacoTotaleLivre2 e with (nolock) on e.codigo = bd.nCliente and e.unidade = upper(left(isnull(t.caminho_fisico,' '),1))  
where  
--c.ncodigo in (43)
--and 
bd.caminho_fisico not like '%.ldf%'
and t.caminho_fisico not like '%.ldf%'
--and nomebd = 'dl_cpt2009'
--group by bd.nomebd, bd.tamanho_MB, dt_historico
order by bd.tamanho_MB  desc
go

--hoje - 30 dias
select 
c.ncodigo,
c.sNome,
'B' as 'um_mes',
bd.nomebd, 
bd.tamanho_MB,
upper(left(isnull(t.caminho_fisico,' '),1)) as unidade,
convert(varchar,(isnull(e.[Espaço Livre (GB)],0))) as Espaco_Livre_GB  
--t.caminho_fisico
into #tb_TamanhoBDClientes_menos_30_dias 
from (

select Tb_MON_Mov_TamanhoBDClientes.NCLIENTE,dateADD(MM,-1,getdate()) AS DT_HISTORICO,Tb_MON_Mov_TamanhoBDClientes.versao,
Tb_MON_Mov_TamanhoBDClientes.TIPO,Tb_MON_Mov_TamanhoBDClientes.nomebd ,Tb_MON_Mov_TamanhoBDClientes.tamanho_MB ,Tb_MON_Mov_TamanhoBDClientes.ARQUIVO,Tb_MON_Mov_TamanhoBDClientes.caminho_fisico from Tb_MON_Mov_TamanhoBDClientes
inner join (
select ncliente,nomebd,max(dt_historico) as dt_historico from Tb_MON_Mov_TamanhoBDClientes where 
--nomebd='DL_CPT2009' and 
dt_historico<=dateADD(MM,-1,getdate())
and caminho_fisico like '%mdf' 
group by ncliente,nomebd) as mov on Tb_MON_Mov_TamanhoBDClientes.nCliente = mov.nCliente 
and Tb_MON_Mov_TamanhoBDClientes.dt_historico=mov.dt_historico

) as bd
join Tb_MON_Cad_Clientes c on c.ncodigo = bd.nCliente
join Tb_DBA_tamanhobdclienteatual t on t.ncliente = c.ncodigo and t.nomebd = bd.nomebd and t.caminho_fisico = bd.caminho_fisico --and t.dt_historico = bd.dt_historico
join Tb_DBA_EspacoTotaleLivre2 e with (nolock) on e.codigo = bd.nCliente and e.unidade = upper(left(isnull(t.caminho_fisico,' '),1))  
where  
--c.ncodigo in (43)
--and 
bd.caminho_fisico not like '%.ldf%'
and t.caminho_fisico not like '%.ldf%'
--and nomebd = 'dl_cpt2009'
--group by bd.nomebd, bd.tamanho_MB, dt_historico
order by bd.tamanho_MB  desc
go

--hoje - 60 dias
select 
c.ncodigo,
c.sNome,
'A' as 'dois_meses', 
bd.nomebd, 
bd.tamanho_MB,
upper(left(isnull(t.caminho_fisico,' '),1)) as unidade,
convert(varchar,(isnull(e.[Espaço Livre (GB)],0))) as Espaco_Livre_GB  
--t.caminho_fisico
into #tb_TamanhoBDClientes_menos_60_dias 
from (

select Tb_MON_Mov_TamanhoBDClientes.NCLIENTE,dateADD(MM,-2,getdate()) AS DT_HISTORICO,Tb_MON_Mov_TamanhoBDClientes.versao,
Tb_MON_Mov_TamanhoBDClientes.TIPO,Tb_MON_Mov_TamanhoBDClientes.nomebd ,Tb_MON_Mov_TamanhoBDClientes.tamanho_MB ,Tb_MON_Mov_TamanhoBDClientes.ARQUIVO,Tb_MON_Mov_TamanhoBDClientes.caminho_fisico from Tb_MON_Mov_TamanhoBDClientes
inner join (
select ncliente,nomebd,max(dt_historico) as dt_historico from Tb_MON_Mov_TamanhoBDClientes where 
--nomebd='DL_CPT2009' and 
dt_historico<=dateADD(MM,-2,getdate())
and caminho_fisico like '%mdf' 
group by ncliente,nomebd) as mov on Tb_MON_Mov_TamanhoBDClientes.nCliente = mov.nCliente 
and Tb_MON_Mov_TamanhoBDClientes.dt_historico=mov.dt_historico

) as bd
join Tb_MON_Cad_Clientes c on c.ncodigo = bd.nCliente
join Tb_DBA_tamanhobdclienteatual t on t.ncliente = c.ncodigo and t.nomebd = bd.nomebd and t.caminho_fisico = bd.caminho_fisico --and t.dt_historico = bd.dt_historico
join Tb_DBA_EspacoTotaleLivre2 e with (nolock) on e.codigo = bd.nCliente and e.unidade = upper(left(isnull(t.caminho_fisico,' '),1))  
where  
--c.ncodigo in (43)
--and 
bd.caminho_fisico not like '%.ldf%'
and t.caminho_fisico not like '%.ldf%'
--and nomebd = 'dl_cpt2009'
--group by bd.nomebd, bd.tamanho_MB, dt_historico
order by bd.tamanho_MB  desc
go

select * into tb_TamanhoBDClientes_Geral from 
(select * from #tb_TamanhoBDClientes_hoje 
union 
select * from #tb_TamanhoBDClientes_menos_30_dias 
union 
select * from #tb_TamanhoBDClientes_menos_60_dias) TB

-- declarando duas variáveis
DECLARE @Colunas VARCHAR(MAX), @SQL NVARCHAR(MAX)

-- montando a coluna do pivot dinamicamente
SET @Colunas = STUFF(
                                  (SELECT  ', ' + QUOTENAME(CAST(hoje AS VARCHAR(MAX))) 
                FROM tb_TamanhoBDClientes_Geral GROUP BY hoje ORDER BY hoje asc
                FOR XML PATH('')), 1,2,'')
                
SET @SQL = N''
SET @SQL = @SQL + N' SELECT ncodigo, snome, nomebd, unidade, espaco_livre_gb,' +  @Colunas 
SET @SQL = @SQL + N' into tb_BD FROM tb_TamanhoBDClientes_Geral'
SET @SQL = @SQL + N' PIVOT (max(tamanho_mb) FOR hoje IN (' + @Colunas + ')) Z'
EXEC SP_EXECUTESQL @SQL
--print @sql

create table #tb_bdclientes
(
codigo int,
cliente varchar(50),
banco varchar(50),
unidade varchar(1),
espaco_livre_gb decimal (19,2),
[60_dias] decimal(19,2),
[30_dias] decimal(19,2),
[Atual] decimal(19,2)
)

insert into #tb_bdclientes
select * from tb_BD

--select convert(varchar,(dateadd(mm, -2, getdate())),103) + '  #######  ' + convert(varchar,(dateadd(mm, -1, getdate())),103) + '  #######  ' +  convert(varchar,getdate(), 103) as Data_Referencia
--declare @datas varchar(500)
--set @datas = convert(varchar,(dateadd(mm, -2, getdate())),103) + '  #######  ' + convert(varchar,(dateadd(mm, -1, getdate())),103) + '  #######  ' +  convert(varchar,getdate(), 103) 
select 
--@datas as Datas_Referencia,
--(select convert(varchar,getdate(), 103)) as Data_Referencia,
cliente, 
banco, 
unidade,
(espaco_livre_gb * 1024) as espaco_livre_mb,
[60_dias], 
[30_dias], 
[Atual], 
convert(decimal(19,2),((([Atual] / [60_dias]) - 1) * 100)) as [Taxa_Crescimento_%],
case when abs(([Atual] - [60_dias])) >= 1 and [Atual] > [60_dias] then 
convert(decimal(19,0),(((espaco_livre_gb * 1024) * 2) / ([Atual] - [60_dias]))) 
else 
0
end as [Meses_Disco_FULL]
into #tb_db_html
from #tb_bdclientes
WHERE ATUAL>1000
order by 9 desc


/********************************************************************************************************************************************************/
/*************************************************************TRATAMENTO PARA MANDAR EMAIL***************************************************************/
/********************************************************************************************************************************************************/
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
		<font face="Verdana" size="1" color="#FFFFFF">Cliente</font></b></td>
		<td width="23%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Banco</font></b></td>
		<td width="23%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Unidade</font></b></td>
		<td width="30%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Espaco Livre (MB)</font></b></td>
		<td width="50%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">60 Dias</font></b></td>
		<td width="50%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">30 Dias</font></b></td>
			<td width="50%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Atual</font></b></td>
			<td width="50%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Taxa de Crescimento %</font></b></td>
			<td width="50%" bgColor="#000080" height="15"><b>
		<font face="Verdana" size="1" color="#FFFFFF">Meses Disco FULL</font></b></td>
	  </tr>'


select 
@TableHTML =  @TableHTML + 
	'<tr><td><font face="Verdana" size="1">' + isnull(cliente, '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(banco, '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(unidade, '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(convert(varchar,espaco_livre_mb), '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(convert(varchar,[60_dias]), '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(convert(varchar,[30_dias]), '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(convert(varchar,[Atual]), '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(convert(varchar,[Taxa_Crescimento_%]), '') +'</font></td>' + 
'<td><font face="Verdana" size="1">' + isnull(convert(varchar,Meses_Disco_FULL), '') +'</font></td></tr>' 
from #tb_db_html

SELECT 
	@TableHTML =  @TableHTML + '</table>' +   
	'<p style="margin-top: 0; margin-bottom: 0">&nbsp;</p>
	<hr color="#000000" size="1">
	<p><font face="Verdana" size="2"><b>Responsável: sql.server@capta.com.br </font></p>  
	<p style="margin-top: 0; margin-bottom: 0"><font face="Verdana" size="2">Obrigado. []s,</font></p>  
	<p style="margin-top: 0; margin-bottom: 0"><font face="Verdana" size="2">DBA</font></p>  
	<p>&nbsp;</p>'  

	
--print @TableHTML


EXEC msdb.dbo.sp_send_dbmail  
	@profile_name = 'captasql2',    
	@recipients='sql.server@capta.com.br',    
	@subject = 'Crescimento dos Bancos SQL',    
	@body = @TableHTML,    
	@body_format = 'HTML' ;    



drop table #tb_TamanhoBDClientes_hoje
drop table #tb_TamanhoBDClientes_menos_30_dias 
drop table #tb_TamanhoBDClientes_menos_60_dias 
drop table tb_TamanhoBDClientes_Geral
drop table tb_BD
drop table #tb_BDClientes
drop table #tb_db_html
