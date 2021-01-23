-- Drop key master
use master 

drop master key 
drop certificate Server_M1_Cert 
drop user Server_P_User 
drop login Server_P_Login
drop certificate Server_P_Cert

drop master key 
go


-- Configuration Server Mirror
RESTORE DATABASE coliseu FROM DISK='d:\databases\backup\coliseu_dados.BAK' WITH REPLACE,NORECOVERY,

MOVE 'new_coliseu3' TO 'd:\databases\coliseu_Data.mdf',

MOVE 'new_coliseu3_log' TO 'd:\databases\coliseu_Log.ldf'

go
restore log coliseu from disk='d:\databases\backup\coliseu_TRL.bak' with norecovery


-- Certificate Server Mirror
create master key encryption by password = 'cpt2001';
GO 

create certificate Server_M1_cert with subject = 'Server_M1 certificate', start_date = '2007/11/01', expiry_date = '2020/11/01';
GO 

IF EXISTS (SELECT name FROM sys.database_mirroring_endpoints WHERE name='endpoint_mirroring')

  DROP ENDPOINT endpoint_mirroring

Go

Create endpoint endpoint_mirroring state = started
as tcp(listener_port = 5022, listener_ip = all)
for database_mirroring (authentication = certificate Server_M1_cert, encryption = disabled, role = all);
GO
Backup certificate Server_M1_cert to file = 'd:\Server_M1_cert.cer';
go
create login Server_P_Login with PASSWORD = 'cpt2001';
GO 

create user Server_P_User from login Server_P_Login;
GO 

Create certificate Server_P_Cert
Authorization Server_P_User
From file = 'd:\Server_P_Cert.cer';
GO 

Grant CONNECT ON Endpoint::endpoint_mirroring to [Server_P_Login];
GO

 
go
alter database coliseu set partner = 'TCP://192.168.1.2:5022';

GO 



