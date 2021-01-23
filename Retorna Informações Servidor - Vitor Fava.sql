-- Selecionando propriedades da inst�ncia SQL Server
SELECT
 SERVERPROPERTY('MachineName') AS [MachineName], 
 SERVERPROPERTY('ServerName') AS [ServerName], 
 SERVERPROPERTY('InstanceName') AS [Instance], 
 SERVERPROPERTY('IsClustered') AS [IsClustered], 
 SERVERPROPERTY('ComputerNamePhysicalNetBIOS') AS [ComputerNamePhysicalNetBIOS], 
 SERVERPROPERTY('Edition') AS [Edition], 
 SERVERPROPERTY('ProductLevel') AS [ProductLevel], 
 SERVERPROPERTY('ProductVersion') AS [ProductVersion], 
 SERVERPROPERTY('ProcessID') AS [ProcessID],
 SERVERPROPERTY('Collation') AS [Collation], 
 SERVERPROPERTY('IsFullTextInstalled') AS [IsFullTextInstalled], 
 SERVERPROPERTY('IsIntegratedSecurityOnly') AS [IsIntegratedSecurityOnly];
 
-- Selecionando informa��es sobre o sistema operacional Windows
SELECT
 windows_release, 
 windows_service_pack_level, 
 windows_sku, 
 os_language_version
FROM
 sys.dm_os_windows_info;
 
-- Selecionando informa��es sobre os servi�os de SQL Server
SELECT
 servicename, 
 startup_type_desc, 
 status_desc, 
 last_startup_time, 
 service_account, 
 is_clustered, 
 cluster_nodename
FROM
 sys.dm_server_services;