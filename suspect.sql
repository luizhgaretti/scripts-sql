--****************************************************************************************************************************
--Banco Suspect
--****************************************************************************************************************************
set nocount on 
declare @codcli numeric
set @codcli = 499

--drop table #tb_dba_sp_helpdb
create table #tb_dba_sp_helpdb
(
[name] varchar(100) null
,[db_size] varchar(100) null
,owner varchar(100) null
,dbid int null
,[created] varchar(20) null
,status varchar(1000) null
,[compatibility_level] int null
)

insert into #tb_dba_sp_helpdb
exec sp_helpdb 


insert into [200.158.216.85].monitordba.dbo.Tb_Mon_Mov_BDClienteSuspect 
(
codcli
, nomebd
, db_size
, [owner]
,DBID
,[created]
,[status]
,[compatibility_level]
)
select 
@codcli codcli
,[name]
,[db_size]
,[owner]
,dbid
,[created]
,[status]
,[compatibility_level]
from 
#tb_dba_sp_helpdb
where
charindex('Status=ONLINE', ISNULL([status],' '),0) <> 1
--****************************************************************************************************************************
--Banco Suspect
--****************************************************************************************************************************

