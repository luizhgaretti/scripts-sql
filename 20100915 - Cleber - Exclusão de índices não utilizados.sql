SELECT * FROM Tb_Capta_LogIndicesExcluidos
use master

--verifica se a versão do SQL é a partir da versão 2005 do SQL Server
if convert(numeric,replace(left(convert(varchar(50),SERVERPROPERTY('productversion')),2),'.','')) >= 9
begin
	--******************************************************************************************************
	--passo 1
	--identifica os índices não utilizados
	--******************************************************************************************************
	if ISNULL( (select count(1) from sysobjects where xtype='U' and name = 'Tb_dba_indicesnaousados' ),0) >0 drop table Tb_dba_indicesnaousados
	select 
	 a.database_id
	,convert(varchar(100),DB_NAME( a.database_id )) banco
	,a.object_id
	,a.index_id
	into Tb_dba_indicesnaousados
	from 
	sys.dm_db_index_usage_stats a
	where 
	1=1
	and a.object_id > 1000
	and isnull(round(cast(user_seeks as real) / coalesce(nullif((a.user_seeks + a.user_scans + a.user_lookups),0),1) * 100,0),0) = 0 
	and isnull(round(cast(user_scans as real) / coalesce(nullif((a.user_seeks + a.user_scans + a.user_lookups),0),1) * 100,0),0) = 0 
	and isnull(round(cast(user_lookups as real) / coalesce(nullif((a.user_seeks + a.user_scans + a.user_lookups),0),1) * 100,0),0) = 0 
	and a.last_system_lookup is null
	and a.last_system_scan is null
	and a.last_system_seek is null
	and convert(varchar(100),DB_NAME( a.database_id )) not in ( 'Corpore', 'master', 'model', 'msdb', 'tempdb', 'distribution', 'cep', 'cptprocs', 'reportserver', 'reportservertempdb' )
	order by 1
	--******************************************************************************************************
	--passo 1
	--identifica os índices não utilizados
	--******************************************************************************************************

	--******************************************************************************************************
	--passo 2
	--Pega os índices de cada banco, pois a tabela sys.indexes é por cada banco
	--******************************************************************************************************
	if ISNULL( (select count(1) from sysobjects where xtype='U' and name = 'Tb_dba_bancosativos' ),0) >0 drop table Tb_dba_bancosativos
	select
	 name
	,dbid
	into Tb_dba_bancosativos
	from
	master.dbo.sysdatabases
	where
	name not in ( 'Corpore', 'master', 'model', 'msdb', 'tempdb', 'distribution', 'cep', 'cptprocs', 'reportserver', 'reportservertempdb' )
	and isnull(version,0) <> 0
	order by 2
	
	
	if ISNULL( ( select count(1) from sysobjects where xtype='U' and name = 'Tb_dba_indicesnaousadosbanco' ),0) > 0 drop table Tb_dba_indicesnaousadosbanco
	create table Tb_dba_indicesnaousadosbanco
	(
	 name varchar(100) not null
	,dbid int not null
	,indice varchar(100) not null
	,tabela varchar(100) not null
	,index_id  int not null
	)
	declare @dbid int
	set @dbid = isnull(( select MIN(dbid) from Tb_dba_bancosativos ),0)
	declare @sql varchar(max)
	while @dbid <= isnull(( select MAX(dbid) from Tb_dba_bancosativos ),0)
	begin
		set @sql = ' insert into Tb_dba_indicesnaousadosbanco'
		set @sql = @sql + ' select ' + CHAR(39)+ ( select name from Tb_dba_bancosativos where dbid = @dbid ) + char(39) + ', ' + convert(varchar,@dbid) + ', ' + 'c.name' + ', ' + 'convert(varchar(100),o.name)' + ', ' + 'c.index_id'
		set @sql = @sql + ' from ' + ( select name from Tb_dba_bancosativos where dbid = @dbid ) + '.sys.indexes c '
		set @sql = @sql + ' inner join Tb_dba_indicesnaousados t on c.is_unique_constraint = 0 and c.is_unique = 0 and c.is_primary_key = 0 and c.name is not null and c.object_id is not null and c.index_id is not null and convert(varchar(100),object_name(c.object_id)) is not null and t.object_id = c.object_id and t.index_id = c.index_id and t.database_id = ' + convert(varchar,@dbid)
		set @sql = @sql + ' inner join '+( select name from Tb_dba_bancosativos where dbid = @dbid )+ '.dbo.sysobjects o on t.object_id = o.id'
		if len(replace(@sql,' ','')) > 0 exec(@sql)
		set @dbid = @dbid + 1
	end
	
	
	--******************************************************************************************************
	--passo 2
	--Pega os índices de cada banco, pois a tabela sys.indexes é por cada banco
	--******************************************************************************************************
	
	
	--******************************************************************************************************
	--passo 3
	--Realiza a exclusão dos índices e faz o log dos índices deletados
	--******************************************************************************************************
	--Caso não exista a tabela é criada a tabela que mantém o log dos índices excluídos
	if ISNULL( ( select count(1) from sysobjects where xtype='U' and name = 'Tb_Capta_LogIndicesExcluidos' ),0) =0
	begin
		create table Tb_Capta_LogIndicesExcluidos
		(
		 banco varchar(100) not null
		,tabela varchar(100) not null
		,indice varchar(100) not null
		,dt_exclusao datetime not null
		)
	end
	--Caso não exista a tabela é criada a tabela que mantém o log dos índices excluídos
	


	if ISNULL( (select count(1) from sysobjects where xtype='U' and name = 'Tb_dba_indiceslog' ),0) >0 drop table Tb_dba_indiceslog
	select 
	name
	,tabela
	,indice
	,GETDATE() dt_log
	,'use ' + LTRIM(rtrim(name)) + ' drop index ' + ltrim(RTRIM(tabela)) + '.' + ltrim(RTRIM(indice)) comando
	,ROW_NUMBER() over ( order by name ) nordem
	into Tb_dba_indiceslog
	from
	Tb_dba_indicesnaousadosbanco
	declare @catch varchar(max)
	declare @nOrdem int
	set @nOrdem = isnull(( select isnull(MIN(nordem),0) from Tb_dba_indiceslog ),0)
	while @nOrdem <= isnull(( select isnull(MAX(nordem),0) from Tb_dba_indiceslog ),0)
	begin
		begin try
			set @sql = isnull(( select c.comando from Tb_dba_indiceslog c where c.nordem = @nOrdem ),'')
			exec(@sql)
			
			if @@ERROR = 0
			insert into Tb_Capta_LogIndicesExcluidos ( banco, tabela, indice, dt_exclusao )
			select
			name
			,tabela
			,indice
			,dt_log
			from
			Tb_dba_indiceslog
			where
			nordem = @nOrdem
			
		end try
		begin catch
			set @catch = 'Não foi possível excluir o índice ' + ( select name + '.' + tabela + '.' + indice from tb_dba_indiceslog where nordem = @nOrdem) 
			print @catch
		end catch
		set @nOrdem = @nOrdem + 1
	end
	--******************************************************************************************************
	--passo 3
	--Realiza a exclusão dos índices e faz o log daqueles índices deletados
	--******************************************************************************************************
end


