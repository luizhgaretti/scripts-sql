-- Ultimo Rebuild

Select 
        o.name As ObjectName
        ,i.name As IndexName
        ,i.type_desc As IndexType
        ,o.create_date
        ,o.modify_date
        ,stats_date(o.object_id, i.index_id) As stat_date
From 
        sys.objects             o
        Inner Join sys.indexes  i On i.object_id = o.object_id
Where
        o.type <> 'S'