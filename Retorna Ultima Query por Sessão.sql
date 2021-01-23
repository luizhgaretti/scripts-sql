-- Retorna o ultimo Comando executado na Sessão
SELECT session_id, TEXT
FROM sys.dm_exec_connections CROSS APPLY sys.dm_exec_sql_text(most_recent_sql_handle) AS ST 
Order By session_id desc
GO


-- Mais Informações
SELECT 
	c.session_id as [Sessão],
	s.login_name as [Login],
	client_net_address as [IP do cliente],
	p.hostname as [Nome da máquina do cliente],
	[text] as [Texto da consulta],
	DB_NAME(p.dbid) as [Nome do BD no qual foi executada a query],
	p.[program_name] as [Programa solicitante]
FROM sys.dm_exec_connections c
INNER JOIN sys.sysprocesses p 
	on c.session_id = p.spid
LEFT JOIN sys.dm_exec_sessions S
	on c.session_id = s.session_id
CROSS APPLY sys.dm_exec_sql_text(most_recent_sql_handle) AS ST