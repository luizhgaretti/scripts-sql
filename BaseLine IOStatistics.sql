/*
	SCRIPT: Coleta Informações de I/O para analise de Latencia de Escrita e Leitura.
	DATA: 22/04
	AUTOR: Luiz Henrique Garetti
	SCHEDULE: A cada 1 Hora
*/

INSERT INTO  [SERV-DBPRODCL04].[ADM_DBAMonitoria].[dbo].[BaseLineIOStatistics]
SELECT
	@@SERVERNAME AS ServerName,																			-- Servidor de Origem
	DB_NAME(D.database_id) AS DatabaseName,																-- Database Name
	M.type_desc AS Type,																				-- Tipo de File
	D.num_of_reads AS CountReads,																		-- Quantidade de Leituras
	D.io_stall_read_ms AS WaitReads_ms,																	-- Tempo total, em milissegundos, de espera de operações de fisicas de leituras
	CONVERT(NUMERIC(10,2),(CONVERT(NUMERIC(10,2),D.io_stall_read_ms)/CONVERT(NUMERIC(10,2),D.num_of_reads))) AS AVGLatencyRead_ms,	-- Média de Latency em Leitura
	D.num_of_writes AS CountWrites,																		-- Quantidade de Escritas
	D.io_stall_write_ms AS WaitWrite_ms,																-- Tempo total, em milissegundos, de espera de operações de fisicas de escritas
	CONVERT(NUMERIC(10,2),(CONVERT(NUMERIC(10,2),D.io_stall_write_ms)/CONVERT(NUMERIC(10,2),D.num_of_writes))) AS AVGLatencyWrite_ms,	-- Média de Latency em Escrita
	(D.io_stall_read_ms + D.io_stall_write_ms) AS TotalWaitIO_ms,										-- Tempo total, em milissegundos, de espera -> Leitura + Escritas
	CAST((D.num_of_bytes_written * 1.0 / (D.num_of_bytes_written * 1.0 + D.num_of_bytes_read * 1.0) * 100) AS NUMERIC(10,2)) AS [Write%],	-- Percentual de Escrita
	CAST((D.num_of_bytes_read * 1.0 / (D.num_of_bytes_read * 1.0 + D.num_of_bytes_written * 1.0) * 100) AS NUMERIC(10,2)) AS  [Read%],		-- Percentual de Leitura
	CAST(D.io_stall_read_ms / (1.0 + D.num_of_reads) AS NUMERIC(10,2)) AS AvgReadsWait_ms,				-- Média em milissegundos de espera em operações de Leituras
	CAST(D.io_stall_write_ms /(1.0) + D.num_of_writes AS NUMERIC(10,2)) AS AvgWritesWait_ms,			-- Média em milissegundos de espera em operações de Escritas
    CAST((io_stall_read_ms + io_stall_write_ms ) / (1.0 + num_of_reads + num_of_writes) AS NUMERIC(10,4)) AS AvgIOWait, -- Média de I/Os no Geral,
	GETDATE() AS DataHora																				-- Data/Hora de Captura
FROM sys.dm_io_virtual_file_stats(NULL,NULL) AS D 
INNER JOIN sys.master_files M
	ON D.database_id = M.database_id
	AND D.file_id = M.file_id
ORDER BY 1 DESC
GO