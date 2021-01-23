declare @codcli int
set @codcli = 70

--drop table #tb_dba_espacolivrehd
create table #tb_dba_espacolivrehd ( unidade varchar(10), espaco_livre_mb numeric(18,2))
insert into #tb_dba_espacolivrehd
exec master.dbo.xp_fixeddrives

--drop table #tb_dba_espacototalhd
create table #tb_dba_espacototalhd ( linha varchar(200) null )

insert into #tb_dba_espacototalhd
EXEC master.dbo.xp_cmdshell 'wmic LOGICALDISK LIST BRIEF' 


declare @linha varchar(200)
set @linha = ( select top 1 * from #tb_dba_espacototalhd )
insert into [200.158.216.85].monitordba.dbo.Tb_MON_MovEspacoLivreHDClientes
select
@codcli codcli
,GETDATE() dt_historico
,substring(D.unidade,1,1) unidade
,isnull(convert(numeric(18,2),ltrim(rtrim(substring(t.linha,charindex('size',@linha,0), charindex('volumename',@linha,0) - charindex('size',@linha,0) ))))/1024/1024/1024,0) tamanho_gb
,d.espaco_livre_mb/1024 espaco_livre_gb
,case when (convert(numeric(18,2),ltrim(rtrim(substring(t.linha,charindex('size',@linha,0), charindex('volumename',@linha,0) - charindex('size',@linha,0) ))))/1024/1024/1024) <> 0 then (d.espaco_livre_mb/1024) / (convert(numeric(18,2),ltrim(rtrim(substring(t.linha,charindex('size',@linha,0), charindex('volumename',@linha,0) - charindex('size',@linha,0) ))))/1024/1024/1024) * 100 else 0 end perc_livre
from
#tb_dba_espacolivrehd d 
LEFT JOIN #tb_dba_espacototalhd t ON substring(t.linha,1,1) = ltrim(rtrim(d.unidade))
where
--substring(t.linha,1,6) <> 'Device'
--and 
isnumeric(ISNULL(ltrim(rtrim(substring(t.linha,charindex('size',@linha,0), charindex('volumename',@linha,0) - charindex('size',@linha,0) ))),0)) = 1

