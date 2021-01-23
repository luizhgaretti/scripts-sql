-- Tabelas sem PK
Select * from sys.tables
Where object_id in (
Select object_id(TBL.TABLE_NAME)
From Information_Schema.Table_Constraints TBL
Inner Join Information_Schema.Key_Column_Usage KY 
	ON TBL.Constraint_Name = KY.Constraint_Name
Where TBL.Constraint_Type = 'PRIMARY KEY')



-- Tabelas sem PK
Select TBL.TABLE_NAME, KY.COLUMN_NAME, OBJECT_ID(TBL.TABLE_NAME)
From Information_Schema.Table_Constraints TBL
Inner Join Information_Schema.Key_Column_Usage KY 
	ON TBL.Constraint_Name = KY.Constraint_Name
Where TBL.Constraint_Type = 'PRIMARY KEY'
And len(KY.COLUMN_NAME) > 2
