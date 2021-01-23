/*
=====================================================================================
	Com essa consulta é possivel pesquisar o conteudo de Procedures e Trigger.  =
	Retorna o Tipo (Procedure ou Trigger) e nome do Objeto		            =
	Data: 27/07/2012						            =
	Autor: Luiz Henrique							    =
=====================================================================================
*/


Select
	Case a.xtype 
		When 'P'  Then 'Procedure'
		When 'TR' Then 'Trigger'
	End As Tipo,
	A.Name 
From SysObjects A, SysComments B
Where A.xtype in ('P', 'TR')
	and A.ID = b.id
	and B.Encrypted = 0
	and B.Text Like '%print%'
Group by A.xtype, A.Name
Order by A.Name