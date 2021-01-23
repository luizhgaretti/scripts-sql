use master
set nocount on
--********************************************************************************************************
--Passo 1
--Derrubar todos os usuários que possuam sistema aberto
--********************************************************************************************************
create table #Tb_BD_sp_KillUser
(
 Nordem int not null identity(1,1)
,cComando varchar(1000) null
)

insert into #Tb_BD_sp_KillUser
select
'exec master.dbo.sp_killuser ' + char(39) + loginname + char(39)
from
master.dbo.syslogins
where
--status = 9 and 
loginname in ( 'captarmtdb', 'captasup', 'usuarios', 'user', 'usuprocs' )
order by 1

declare @nOrdem int
set @nOrdem = ( select min(nOrdem) from #Tb_BD_sp_KillUser )

declare @sql varchar(1000)

while @nOrdem <= ( select max(nOrdem) from #Tb_BD_sp_KillUser )
Begin
	set @sql = ( select cComando from #Tb_BD_sp_KillUser where nOrdem = @nOrdem  )

	--print @sql
	exec (@sql)

	set @nOrdem = @nOrdem + 1
end
--********************************************************************************************************
--Passo 1
--Derrubar todos os usuários que possuam sistema aberto
--********************************************************************************************************

--********************************************************************************************************
--Passo 2
--Executar o update statistics por banco de dados
--********************************************************************************************************

--**************************************
--Passo 2.1 
--Pega as tabelas por Banco de Dados
--**************************************


create table #Tb_BD_BancosServidor
(
 Nordem int not null identity(1,1)
,NomeBanco varchar(1000) null
)

insert into #Tb_BD_BancosServidor
select
name
from
master.dbo.sysdatabases
where
name not in ( 'master', 'model', 'msdb', 'tempdb' )
order by 1


set @nOrdem = ( select min(nOrdem) from #Tb_BD_BancosServidor )


declare @NomeBanco varchar(100)

create table #Tb_Bd_UpdateStatistics
(
 nOrdem int not null identity(1,1)
,cComando varchar(1000) null
)

while @nOrdem <= ( select max(nOrdem) from #Tb_BD_BancosServidor )
Begin

	set @NomeBanco = ( select NomeBanco from #Tb_BD_BancosServidor where nOrdem = @nOrdem  )

	truncate table #Tb_Bd_UpdateStatistics
	set @sql = 'insert into #Tb_Bd_UpdateStatistics ( cComando ) select ''use ' + @NomeBanco + ''' + '' update statistics '' + name from ' + @NomeBanco+ '.dbo.sysobjects where xtype = ''U'' order by name'
	exec(@sql)
	
	
	declare @nOrdem_estatisticas int
	set @nOrdem_estatisticas = ( select min(nOrdem) from #Tb_Bd_UpdateStatistics )
	
	while @nOrdem_estatisticas <= ( select max(nOrdem) from #Tb_Bd_UpdateStatistics )
	begin
	
		set @sql = ( select cComando from #Tb_Bd_UpdateStatistics where nOrdem = @nOrdem_estatisticas )
		--print @sql
		exec (@sql)

		set @nOrdem_estatisticas = @nOrdem_estatisticas + 1
	end

	set @nOrdem = @nOrdem + 1
end
--**************************************
--Passo 2.1 
--Pega as tabelas por Banco de Dados
--**************************************

--********************************************************************************************************
--Passo 2
--Executar o update statistics por banco de dados
--********************************************************************************************************



--********************************************************************************************************
--Passo 3
--Executar o dbcc dbreindex por banco de dados
--********************************************************************************************************

--**************************************
--Passo 3.1 
--Pega as tabelas por Banco de Dados
--**************************************



set @nOrdem = ( select min(nOrdem) from #Tb_BD_BancosServidor )


create table #Tb_Bd_dbccdbreindex
(
 nOrdem int not null identity(1,1)
,cComando varchar(1000) null
)

while @nOrdem <= ( select max(nOrdem) from #Tb_BD_BancosServidor  )
Begin

	set @NomeBanco = ( select NomeBanco from #Tb_BD_BancosServidor where nOrdem = @nOrdem  )

	truncate table #Tb_Bd_dbccdbreindex
	set @sql = 'insert into #Tb_Bd_dbccdbreindex ( cComando ) select ''use ' + @NomeBanco + ''' + '' dbcc dbreindex ('' + name + '')'' from ' + @NomeBanco+ '.dbo.sysobjects where xtype = ''U'' order by name'
	exec(@sql)
	
	
	declare @nOrdem_dbccdbreindex int
	set @nOrdem_dbccdbreindex = ( select min(nOrdem) from #Tb_Bd_dbccdbreindex )
	
	while @nOrdem_dbccdbreindex <= ( select max(nOrdem) from #Tb_Bd_dbccdbreindex )
	begin
	
		set @sql = ( select cComando from #Tb_Bd_dbccdbreindex where nOrdem = @nOrdem_dbccdbreindex )
		--print @sql
		exec(@sql)

		set @nOrdem_dbccdbreindex = @nOrdem_dbccdbreindex + 1
	end

	set @nOrdem = @nOrdem + 1
end
--**************************************
--Passo 3.1 
--Pega as tabelas por Banco de Dados
--**************************************

--********************************************************************************************************
--Passo 3
--Executar o dbcc dbreindex por banco de dados
--********************************************************************************************************