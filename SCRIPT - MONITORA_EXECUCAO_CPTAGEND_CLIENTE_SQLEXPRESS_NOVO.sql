/****************************************************************************************************************
CONFIGURAR NO SQLEXPRESS
****************************************************************************************************************/

DECLARE @CLIENTE VARCHAR(50)
DECLARE @NICKNAME VARCHAR(100)
DECLARE @HOSTNAME VARCHAR(100)
DECLARE @IP VARCHAR(100)

SET @CLIENTE = 'VILLAR' -- DIGITE O NOME DO CLIENTE
SET @NICKNAME = 'villarsa' -- DIGITE O ALIAS DO CLIENTE

IF EXISTS (SELECT NAME FROM TEMPDB.SYS.TABLES WHERE NAME LIKE '%#TB_DBA_HOSTNAME%') BEGIN
	DROP TABLE #TB_DBA_HOSTNAME
END

IF EXISTS (SELECT NAME FROM TEMPDB.SYS.TABLES WHERE NAME LIKE '%#TB_DBA_IP%') BEGIN
	DROP TABLE #TB_DBA_IP
END

CREATE TABLE #TB_DBA_HOSTNAME (HOSTNAME VARCHAR(100))

INSERT INTO #TB_DBA_HOSTNAME EXECUTE MASTER..XP_CMDSHELL 'HOSTNAME'

SELECT @HOSTNAME = HOSTNAME FROM #TB_DBA_HOSTNAME WHERE HOSTNAME IS NOT NULL

CREATE TABLE #TB_DBA_IP (IP VARCHAR(800))

INSERT INTO #TB_DBA_IP EXECUTE MASTER..XP_CMDSHELL 'IPCONFIG'

SELECT @IP = IP FROM #TB_DBA_IP WHERE IP LIKE '%IPV4%'

insert into [200.158.216.85].monitordba.dbo.tb_monitor_cptagend
SELECT @cliente, @@SERVERNAME, @HOSTNAME, @IP, @NICKNAME, count(1)
from master.dbo.sysprocesses p
inner join master.dbo.sysdatabases d on d.dbid = p.dbid 
--and d.name like 'cptprocs%'
and p.program_name like '%cptagend.exe%'
where p.spid >= 50

/****************************************************************************************************************
CONFIGURAR NO 28.6
****************************************************************************************************************/

/* CRIAÇÃO DA TABELA
use monitordba
go

create table tb_monitor_cptagend
(
cliente varchar(50),
sqlinstance varchar(50),
sqlhostname varchar(50),
ipsql varchar(100),
nickname varchar (100),
nr_processos int
)
*/

-- SCRIPT AGENDADO NO 28.6 PARA SER EXECUTADO DE 5 EM 5 MINUTOS
DECLARE CUR_MON_CAPTA_PROCESSOS CURSOR
FOR
SELECT CLIENTE, SQLINSTANCE, SQLHOSTNAME, IPSQL, NICKNAME FROM tb_monitor_cptagend WHERE NR_PROCESSOS = 0

DECLARE @DBProfile VARCHAR(100),
		@CLIENTE VARCHAR(50),
		@SQLINSTANCE VARCHAR(50),
		@SQLHOSTNAME VARCHAR(50),
		@IPSQL VARCHAR(100),
		@NICKNAME VARCHAR(100),
		@NR_PROCESSOS INT,
		@STRING VARCHAR(50),
		@STRING2 VARCHAR(800)

SELECT @DBProfile=Name FROM msdb.dbo.sysmail_profile WHERE Profile_ID=1

OPEN CUR_MON_CAPTA_PROCESSOS
FETCH NEXT FROM CUR_MON_CAPTA_PROCESSOS INTO @CLIENTE, @SQLINSTANCE, @SQLHOSTNAME, @IPSQL, @NICKNAME

WHILE @@FETCH_STATUS = 0 BEGIN 
	SET @STRING = 'Capta Processos Parado no Cliente ' + '" ' + @CLIENTE + ' "'
	SET @STRING2 = 'Capta Processos parado: ' + CHAR(13) + CHAR(13) +
				'Instância do SQL Server: ' + @SQLINSTANCE + CHAR(13) + 
				'Hostname do SQL Server: ' + @SQLHOSTNAME + CHAR(13) + 
				'IP do SQL Server: ' + @IPSQL + CHAR(13) + 
				'Hostname do Capta Processos: ' + @NICKNAME + CHAR(13) + CHAR(13) +
				'Favor Verificar Urgente!'
	EXEC msdb.dbo.sp_send_dbmail  
		@profile_name = @DBProfile,
		@recipients='captamon@capta.com.br',
		@subject = @string,
		@body = @string2,   
		@body_format = 'text'
	FETCH NEXT FROM CUR_MON_CAPTA_PROCESSOS INTO @CLIENTE, @SQLINSTANCE, @SQLHOSTNAME, @IPSQL, @NICKNAME
END
DEALLOCATE CUR_MON_CAPTA_PROCESSOS

TRUNCATE TABLE monitordba..tb_monitor_cptagend