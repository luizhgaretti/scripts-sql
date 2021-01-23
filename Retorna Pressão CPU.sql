-- Analisando Pressão do Processador
Select signal_wait_time_ms=sum(signal_wait_time_ms),'%signal (cpu) 
waits' = cast(100.0 * sum(signal_wait_time_ms) / sum (wait_time_ms)
as numeric(20,2)),resource_wait_time_ms=sum(wait_time_ms - signal_wait_time_ms),'%resource waits'= cast(100.0 * sum(wait_time_ms -
signal_wait_time_ms) / sum (wait_time_ms) as numeric(20,2)) From sys.dm_os_wait_stats 

-- Quanto mais %recouce waits e menos %signal (cpu) waits melhor, quer dizer que, 
-- nesse momento não está havendo problemas de pressão com processador.

This query is useful to help confirm CPU pressure. Because signal waits are time waiting for a CPU to service a thread,
if you record total signal waits that are roughly greater than 10 percent to 15 percent, then this is a pretty good indicator of CPU pressure