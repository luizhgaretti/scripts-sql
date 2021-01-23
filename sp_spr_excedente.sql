USE [master]
GO
/****** Object:  StoredProcedure [dbo].[spr_excedente]    Script Date: 11/12/2011 17:50:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spr_excedente] as

SET NOCOUNT ON

-- CRIO UMA TEMPORARIA PARA GUARDAR AS DATABASES DO SERVER
create table #dtbase (dtbase nvarchar(100))


declare @cmd1 nvarchar(500)
declare @cmd2 nvarchar(500)
set @cmd1 = 'insert into #dtbase select ''?'''
exec sp_MSforeachdb @command1=@cmd1

-- insert into #dtbase values ('tst_naka')

select replace(replace(arquivos,'.dbf',' '),' ','') as tabela
, replace(campos,'','') as campos
	, case tipos when 'C' then 'char' 
		when 'D' then 'date' 
		when 'G' then 'imagem'
		when 'I' then 'int'
		when 'L' then 'bit'
		when 'M' then 'text'
		when 'N' then 'numerico'
		when 'T' then 'datetime' end as tipo
, tamanhos  
into #origem
	from [200.158.216.85].monitoria.dbo.comparacao_bases where varquivo = 'varquivo'

--CRIAR CURSOR PARA PEGAR AS TABELAS DE CADA DATABASE PARA COMPARACAO, exceto as do sistema
create table #sistema 
(tabela nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS 
, campos nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS
,tipo nvarchar(20) COLLATE SQL_Latin1_General_CP1_CI_AS
, tamanho bigint
, dtbase nvarchar(50) COLLATE SQL_Latin1_General_CP1_CI_AS)













--***************************************************************************************************
--Passo 1
--Levanta os bancos que estão no servidores
--***************************************************************************************************
--drop table #tb_nomes_bancos
create table #tb_nomes_bancos
(
nOrdem int not null identity(1,1)
,servidor varchar(100) null
,bd varchar(100) null
,flag_erp varchar(1) null
,flag_folha varchar(1) null
,flag_contabil varchar(1) null
,flag_livros varchar(1) null
,flag_processos varchar(1) null
)

insert into #tb_nomes_bancos ( servidor, bd, flag_erp, flag_folha, flag_contabil, flag_livros, flag_processos )
select
 @@servername servidor
,name bd
,convert(varchar(1),null ) flag_erp
,convert(varchar(1),null ) flag_folha
,convert(varchar(1),null ) flag_contabil
,convert(varchar(1),null ) flag_livros
,convert(varchar(1),null ) flag_processos
from
master.dbo.sysdatabases
where
name not in
(
 'master'
,'model'
,'tempdb'
,'msdb'
,'northwind'
,'pubs'
,'adventureworks'
)
and version is not null
order by 1
--***************************************************************************************************
--Passo 1
--Levanta os bancos que estão no servidores
--***************************************************************************************************



--***************************************************************************************************
--Passo 2
--Indica qual o tipo de banco de dados que é: ERP, folha, contábil, livros fiscais ou nenhum
--***************************************************************************************************
declare @sql nvarchar(4000)

declare @nOrdem int
set @nOrdem = isnull(( select min(nOrdem) from #tb_nomes_bancos ),1)

declare @bd varchar(100)

declare @flag varchar(1)

--drop table #flag
create table #flag 
(
flag varchar(1) null
)

while @nOrdem <= isnull(( select max(nOrdem) from #tb_nomes_bancos ),1)
begin

	--Flag ERP
	truncate table #flag
	set @bd = ( select bd from #tb_nomes_bancos where nOrdem = @nOrdem )
	set @sql = 'select 1 from ' + @bd + '.dbo.sysobjects where name = ''sljemp'' and xtype = ''U'''
	
	insert into #flag
	exec(@sql)
	
	set @flag = ( select isnull(count(1),'0') from #flag )
	
	update #tb_nomes_bancos
	set 
	flag_erp = @flag
	where
	bd = @bd
	
	--Flag ERP
	
	
	
	--Flag Processos
	truncate table #flag
	--set @bd = ( select bd from #tb_nomes_bancos where nOrdem = @nOrdem )
	set @sql = 'select 1 from ' + @bd + '.dbo.sysobjects where name = ''cpttrf'' and xtype = ''U'''
	
	insert into #flag
	exec(@sql)
	
	set @flag = ( select isnull(count(1),'0') from #flag )
	
	update #tb_nomes_bancos
	set 
	flag_processos = @flag
	where
	bd = @bd
	
	--Flag Processos
	
	
	--Flag Livros
	truncate table #flag
	--set @bd = ( select bd from #tb_nomes_bancos where nOrdem = @nOrdem )
	set @sql = 'select 1 from ' + @bd + '.dbo.sysobjects where name = ''slvemp'' and xtype = ''U'''
	
	insert into #flag
	exec(@sql)
	
	set @flag = ( select isnull(count(1),'0') from #flag )
	
	update #tb_nomes_bancos
	set 
	flag_livros = @flag
	,flag_erp = case when @flag = 1 then 0 else flag_erp end
	where
	bd = @bd
	
	--Flag Livros
	
	
	--Flag Folha
	truncate table #flag
	--set @bd = ( select bd from #tb_nomes_bancos where nOrdem = @nOrdem )
	set @sql = 'select 1 from ' + @bd + '.dbo.sysobjects where name = ''cptemp'' and xtype = ''U'''
	
	insert into #flag
	exec(@sql)
	
	set @flag = ( select isnull(count(1),'0') from #flag )
	
	update #tb_nomes_bancos
	set 
	flag_folha = @flag
	,flag_erp = case when @flag = 1 then 0 else flag_erp end
	where
	bd = @bd
	
	--Flag Folha
	
	
	--Flag Contábil
	truncate table #flag
	--set @bd = ( select bd from #tb_nomes_bancos where nOrdem = @nOrdem )
	set @sql = 'select 1 from ' + @bd + '.dbo.sysobjects where name = ''conemp'' and xtype = ''U'''
	
	insert into #flag
	exec(@sql)
	
	set @flag = ( select isnull(count(1),'0') from #flag )
	
	update #tb_nomes_bancos
	set 
	flag_contabil = @flag
	,flag_erp = case when @flag = 1 then 0 else flag_erp end
	where
	bd = @bd
	
	--Flag Contábil
	
	set @nOrdem = @nOrdem + 1
end
--***************************************************************************************************
--Passo 2
--Indica qual o tipo de banco de dados que é: ERP, folha, contábil, livros fiscais ou nenhum
--***************************************************************************************************




delete #dtbase where dtbase in ( select bd from #tb_nomes_bancos where isnull(flag_erp,0) <> 1 )
















-- CRIO UMA TABELA TEMPORARIA PARA TOTALIZAR AS TABELAS POR DATABASE

create table #problema 
(tabela nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS 
, campos nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS
, tipo nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS 
, tamanho bigint
, dtbase nvarchar(100) COLLATE SQL_Latin1_General_CP1_CI_AS 
, problema text COLLATE SQL_Latin1_General_CP1_CI_AS)

--declare @sql nvarchar (4000)

declare @dtbase nvarchar(50)

DECLARE product_cursor CURSOR FOR 

select dtbase from #dtbase where dtbase 
not in 
('master','tempdb','model','msdb'
,'ReportServer','AdventureWorksDW'
, 'AdventureWorks','Northwind','pubs'
,'ReportServerTempDB' )

OPEN product_cursor
FETCH NEXT FROM product_cursor INTO @dtbase


WHILE @@FETCH_STATUS = 0
BEGIN

-- VERIFICO O TIPO DE CAMPO DA DATABASE ATUAL E SALVO EM UMA TEMPORARIA PARA COMPARACAO COM A ORIGEM
set @sql = '
insert into #sistema (tabela, campos, tipo, tamanho,dtbase)
select  upper(b.name) as tabela
, replace (upper(a.name),'' '','''') as campos
, case a.xtype  
		when 34 then  ''image''
		when 35 then  ''text''
		when 36 then  ''uniqueidentifier''
		when 48 then  ''tinyint''
		when 52 then  ''smallint''
		when 56 then  ''int''
		when 58 then  ''smalldatetime''
		when 59 then  ''real''
		when 60 then  ''money''
		when 61 then  ''datetime''
		when 62 then  ''float''
		when 98 then  ''sql_variant''
		when 99 then  ''ntext''
		when 104 then ''bit''
		when 106 then ''decimal''
		when 108 then ''numeric''
		when 122 then ''smallmoney''
		when 127 then ''bigint''
		when 165 then ''varbinary''
		when 167 then ''nvarchar''
		when 173 then ''binary''
		when 175 then ''char''
		when 189 then ''timestamp''
		when 231 then ''nnvarchar''
		when 239 then ''nchar''
		when 241 then ''xml''
		when 256 then ''sysname''
		else ''nao tem tipo'' end as tipo
, a.length as tamanho
, '''+@dtbase+''' 
 from '+@dtbase+'..sysobjects b inner join '+@dtbase+'..syscolumns a ON a.id = b.id 
 where b.xtype = ''u'' 
group by b.name, a.name, a.xtype, a.length
order by b.name

-- campos que tem na origem e nao tem no sistema
insert into #problema
select #origem.*,'''+@dtbase+''' as dtbase,''Campo faltante no db do sistema'' as problema
	from #origem inner join #sistema on #origem.tabela = #sistema.tabela
	where #origem.campos not in (select campos from #sistema where tabela = #origem.tabela) 
	group by #origem.tabela, #origem.campos,#origem.tipo,#origem.tamanhos
	order by #origem.tabela, #origem.campos 

insert into #problema (tabela, dtbase, problema)
select tabela,  '''+@dtbase+''' as dtbase, ''Tabela excedente no sistema''
	from #sistema 
	where tabela not in (select tabela from #origem)
	GROUP BY tabela

-- CAMPO EXCENDENTE
insert into #problema

select #sistema.*
,''Campo excedente no sistema'' as problema   
from #origem inner join #sistema on #origem.tabela = #sistema.tabela   
where #sistema.campos not in (select campos from #origem where tabela = #sistema.tabela)    
group by #sistema.tabela, #sistema.campos,#sistema.tipo,#sistema.tamanho, #sistema.dtbase
order by #sistema.tabela, #sistema.campos'


exec (@sql)

FETCH NEXT FROM product_cursor INTO @dtbase

END

CLOSE product_cursor
DEALLOCATE product_cursor
	
	delete [200.158.216.85].monitoria.dbo.tb_excedentes where server = @@servername
	insert into [200.158.216.85].monitoria.dbo.tb_excedentes (tabela, campo, tipo, tamanho, dtbase, problema, server)
	select *,@@servername from #problema

select *,@@servername from #problema
 drop table #dtbase
 drop table #origem
 drop table #sistema
 drop table #problema



