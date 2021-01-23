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
from #tb_bdclientes
WHERE ATUAL>1000
order by 9 desc

drop table #tb_TamanhoBDClientes_hoje
drop table #tb_TamanhoBDClientes_menos_30_dias 
drop table #tb_TamanhoBDClientes_menos_60_dias 
drop table tb_TamanhoBDClientes_Geral
drop table tb_BD
drop table #tb_BDClientes
