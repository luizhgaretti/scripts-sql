use MonitorDBA
go

--hoje
select 
c.ncodigo,
c.sNome,
convert(varchar, bd.dt_historico, 103) as 'hoje',
bd.nomebd, 
bd.tamanho_MB,
upper(left(isnull(t.caminho_fisico,' '),1)) as unidade,
convert(varchar,(isnull(e.[Espaço Livre (GB)],0))) as Espaco_Livre_GB  
--t.caminho_fisico
into #tb_TamanhoBDClientes_hoje 
from Tb_MON_Mov_TamanhoBDClientes bd
join Tb_MON_Cad_Clientes c on c.ncodigo = bd.nCliente
join Tb_DBA_tamanhobdclienteatual t on t.ncliente = c.ncodigo and t.nomebd = bd.nomebd and t.caminho_fisico = bd.caminho_fisico --and t.dt_historico = bd.dt_historico
join Tb_DBA_EspacoTotaleLivre2 e with (nolock) on e.codigo = bd.nCliente and e.unidade = upper(left(isnull(t.caminho_fisico,' '),1))  
where datepart(dd,bd.dt_historico) = datepart(dd,getdate()) 
and datepart(mm,bd.dt_historico) = datepart(mm,getdate()) 
and datepart(yy,bd.dt_historico) = datepart(yy,getdate())
and c.ncodigo in (43)
and bd.caminho_fisico not like '%.ldf%'
and t.caminho_fisico not like '%.ldf%'
--and nomebd = 'dl_cpt2009'
--group by bd.nomebd, bd.tamanho_MB, dt_historico
order by bd.tamanho_MB  desc

--hoje - 30 dias
select 
c.ncodigo,
c.sNome,
convert(varchar, bd.dt_historico, 103) as 'um_mes',
bd.nomebd, 
bd.tamanho_MB,
upper(left(isnull(t.caminho_fisico,' '),1)) as unidade,
convert(varchar,(isnull(e.[Espaço Livre (GB)],0))) as Espaco_Livre_GB  
--t.caminho_fisico
into #tb_TamanhoBDClientes_menos_30_dias 
from Tb_MON_Mov_TamanhoBDClientes bd
join Tb_MON_Cad_Clientes c on c.ncodigo = bd.nCliente
join Tb_DBA_tamanhobdclienteatual t on t.ncliente = c.ncodigo and t.nomebd = bd.nomebd and t.caminho_fisico = bd.caminho_fisico --and t.dt_historico = bd.dt_historico
join Tb_DBA_EspacoTotaleLivre2 e with (nolock) on e.codigo = bd.nCliente and e.unidade = upper(left(isnull(t.caminho_fisico,' '),1))  
where datepart(dd,bd.dt_historico) = datepart(dd,getdate())
and datepart(mm,bd.dt_historico) = datepart(mm,getdate()) - 1
and datepart(yy,bd.dt_historico) = datepart(yy,getdate())
and c.ncodigo in (43)
and bd.caminho_fisico not like '%.ldf%'
and t.caminho_fisico not like '%.ldf%'
--and nomebd = 'dl_cpt2009'
--group by bd.nomebd, bd.tamanho_MB, dt_historico
order by bd.tamanho_MB  desc

--hoje - 60 dias
select 
c.ncodigo,
c.sNome,
convert(varchar, bd.dt_historico, 103) as 'dois_meses', 
bd.nomebd, 
bd.tamanho_MB,
upper(left(isnull(t.caminho_fisico,' '),1)) as unidade,
convert(varchar,(isnull(e.[Espaço Livre (GB)],0))) as Espaco_Livre_GB  
--t.caminho_fisico
into #tb_TamanhoBDClientes_menos_60_dias 
from Tb_MON_Mov_TamanhoBDClientes bd
join Tb_MON_Cad_Clientes c on c.ncodigo = bd.nCliente
join Tb_DBA_tamanhobdclienteatual t on t.ncliente = c.ncodigo and t.nomebd = bd.nomebd and t.caminho_fisico = bd.caminho_fisico --and t.dt_historico = bd.dt_historico
join Tb_DBA_EspacoTotaleLivre2 e with (nolock) on e.codigo = bd.nCliente and e.unidade = upper(left(isnull(t.caminho_fisico,' '),1))  
where datepart(dd,bd.dt_historico) = datepart(dd,getdate()) 
and datepart(mm,bd.dt_historico) = datepart(mm,getdate()) - 2
and datepart(yy,bd.dt_historico) = datepart(yy,getdate())
and c.ncodigo in (43)
and bd.caminho_fisico not like '%.ldf%'
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
cliente varchar(20),
banco varchar(20),
unidade varchar(1),
espaco_livre_gb decimal (19,2),
[60_dias] decimal(19,2),
[30_dias] decimal(19,2),
[Atual] decimal(19,2)
)

insert into #tb_bdclientes
select * from tb_BD

--select convert(varchar,getdate(), 103) as Data_Atual

select 
(select convert(varchar,getdate(), 103)) as Data_Atual,
cliente, 
banco, 
unidade,
(espaco_livre_gb * 1024) as espaco_livre_mb,
[60_dias], 
[30_dias], 
[Atual], 
convert(decimal(19,2),((([Atual] / [60_dias]) - 1) * 100)) as [Taxa_Crescimento_%],
case when ([Atual] - [60_dias]) <> 0 then 
convert(decimal(19,0),(((espaco_livre_gb * 1024) * 2) / ([Atual] - [60_dias]))) 
else 
0
end as [Meses_Disco_FULL]
from #tb_bdclientes
order by 9 desc

drop table #tb_TamanhoBDClientes_hoje
drop table #tb_TamanhoBDClientes_menos_30_dias 
drop table #tb_TamanhoBDClientes_menos_60_dias 
drop table tb_TamanhoBDClientes_Geral
drop table tb_BD
drop table #tb_BDClientes


