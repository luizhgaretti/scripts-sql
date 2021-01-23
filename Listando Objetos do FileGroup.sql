Select name=left(o.name,30),filegroup = s.groupname
From sysfilegroups S, sysindexes I, sysobjects O
Where I.indid < 2
And I.groupid = S.groupid
And I.id = O.id




SELECT o.name AS table_name,p.index_id, i.name AS index_name , au.type_desc AS allocation_type, FG.name, au.data_pages, partition_number
FROM sys.allocation_units AS au
    JOIN sys.partitions AS p ON au.container_id = p.partition_id
    JOIN sys.objects AS o ON p.object_id = o.object_id
    JOIN sys.indexes AS i ON p.index_id = i.index_id AND i.object_id = p.object_id
    join sys.filegroups FG on au.data_space_id = FG.data_space_id
ORDER BY o.name, p.index_id;
GO




select s.groupname AS FILEGROUP, object_name(i.id) AS OBJECT, i.name AS INDEX_NAME
     from sysfilegroups s, sysindexes i
     where i.groupid = s.groupid
GO

