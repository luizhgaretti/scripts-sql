-------------DOCUMENTAÇÃO SQL SERVER------------

--	1- Nome do ServerName e HostaName.
--	2- Noma da Instancia, Versão, Servicepack e Edição. 
--	3- Informações do Sistema Operacional.
--	4- Todas as configurações definidas no SQL Server(sp_configure)
--	5- Collation do SQL Server.
--	6- Espaço disponivel em todos os discos.
--	7- Lista de todos os Bancos inclusive de sistema.
--	8- Informações gerais dos bancos.
--	9- Lista de usuarios.
-- 10- Nome dos servidores do nó Cluster.
-- 11- Discos utilizados no Cluster.
-- 12- IPs e Portas utilizadas.
-- 13- Lista backup device.
-- 14- Lista de LinkdServers.
-- 15- Lista de Jobs.

SET NOCOUNT ON
USE master
GO
PRINT ''
PRINT 'DOCUMENTAÇÃO DO SERVIDOR SQL SERVER'
PRINT 'DATA: ' + CONVERT (varchar, GETDATE(), 109)
PRINT ''
PRINT ''
PRINT ''
PRINT '--NOME DO SERVERNAME E HOSTNAME'
PRINT ''
select   substring(srvname,1,25) as srvname,substring(HOST_NAME(),1,25) as Hostname from sysservers 
PRINT ''
PRINT ''
PRINT '--NOME DA INSTANCIA, VERSÃO, SERVICEPACK E EDIÇÃO'
PRINT ''
SELECT
ISNULL (CAST( SERVERPROPERTY( 'InstanceName' ) AS varchar( 25 ) ), CAST( SERVERPROPERTY( 'MachineName' )AS varchar( 25 )) ) AS Instance,
CAST( SERVERPROPERTY( 'ProductVersion' ) AS varchar( 20) ) AS Version ,
CAST( SERVERPROPERTY( 'ProductLevel' ) AS varchar( 5 ) ) AS ServicePack ,
CAST( SERVERPROPERTY( 'Edition' ) AS varchar( 28 ) ) AS Edition ,
( CASE SERVERPROPERTY( 'EngineEdition')
WHEN 1 THEN 'Personal or Desktop'
WHEN 2 THEN 'Standard'
WHEN 3 THEN 'Enterprise'
END ) AS EngineType --,
--CAST( SERVERPROPERTY( 'LicenseType' ) AS varchar( 20 ) ) AS LicenseType ,
--CAST( SERVERPROPERTY( 'NumLicenses' ) AS varchar( 10 ) ) AS #Licenses;
PRINT ''
PRINT ''
PRINT ''
PRINT '--INFORMAÇÕES DO SISTEMA OPERACIONAL'
PRINT ''
EXEC master..xp_msver
PRINT ''
GO
PRINT ''
PRINT '--TODAS AS CONFIGURAÇÕES DEFINIDAS NO SQL SERVER(sp_configure)'
PRINT ''
EXEC sp_configure 'show advanced', 1
RECONFIGURE WITH OVERRIDE
GO
PRINT ''
EXEC sp_configure
GO
EXEC sp_configure 'show advanced', 0
RECONFIGURE WITH OVERRIDE
PRINT ''
GO
PRINT ''
PRINT '--COLLATION SQL SERVER'
PRINT ''
EXEC sp_helpsort
PRINT ''
GO
PRINT ''
PRINT '--ESPAÇO DISPONIVEL TODOS OS DISCOS'
PRINT ''
exec xp_fixeddrives
PRINT ''
GO
PRINT ''
PRINT '--LISTA TODOS OS BANCOS INCLUSIVE DE SISTEMA'
select substring(name,1,25) from sysdatabases --where name not in ('master','msdb','model','tempdb')
GO
PRINT ''
PRINT '--INFORMAÇÕES GERAIS DOS BANCOS'
CREATE TABLE #bddsc (dbname sysname,dbsize nvarchar(13) null,owner sysname null,dbid smallint,
created nvarchar(11),dbdesc	nvarchar(600)	null,cmptlevel tinyint)
insert into #bddsc exec sp_helpdb
SELECT mf.dbid, substring(dsc.dbname,1,20)as name,substring(mf.name,1,80)as physical_name, 
mf.size, mf.maxsize, mf.growth,substring(suser_sname(sid),1,10) as suser_sname, db.cmptlevel, db.crdate, dsc.dbdesc
FROM master.dbo.sysaltfiles as mf
INNER JOIN master.dbo.sysdatabases as db on mf.dbid = db.dbid
INNER JOIN #bddsc as dsc on db.dbid = dsc.dbid
DROP TABLE #bddsc 
PRINT ''
GO
PRINT ''
PRINT '--LISTA DE USUARIOS'
PRINT ''
Select substring(name,1,45) as Name, substring(dbname,1,20) as DB_Default,substring(language,1,20) as Language, substring(LoginName,1,40) as LoginName
from syslogins
PRINT ''
GO
PRINT ''
PRINT '--CONFIGURAÇÃO DO CLUSTER'
PRINT ''
PRINT ''
PRINT ''
select substring(srvname,1,25) as srvname,substring(providername,1,25) as providername,substring(datasource,1,25) as datasource,substring(srvnetname,1,25) as srvnetname
from sysservers where srvid = 0
PRINT ''
PRINT '--NOME DOS SERVIDORES DO NÓ CLUSTER'
PRINT ''
SELECT substring(NodeName,1,30) as NodeName FROM ::fn_virtualservernodes()
PRINT ''
PRINT '--DISCOS UTILIZADOS NO CLUSTER'
PRINT ''
SELECT * FROM ::fn_servershareddrives()
PRINT ''
GO
PRINT ''
/* PRINT '--IPS E PORTAS UTILIZADAS'
PRINT ''
select distinct substring(net_transport,1,20) as net_transport,substring(protocol_type,1,20) as protocol_type,
substring(auth_scheme,1,20) as auth_scheme,substring(client_net_address,1,20) as client_net_address,
substring(local_net_address,1,20) as local_net_address,local_tcp_port
from sysprocesses where net_transport = 'TCP'
PRINT ''
GO */
PRINT ''
PRINT '--LISTA DE BACKUP DEVICE'
PRINT ''
SELECT substring(name,1,30) as name , size, low, high, status, cntrltype,substring(phyname,1,30) as phyname 
from master..sysdevices
PRINT ''
GO
PRINT ''
PRINT '--LISTA DE LINKED SERVERS'
PRINT ''
select substring(srvname,1,25) as name,substring(providername,1,25) as provider,substring(srvproduct,1,25) as product, 
substring(datasource,1,25) as datasource, substring(providerstring,1,25) as providerstring,
substring(location,1,25) as location,substring(catalog,1,25) as catalog
from sysservers where srvid <> 0 order by 1
PRINT ''
GO 
PRINT ''
PRINT '--LISTA DE JOBS'
PRINT ''
select job.enabled,'###',substring(job.name,1,30),ste.step_id,substring(ste.step_name,1,30) as step_name,substring(ste.database_name,1,20) as database_name,
substring(job.description,1,70) as description,job.date_created,sch.next_run_date,sch.next_run_time,substring(ltrim(rtrim(ste.command)),1,100) as command
from msdb..sysjobs as job
INNER JOIN msdb..sysjobsteps AS ste on job.job_id = ste.job_id
INNER JOIN msdb..sysjobschedules AS sch on job.job_id = sch.job_id
ORDER BY 2
PRINT ''
GO
PRINT ''
