-- Retorna Planos de execução em cache
Select	QT.text,
	QP.query_plan,
	QS.execution_count,
	QS.total_elapsed_time,
	QS.last_elapsed_time,
	QS.total_logical_reads
From sys.dm_exec_query_stats as QS
CROSS APPLY sys.dm_exec_sql_text(QS.sql_handle) as QT
CROSS APPLY sys.dm_exec_query_plan(QS.plan_handle) as QP
Order by QS.execution_count desc