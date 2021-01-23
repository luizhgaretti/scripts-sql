------------ Passo a Passo para Configurar Mirror com Certificado -----------------

-- NO PRINCIPAL
/* Execute this against the Principal Instance */
USE MASTER
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Password!'
GO

CREATE CERTIFICATE HOST_PRIN_cert
    WITH SUBJECT = 'HOST_PRIN certificate',
    START_DATE = '01/01/2013'
GO

CREATE ENDPOINT End_Mirroring
    STATE = STARTED
    AS TCP (LISTENER_PORT = 5022, LISTENER_IP = ALL)
    FOR DATABASE_MIRRORING
    (
        AUTHENTICATION = CERTIFICATE HOST_PRIN_cert,
        ENCRYPTION = REQUIRED ALGORITHM RC4,
        ROLE = ALL
    )
GO

BACKUP CERTIFICATE HOST_PRIN_cert
    TO FILE = 'D:\certificate\HOST_PRIN_cert.cer'
GO



-- NO MIRROR
/* Execute this against the Mirror Instance */
USE master
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Password!'
GO

CREATE CERTIFICATE HOST_MIRR_cert
    WITH SUBJECT = 'HOST_MIRR certificate',
    START_DATE = '01/01/2013'
GO

CREATE ENDPOINT End_Mirroring
    STATE = STARTED
    AS TCP (LISTENER_PORT = 5023, LISTENER_IP = ALL)
    FOR DATABASE_MIRRORING
    (
        AUTHENTICATION = CERTIFICATE HOST_MIRR_cert,
        ENCRYPTION = REQUIRED ALGORITHM RC4,
        ROLE = ALL
    )
GO

BACKUP CERTIFICATE HOST_MIRR_cert 
    TO FILE = 'D:\certificate\HOST_MIRR_cert.cer';
GO



-- NO PRINCIPAL
/* 
*  Execute this against the Principal Instance. The HOST_MIRR_cert.cer
*  needs to be copied on the Principal Server.
*/
USE MASTER
GO

/*
*  We are creating a SQL Login here. For Windows logins,
*  use the Grant Login instead of Create Login
*/
CREATE LOGIN HOST_MIRR_login WITH PASSWORD = 'Password!'
GO

CREATE USER HOST_MIRR_user FOR LOGIN HOST_MIRR_login
GO

CREATE CERTIFICATE HOST_MIRR_cert
    AUTHORIZATION HOST_MIRR_user
    FROM FILE = 'D:\certificate\HOST_MIRR_cert.cer'
GO

GRANT CONNECT ON ENDPOINT::End_Mirroring TO [HOST_MIRR_login]
GO




-- NO MIRROR
/* 
*  Execute this against the Mirror Instance. The HOST_PRIN_cert.cer
*  needs to be copied on the Mirror Server.
*/
USE MASTER
GO
/*
*  We are creating a SQL Login here. For Windows logins, 
*  use the Grant Login instead of Create Login
*/
CREATE LOGIN HOST_PRIN_login WITH PASSWORD = 'Password!'
GO

CREATE USER HOST_PRIN_user FOR LOGIN HOST_PRIN_login
GO

CREATE CERTIFICATE HOST_PRIN_cert
    AUTHORIZATION HOST_PRIN_user
    FROM FILE = 'D:\certificate\HOST_PRIN_cert.cer'
GO

GRANT CONNECT ON ENDPOINT::End_Mirroring TO [HOST_PRIN_login]
GO



-- NO WITNESS
/* Execute this against the Witness Instance */
USE MASTER
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Password!'
GO

CREATE CERTIFICATE HOST_WITT_cert
    WITH SUBJECT = 'HOST_WITT certificate',
    START_DATE = '01/01/2013'
GO

CREATE ENDPOINT End_Mirroring
    STATE = STARTED
    AS TCP (LISTENER_PORT = 5024, LISTENER_IP = ALL)
    FOR DATABASE_MIRRORING
    (
        AUTHENTICATION = CERTIFICATE HOST_WITT_cert,
        ENCRYPTION = REQUIRED ALGORITHM RC4,
        ROLE = Witness
    )
GO

BACKUP CERTIFICATE HOST_WITT_cert
    TO FILE = 'D:\certificate\HOST_WITT_cert.cer'
GO



-- NO PRINCIPAL
/*
*  Execute this against the Principal Instance. The HOST_WITT_cert.cer
*  needs to be copied on the Principal Server.
*/
USE MASTER
GO

/*
*  We are creating a SQL Login here. For Windows logins,
*  use the Grant Login instead of Create Login
*/
CREATE LOGIN HOST_WITT_login WITH PASSWORD = 'Password!'
GO

CREATE USER HOST_WITT_user FOR LOGIN HOST_WITT_login
GO

CREATE CERTIFICATE HOST_WITT_cert
    AUTHORIZATION HOST_WITT_user
    FROM FILE = 'D:\certificate\HOST_WITT_cert.cer'
GO

GRANT CONNECT ON ENDPOINT::End_Mirroring TO [HOST_WITT_login]
GO



-- NO MIRROR
/*
*  Execute this against the Mirror Instance. The HOST_WITT_cert.cer
*  needs to be copied on the Mirror Server.
*/
USE MASTER
GO

/*
*  We are creating a SQL Login here. For Windows logins,
*  use the Grant Login instead of Create Login
*/
CREATE LOGIN HOST_WITT_login WITH PASSWORD = 'Password!'
GO

CREATE USER HOST_WITT_user FOR LOGIN HOST_WITT_login
GO

CREATE CERTIFICATE HOST_WITT_cert
    AUTHORIZATION HOST_WITT_user
    FROM FILE = 'D:\certificate\HOST_WITT_cert.cer'
GO

GRANT CONNECT ON ENDPOINT::End_Mirroring TO [HOST_WITT_login]
GO



-- NO WITNESS
/*
*  Execute this against the Witness Instance. The HOST_PRIN_cert.cer
*  and HOST_MIRR_cert.cer needs to be copied on the Witness Server.
*/
USE MASTER
GO

/*
*  We are creating a SQL Login here. For Windows logins,
*  use the Grant Login instead of Create Login
*/
CREATE LOGIN HOST_PRIN_login WITH PASSWORD = 'Password!'
GO

CREATE USER HOST_PRIN_user FOR LOGIN HOST_PRIN_login
GO

CREATE CERTIFICATE HOST_PRIN_cert
    AUTHORIZATION HOST_PRIN_user
    FROM FILE = 'D:\certificate\HOST_PRIN_cert.cer'
GO

GRANT CONNECT ON ENDPOINT::End_Mirroring TO [HOST_PRIN_login]
GO

/*
*  We are creating a SQL Login here. For Windows logins,
*  use the Grant Login instead of Create Login
*/
CREATE LOGIN HOST_MIRR_login WITH PASSWORD = 'Password!'
GO

CREATE USER HOST_MIRR_user FOR LOGIN HOST_MIRR_login
GO

CREATE CERTIFICATE HOST_MIRR_cert
AUTHORIZATION HOST_MIRR_user
FROM FILE = 'D:\certificate\HOST_MIRR_cert.cer'
GO

GRANT CONNECT ON ENDPOINT::End_Mirroring TO [HOST_MIRR_login]
GO



-- NO PRINCIPAL
/*
*  Execute this against the Principal Instance.
*/
USE MASTER
GO

BACKUP DATABASE MirrorDB
    TO DISK = 'D:\Backups\MirrorDB_FullBackup.bak'
GO

BACKUP LOG MirrorDB
    TO DISK = 'D:\Backups\MirrorDB_LogBackup.trn'
GO



-- NO MIRROR
/*
*  Copy MirrorDB_FullBackup.bak and MirrorDB_LogBackup.trn to the
*  Mirror Server.
*  Execute this against the Mirror Instance.
*/
USE MASTER
GO

RESTORE DATABASE MirrorDB
    FROM DISK = 'D:\Backups\MirrorDB_FullBackup.bak'
    WITH NORECOVERY
GO

RESTORE LOG MirrorDB
    FROM DISK = 'D:\Backups\MirrorDB_LogBackup.trn'
    WITH NORECOVERY
GO



-- NO MIRROR
/*
*  Execute this against the Mirror Instance.
*/
ALTER DATABASE MirrorDB
    SET PARTNER = 'TCP://<<your principal server name here>>:5022'
--	SET PARTNER = 'TCP://server01:5022'
GO



-- NO PRINCIPAL
/*
*  Execute this against the Principal Instance.
*/
ALTER DATABASE MirrorDB
    SET PARTNER = 'TCP://<<your mirror server name here>>:5023'
--	SET PARTNER = 'TCP://vm02:5023'
GO

ALTER DATABASE MirrorDB
    SET WITNESS = 'TCP://<<your witness server name here>>:5024'
--	SET WITNESS = 'TCP://vm01:5024'
GO




--------------------
-- Liks http://blogs.msdn.com/b/suhde/archive/2009/07/13/step-by-step-guide-to-configure-database-mirroring-between-sql-server-instances-in-a-workgroup.aspx