/*
	Select para retornar os campos da chave Primaria
	Date: 19/07/2012
*/

Select ky.COLUMN_NAME 
From Information_Schema.Table_Constraints TBL
Inner Join Information_Schema.Key_Column_Usage KY 
	ON TBL.Constraint_Name = KY.Constraint_Name
Where TBL.Constraint_Type = 'PRIMARY KEY' and TBL.Table_Name = 'PedidoCompra'
