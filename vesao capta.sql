use master

declare @codcli int
set @codcli =526

create table #tb_dba_bancos
(
nOrdem int not null identity(1,1)
,banco varchar(100) not null
)

insert into #tb_dba_bancos ( banco )
select
name
from
master.dbo.sysdatabases s
where
s.name not in ( 'master', 'tempdb', 'model', 'msdb' )
order by 1


declare @nOrdem_Banco int
set @nOrdem_Banco = ISNULL( ( select MIN(nOrdem) from #tb_dba_bancos ),0)

--faz loop de todos os bancos de dados que estão atachados no cliente

declare @sql varchar(8000)
create table #Tb_Bancos_com_Versao
(
nOrdem int not null identity(1,1)
, banco varchar(100) 
,nr_tabelas int
)

while @nOrdem_Banco <= ISNULL( ( select MAX(nOrdem) from #tb_dba_bancos ),0)
begin 
	--checa se existem as tabelas sljlog e sljparac
	set @sql = ' insert into #Tb_Bancos_com_Versao ( banco, nr_tabelas ) select ' + CHAR(39) + (select banco from #tb_dba_bancos where nOrdem = @nOrdem_Banco) + CHAR(39) + ' ,count(distinct o.name) nr_tabelas from '
	set @sql = @sql + (select banco from #tb_dba_bancos where nOrdem = @nOrdem_Banco) + '.dbo.sysobjects o '
	set @sql = @sql + ' inner join ' + (select banco from #tb_dba_bancos where nOrdem = @nOrdem_Banco) + '.dbo.syscolumns c on c.id = o.id and o.xtype=''U'' and o.name in (''sljlog'',''sljparac'' ) having count(distinct o.name) > 0 '
	exec(@sql)	
	--checa se existem as tabelas sljlog e sljparac
	set @nOrdem_Banco = @nOrdem_Banco + 1
end
--faz loop de todos os bancos de dados que estão atachados no cliente


--nesse trecho pega as informações das tabelas sljlog e sljparac
declare @nOrdem_Versao int
set @nOrdem_Versao = ( select MIN(nOrdem) from #Tb_Bancos_com_Versao )
declare @banco varchar(100)
while @nOrdem_Versao <= ( select Max(nOrdem) from #Tb_Bancos_com_Versao )
begin
	set @banco = (select banco from #Tb_Bancos_com_Versao where nOrdem = @nOrdem_Versao)
	set @sql= 'insert into [200.158.216.85].monitordba.dbo.Tb_MON_MovVersaoCaptaCliente'
	set @sql = @sql + ' select '
	set @sql = @sql + convert(varchar,@codcli)
	set @sql = @sql + ' ,banco'
	set @sql = @sql + ' ,GETDATE()'
	set @sql = @sql + ' ,(select top 1 cversaos from ' + @banco + '.dbo.sljlog (nolock) order by datars desc)'
	set @sql = @sql + ' ,(select cversis from ' + @banco +'.dbo.sljparac (nolock) )'
	set @sql = @sql + ' from'
	set @sql = @sql + ' #Tb_Bancos_com_Versao'
	set @sql = @sql + ' where'
	set @sql = @sql + ' nOrdem = ' + convert(varchar,@nOrdem_Versao)
	set @sql = @sql + ' and nr_tabelas > 0'
	--print @sql
	exec(@sql)
	
	set @nOrdem_Versao = @nOrdem_Versao + 1
end	

--nesse trecho pega as informações das tabelas sljlog e sljparac

drop table #tb_dba_bancos
drop table #Tb_Bancos_com_Versao




