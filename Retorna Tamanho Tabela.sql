create table #temp ([name] varchar(1000), [rows] varchar(1000), [reserved] varchar(1000), 
[data] varchar(1000), 
[index_size] varchar(1000), [unsed] varchar(1000))

insert into #temp
EXEC sp_MSforeachTable @command1="print '>>Tabela: ?' ", 
											   @command2="sp_spaceused '?' "

select * from #temp

drop table #temp

