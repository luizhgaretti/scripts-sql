Select 
(Select o.Name From Sys.objects o Where o.object_id = f.Object_id) as FKs,
(Select o.Name From Sys.objects o Where o.object_id = f.Referenced_Object_Id) as Principal,
(Select o.Name From Sys.objects o Where o.object_id = f.Parent_Object_Id) as Relacionada
From Sys.Foreign_Keys f


Select * From (
Select 
	(Select o.Name From Sys.objects o Where o.object_id = f.Object_id) as FKs,
	(Select o.Name From Sys.objects o Where o.object_id = f.Referenced_Object_Id) as Principal,	
	(Select o.Name From Sys.objects o Where o.object_id = f.Parent_Object_Id) as Relacionada
From Sys.Foreign_Keys f
) as FKs
Where FKs.Relacionada = 'FTEGF_CotaOrcamentaria'
GO