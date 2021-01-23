/* 
=============================================================
= Retorna a Tabela onde Contem o Campo informado no filtro	=
= Data: 27/07/2012
= Autor: Luiz Henrique
=============================================================
*/

Select Obj.Name,
	   Obj.[type], 
	   Sys.Columns.Object_Id 
From Sys.columns Inner Join
	 (Select name, [type], Object_id From sys.objects) As OBJ
On Sys.columns.Object_Id = obj.Object_Id
Where sys.columns.name = 'Nome'