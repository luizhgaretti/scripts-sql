SET NOCOUNT ON

-- CRIO UMA TEMPORARIA PARA GUARDAR AS DATABASES DO SERVER
create table #dtbase (dtbase nvarchar(100))

declare @cmd1 nvarchar(500)
declare @cmd2 nvarchar(500)
set @cmd1 = 'insert into #dtbase select ''?'''
exec sp_MSforeachdb @command1=@cmd1


-- CRIA UM LINKED SERVER PARA O ARQUIVO DBF QUE CONTEM A ESTRUTURA ATUAL DAS TABELAS, QUE DEVE ESTAR SALVO
-- NO SERVER OU DISPONIVEL NA WEB.
-- PARA EXEMPLO INTERNO, O ARQUIVO ESTA NO 28.4

EXEC master.dbo.sp_addlinkedserver 
@server = N'estruct', 
@srvproduct=N'Microsoft Visual FoxPro OLE DB Data Provider', 
@provider=N'VFPOLEDB', 
@datasrc=N'\\192.168.28.4\sistemas\suporte\prod2008\varquivo.dbf', 
-- @datasrc=N'C:\CLIENTES_CAPTA\varquivo.dbf', 

@provstr=N'VFPOLEDB.1'

EXEC master.dbo.sp_MSset_oledb_prop N'VFPOLEDB', N'AllowInProcess', 1 
GO 

-- SALVO A ESTRUTURA UM UMA TABELA TEMPORARIA
SELECT * into #temp
FROM OPENQUERY(estruct, 'SELECT arquivos,campos,tipos,tamanhos  FROM varquivo.dbf order by arquivos') 
GO

-- REMOVO O LINKED SERVER PARA NAO SOBRECARREGAR O SERVER
exec sp_dropserver @server = 'estruct' 
GO

-- VERIFICO O TIPO DE CAMPO PARA COMPARACAO E SALVO EM OUTRA TABELA TEMPORARIA
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
	from #temp 

--CRIAR CURSOR PARA PEGAR AS TABELAS DE CADA DATABASE PARA COMPARACAO, exceto as do sistema
create table #sistema (tabela nvarchar(100), campos nvarchar(100),tipo nvarchar(20), tamanho bigint, dtbase nvarchar(50))

-- CRIO UMA TABELA TEMPORARIA PARA TOTALIZAR AS TABELAS POR DATABASE
create table #problema (tabela nvarchar(100), campos nvarchar(100), tipo nvarchar(100), tamanho bigint, dtbase nvarchar(100), problema text)
declare @sql nvarchar (4000)

declare @dtbase nvarchar(50)

DECLARE product_cursor CURSOR FOR 

select dtbase from #dtbase where dtbase not in ('master','tempdb','model','msdb')

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

insert into #problema (tabela, dtbase, problema)
select tabela,  '''+@dtbase+''' as dtbase, ''Tabela nao encontrada no sistema''
	from #origem 
	where tabela not in (select tabela from #sistema)
	GROUP BY tabela
'

exec (@sql)

FETCH NEXT FROM product_cursor INTO @dtbase

END

CLOSE product_cursor
DEALLOCATE product_cursor

	select * from #problema

drop table #dtbase
drop table #temp
drop table #origem
drop table #sistema
drop table #problema

