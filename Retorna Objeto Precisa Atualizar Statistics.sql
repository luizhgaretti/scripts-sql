-- Verifica se Objeto Precisa atualizar Statistics
Select 
I.id ObjectId,
T.name TableName,
I.indid Index_Stat_Id,
I.Name Index_Stat_Name,
I.rowmodctr,
I.rows,
I.dpages
From sysindexes I
Inner Join sys.Tables T 
	on I.id = t.object_id