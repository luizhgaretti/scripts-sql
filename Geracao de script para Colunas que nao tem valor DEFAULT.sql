--Criação de tabela que guardará as colunas que precisam do default e qual o valor padrão do default 
create table #tb_dba_campo_null_sem_default (  tabela varchar(100) ,coluna varchar(100) ,cComando varchar(4000) ,nOrdem int not null identity(1,1)
)
--Criação de tabela que guardará as colunas que precisam do default e qual o valor padrão do default


--Lista quais são as colunas que precisam do default e qual o valor padrão 
insert into #tb_dba_campo_null_sem_default ( tabela, coluna, cComando ) select  o.name tabela ,c.name coluna ,'ALTER TABLE [dbo].[' + o.name + '] ADD  DEFAULT (' + case 
	when t.name = 'bit' then '0'
	when t.name = 'char' then char(39) + ' ' + CHAR(39)
	when t.name = 'datetime' then char(39) + '19000101' + CHAR(39)
	when t.name = 'int' then '0'
	when t.name = 'numeric' then '0'
	when t.name = 'decimal' then '0'
	when t.name = 'text' then char(39) + ' ' + CHAR(39)
	when t.name = 'varchar' then char(39) + ' ' + CHAR(39) end 
+') FOR [' + c.name + ']' comando
from
sysobjects o
inner join syscolumns c on o.id = c.id
inner join systypes t on c.xtype = t.xtype where o.xtype='U'
and c.isnullable = 0
and isnull(c.cdefault,0) = 0
or c.xtype in (select xtype from syscolumns where xtype = 104 and isnullable in (0,1))
--inseri essa condição, pois se for null nesse case dará erro na execução do comando de inserir o default
 and case 
	when t.name = 'bit' then '0'
	when t.name = 'char' then char(39) + ' ' + CHAR(39)
	when t.name = 'datetime' then char(39) + '19000101' + CHAR(39)
	when t.name = 'int' then '0'
	when t.name = 'numeric' then '0'
	when t.name = 'decimal' then '0'
	when t.name = 'text' then char(39) + ' ' + CHAR(39)
	when t.name = 'varchar' then char(39) + ' ' + CHAR(39) end is not null 
	--inseri essa condição, pois se for null nesse case dará erro na execução do comando de inserir o default 
	order by 1, 2 
	--Lista quais são as colunas que precisam do default e qual o valor padrão


--Realiza a criação dos defaults para as colunas identificadas sem o default
declare @nOrdem int
set @nOrdem = (select MIN(nOrdem) from #tb_dba_campo_null_sem_default)

declare @cComando varchar(4000)

while @nOrdem <= (select MAX(nOrdem) from #tb_dba_campo_null_sem_default)
begin
	set @cComando =
	(
	select 
	cComando 
	from 
	#tb_dba_campo_null_sem_default
	where
	nOrdem = @nOrdem
	)
	
	print @cComando --lista o comando executado
	--exec(@cComando) --executa o comando para inserir o default
	
	set @nOrdem = @nOrdem + 1
end	
--Realiza a criação dos defaults para as colunas identificadas sem o default
drop table #tb_dba_campo_null_sem_default
