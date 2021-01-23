-- Scripts Avaliação de Desempenho
DECLARE @cntr_value BIGINT 
SELECT @cntr_value = cntr_value  FROM sys.dm_os_performance_counters WHERE counter_name = 'transactions/sec' 
AND object_name = 'SQLServer:Databases' 
AND instance_name = 'TesteMirror' 

WAITFOR DELAY '00:00:01' 

SELECT cntr_value - @cntr_value FROM sys.dm_os_performance_counters WHERE counter_name = 'transactions/sec' 
AND object_name = 'SQLServer:Databases' 
AND instance_name = 'TesteMirror'


SELECT object_name As Servidor, 
	   instance_name As Banco, 
	   cntr_value As [Transações por Segundo]
FROM sysperfinfo
WHERE counter_name = 'Transactions/sec'