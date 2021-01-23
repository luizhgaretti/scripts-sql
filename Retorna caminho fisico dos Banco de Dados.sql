Select A.Database_id, 
A.Type_Desc as 'Tipo', 
B.Name as 'Banco',
A.Name as 'Nome Arquivo',
A.Physical_Name as 'Caminho Arquivo'
from Sys.Master_Files A
Inner Join Sys.Databases B On A.Database_Id = B.Database_Id
Order by B.Name, Tipo DESC
GO