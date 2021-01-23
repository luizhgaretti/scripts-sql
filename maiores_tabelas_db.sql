create table #Tb_Bd_sp_spaceused
(
name varchar(100) null
,rows int null
,reserved varchar(100) null
,data varchar(100) null
,index_size varchar(100) null
,unused varchar(100) null
)

create table #Tb_Bd_Comandos
(
nOrdem int not null identity(1,1)
,cComando varchar(400) null
)


insert into #Tb_Bd_Comandos ( cComando )
select
'insert into #Tb_Bd_sp_spaceused exec sp_spaceused ' + name 
from
sysobjects
where
xtype = 'U'

declare @nOrdem int
set @nOrdem = isnull( ( select min(nOrdem) from #Tb_Bd_Comandos ),1)

declare @cComando varchar(400)
while @nOrdem <= isnull( ( select max(nOrdem) from #Tb_Bd_Comandos ),1)
begin
                set @cComando = ( select cComando from  #Tb_Bd_Comandos where nOrdem = @nOrdem)
                exec( @cComando)
                
                set @nOrdem = @nOrdem + 1
end

select 
--top 10
name
,rows
,convert(int,replace(reserved,' KB',''))/1024 reserved_MB
,convert(int,replace(data,' KB',''))/1024 data_MB
,convert(int,replace(index_size,' KB',''))/1024 index_size_MB
,convert(int,replace(unused,' KB',''))/1024 unused_MB
from 
#Tb_Bd_sp_spaceused
where
name <> 'dtproperties'
order by 3 desc
