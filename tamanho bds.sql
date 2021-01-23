declare @codcli int
set @codcli = 526

--drop table #tb_dba_nomebanco
create table #tb_dba_nomebanco
(
 nOrdem int not null identity(1,1)
,nomebd varchar(100) not null default('')
)
--*****************************************************************************************
--Passo 1
--Pega os bancos atachados
--*****************************************************************************************
insert into #tb_dba_nomebanco ( nomebd )
select
name banco
from
master.dbo.sysdatabases
where
name not in
(
 'master'
,'tempdb'
,'model'
,'msdb'
)
order by 1
--*****************************************************************************************
--Passo 1
--Pega os bancos atachados
--*****************************************************************************************


--*****************************************************************************************
--Passo 2
--Faz a gravação dos dados no servidor da capta
--*****************************************************************************************
declare @nOrdem int
set @nOrdem = isnull( ( select min(nOrdem) from #tb_dba_nomebanco ),0)
declare @nomebd varchar(100)
declare @sql varchar(1000)
while @nOrdem <= isnull( ( select max(nOrdem) from #tb_dba_nomebanco ),0)
begin
      set @nomebd = ( select nomebd from #tb_dba_nomebanco where nOrdem = @nOrdem )
      
      
      set @sql = ' insert into [200.158.216.85].monitordba.dbo.Tb_MON_Mov_TamanhoBDClientes select '
      set @sql = @sql + convert(varchar,@codcli) + ' codcli'
      set @sql = @sql + ' ,getdate() data_hora'
      set @sql = @sql + ' ,case when left(convert(varchar(1000),serverproperty(''ProductVersion'')),1) = ''8'' then ''SQL2000'' when left(convert(varchar(1000),serverproperty(''ProductVersion'')),1) = ''9'' then ''SQL2005'' when left(convert(varchar(1000),serverproperty(''ProductVersion'')),2) = ''10'' then ''SQL2008'' end versao'
      set @sql = @sql + ' ,convert(varchar(100),serverproperty(''edition'')) tipo'


      set @sql = @sql + ' ,' + char(39) + @nomebd + char(39) + ' nomebd'
      set @sql = @sql + ' ,CONVERT(decimal(10,1),[SIZE])*8/1024 tamanho_MB'
      set @sql = @sql + ' ,[name] arquivo'
      set @sql = @sql + ' ,[filename] arquivo_fisico'
      set @sql = @sql + ' from '
      set @sql = @sql + @nomebd + '.dbo.' +'sysfiles'
      print @sql
      exec(@sql)

      set @nOrdem = @nOrdem + 1
end
--*****************************************************************************************
--Passo 2
--Faz a gravação dos dados no servidor da capta
--*****************************************************************************************





