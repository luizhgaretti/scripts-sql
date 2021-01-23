/*
	Retorna a instru��o SQL e o Plano de Execu��o XML
*/

Select * From Sys.dm_exec_requests 
Cross Apply sys.dm_exec_query_plan(plan_handle)
	Cross Apply sys.dm_exec_sql_text(sql_handle)

	
Select * From Sys.dm_exec_query_stats
Cross Apply sys.dm_exec_query_plan(plan_handle)
	Cross Apply sys.dm_exec_sql_text(sql_handle)	
