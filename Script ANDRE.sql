Select GETDATE() ts, Round(Cast (getdate()-r.start_time as float)*24*60,2) duracao_min, r.blocking_session_id, round(qms.query_cost, 2) query_cost
		, s.host_name, s.program_name
		, r.session_id, r.request_id, r.start_time, r.status, r.command, db_name(r.database_id) dbname --, USER_NAME(r.user_id) username
		, Case  When r.wait_type is null Then 'CPU' else r.wait_type end wait_type, r.wait_time, r.last_wait_type, r.open_transaction_count, r.open_resultset_count, r.percent_complete, r.cpu_time, r.total_elapsed_time, r.reads, r.writes, r.logical_reads, r.row_count
		
	    , qms.used_memory_kb, qms.dop plan_dop, (select COUNT from sys.sysprocesses sp where sp.spid=r.session_id) parallel, qms.wait_order, qms.wait_time_ms, st.*
		, s.login_time, s.host_process_id, s.login_name
		, r.sql_handle, r.statement_start_offset, r.statement_end_offset, r.plan_handle --, (select qp.query_plan from sys.dm_exec_query_plan (r.plan_handle) as qp) query_plan
	-- connection_id, wait_resource, transaction_id, context_info, estimated_completion_time, scheduler_id, task_address, text_size, language, date_format date_first quoted_identifier arithabort ansi_null_dflt_on ansi_defaults ansi_warnings ansi_padding ansi_nulls concat_null_yields_null transaction_isolation_level lock_timeout deadlock_priority, prev_error  nest_level  granted_query_memory executing_managed_code group_id    query_hash         query_plan_hash
	  from sys.dm_exec_requests r 
	  join sys.dm_exec_sessions s on (s.session_id = r.session_id)
	  left join sys.dm_exec_query_memory_grants qms on (qms.session_id=r.session_id and qms.request_id=r.request_id)
	 outer apply sys.dm_exec_sql_text (r.sql_handle) as st
	 Where r.session_id >  	50 and r.session_id <> @@spid
	   and not (r.command = 'waitfor' and r.open_transaction_count = 0)
	Order by r.blocking_session_id desc, r.start_time asc, r.session_id;
