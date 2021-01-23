use banco_de_dados
go
Select t.name as tabela, i.name As indice, c.name As cField1s ,
		a.is_included_column as include
	From sys.index_columns a 
		Inner Join sys.tables t On t.object_id = a.object_id
		Inner Join sys.indexes i On i.object_id = a.object_id And i.index_id = a.index_id
		Inner Join sys.columns c On c.object_id = a.object_id And c.column_id = a.column_id 
	Where t.type = 'U' And t.name + i.name
	In (Select t.name + i.name
		From sys.index_columns a 
			Inner Join sys.tables t On t.object_id = a.object_id
			Inner Join sys.indexes i On i.object_id = a.object_id And i.index_id = a.index_id
			Inner Join sys.columns c On c.object_id = a.object_id And c.column_id = a.column_id 
		Where t.type = 'U' And t.name = 'tabela' And a.is_included_column = 1)
Order by t.name, i.name, a.index_column_id
