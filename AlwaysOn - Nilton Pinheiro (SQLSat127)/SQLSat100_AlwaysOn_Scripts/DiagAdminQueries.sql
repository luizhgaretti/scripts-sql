SELECT @@SERVERNAME as Servername,
SERVERPROPERTY ('Instancename') as 'Instanceame',
SERVERPROPERTY ('ComputerNamePhysicalNetBios') as 'ComputerNamePhysicalNetBios' 
GO
select ag.name as 'AG Group', ar.replica_server_name as 'ServerName',
ar_state.is_local, ar_state.role_desc, ar_state.operational_state_desc,
ar_state.synchronization_health_desc, ar_state.connected_state_desc
 from sys.availability_groups ag
inner join sys.availability_replicas ar
ON ag.group_id = ar.group_id 
JOIN sys.dm_hadr_availability_replica_states ar_state
ON ar.replica_id = ar_state.replica_id
ORDER BY 2

select ag.name as 'AG Group', ar.replica_server_name as 'ServerName',
db_name(ar_state.database_id) as dbname, ar_state.synchronization_state_desc,
ar_state.last_commit_time 
 from sys.availability_groups ag
inner join sys.availability_replicas ar
ON ag.group_id = ar.group_id 
JOIN sys.dm_hadr_database_replica_states ar_state
ON ar.replica_id = ar_state.replica_id
ORDER BY 2,3

/*



select * from sys.dm_hadr_availability_group_states 
select * from sys.dm_hadr_availability_replica_states 
select * from sys.dm_hadr_database_replica_cluster_states 
select * from sys.dm_hadr_database_replica_states 

select * from sys.availability_groups
*/