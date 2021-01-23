-- Retorna todas as tabelas que contem Identity
Select O.Name as Campo, C.Name Tabela
From sys.identity_columns C, sys.objects O
Where C.Object_ID = O.Object_ID
And C.object_id in (Select object_id from sys.tables)