--mostra o caminho dos arquivos do sql atual e antigos (que ja foram cadastrados anteriomente, por isso deleto caso tenha migracao para outra unidade)
select   

ncliente  

, nomebd  

, arquivo  

, caminho_fisico  

, max(dt_historico) dt_historico   

--into Tb_DBA_tamanhobdclienteatual  

from   

Tb_MON_Mov_TamanhoBDClientes with (nolock)  

where nCliente = 195

group by  

ncliente  

, nomebd  

, arquivo  

, caminho_fisico  


/*
deleta o caminho antigo dos arquivos do SQL caso faça uma migracao e continue avisando que a unidade antiga ainda esteja alarmando no monitoramento
begin tran
rollback
commit
delete from Tb_MON_Mov_TamanhoBDClientes
where caminho_fisico like 'c:\%' and nCliente = 195
*/

/***********************************************************************************************************/

--select que mostra a unidade, tamanho da base, espaço total e livre e manda email caso a unidade seja menor que a soma dos bancos
select  

 c.ncodigo Codigo  

,c.Snome Cliente  

,upper(left(isnull(t.caminho_fisico,' '),1)) unidade  

,convert(numeric(18,2),sum(isnull(o.tamanho_mb,0)))/1024 [Tamanho Base (GB)]    

,isnull(e.[Tamanho Total (GB)],0) [Espaço Total (GB)]  

,isnull(e.[Espaço Livre (GB)],0) [Espaço Livre (GB)]  

,isnull(e.[(%) Livre],0) [(%) Livre]    

--into #tb_dba_espacolivremenortamanhobd  

from  

Tb_MON_Cad_Clientes c with (nolock)  

left join Tb_DBA_tamanhobdclienteatual t on t.ncliente = c.ncodigo  

left join Tb_MON_Mov_TamanhoBDClientes o with (nolock) on o.ncliente = t.ncliente and o.nomebd = t.nomebd and o.arquivo = t.arquivo and o.caminho_fisico = t.caminho_fisico and o.dt_historico = t.dt_historico  

inner join Tb_DBA_EspacoTotaleLivre2 e with (nolock) on e.codigo = o.nCliente and e.unidade = upper(left(isnull(t.caminho_fisico,' '),1))  

where  

c.Snome not like '%Vivara%'

and c.snome not like 'nuova'  

and c.ncodigo = 195

group by  

 c.ncodigo   

,c.Snome   

,upper(left(isnull(t.caminho_fisico,' '),1))  

,isnull(e.[Tamanho Total (GB)],0)   

,isnull(e.[Espaço Livre (GB)],0)   

,isnull(e.[(%) Livre],0)   

having  

isnull(e.[Espaço Livre (GB)],0) < convert(numeric(18,2),sum(isnull(o.tamanho_mb,0)))/1024  

order by 2, 3  