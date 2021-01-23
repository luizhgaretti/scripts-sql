-- script karla
use master 
go
	DECLARE @dbname varchar(200)
	create table #temp2
				([database_name] varchar (300)
				,[schema_name] varchar (300)
				,[object_id] int
				,[table_name] varchar (700)
				,[index_id] int
				,[index_name] varchar (300)
				,[index_level] int
				,[lob_column] varchar (3)
				,[partitioned] varchar (3)
				,[partition_number] int
				,[index_type_desc] varchar (30)
				,[avg_fragmentation_in_percent] decimal (10,2)
				,[avg_page_space_used_in_percent] decimal (10,2)
				,[page_count] bigint
				,[entry_dt] datetime
				,[start_time] datetime
				,[end_time] datetime
				,[action_type] varchar (100)
				,[command] varchar (3000)
				,[error] varchar (3000))
				go						
	DECLARE XCursor CURSOR FOR (select name from sysdatabases where dbid > 4)
	OPEN XCursor
	FETCH NEXT FROM XCursor INTO @dbname
	WHILE @@FETCH_STATUS = 0
	BEGIN
		insert into #temp2 ([database_name] ,[schema_name] ,[object_id] ,[table_name] ,[index_id] ,[index_name] 
							,[index_level] , [lob_column], [partition_number] ,[index_type_desc] ,[avg_fragmentation_in_percent] 
							,[avg_page_space_used_in_percent] ,[page_count],[entry_dt], [action_type])
		 EXECUTE ('USE ['+ @dbname +']
					select db_name() as [database_name]
					,schema_name(o.schema_id)
					,o.[object_id]
					,o.name as [table_name]
					,i.[index_id]
					,i.name as [index_name]
					,s.index_level
					,(case when object_off is not null then ''yes'' else ''no'' end)
					,[partition_number]
					,[index_type_desc]
					,[avg_fragmentation_in_percent]
					,[avg_page_space_used_in_percent]
					,[page_count]
					,getdate ()
					, case 
							when s.avg_page_space_used_in_percent >= 75 and s.avg_fragmentation_in_percent <= 5 then ''no action required''
							when s.index_type_desc = ''heap'' then ''heap''
							when (avg_page_space_used_in_percent < 60 or avg_fragmentation_in_percent > 30) then ''rebuild''
							else ''reorganize;''
					 end 
					from (sys.all_objects o inner join sys.dm_db_index_physical_stats(db_id(), null, null, null, ''detailed'') s
							on s.[object_id] = o.[object_id]) 
							inner join sys.indexes i on i.object_id = s.object_id and i.index_id = s.index_id
							left join (select a.object_id as object_off,a.index_id
										from sys.indexes a
											inner join sys.objects f on a.object_id  = f.object_id
											inner join sys.columns g on g.object_id = f.object_id 
											inner join sys.types d on d.system_type_id = g.system_type_id
										where (d.name in (''text'',''image'',''ntext'',''xml'',''varbinary''))
											or (d.name  in  (''varchar'',''nvarchar'') 	and d.max_length =-1) group by a.object_id,a.index_id) as onlineof 
							on o.object_id = onlineof.object_off and i.index_id = onlineof.index_id
						')	
		FETCH NEXT FROM XCursor INTO @dbname
	END
	select * from #temp2 where lob_column is not null
	drop table #temp2
	CLOSE XCursor
	DEALLOCATE XCursor
