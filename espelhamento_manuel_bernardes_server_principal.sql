-- Drop key master
use master 

drop master key 
drop certificate Server_P_Cert 
drop user Server_M1_User 
drop login Server_M1_Login
drop certificate Server_M1_Cert
go

-- configuration Server Principal

BACKUP DATABASE coliseu TO DISK='d:\coliseu_dados.BAK' WITH INIT

GO

BACKUP LOG coliseu TO DISK='d:\coliseu_TRL.BAK' WITH INIT

go

-- Cerficate Server Principal
create master key encryption by password = 'cpt@2001';
GO 

create certificate Server_P_Cert with subject = 'Server_P certificate', start_date = '2007/11/01', expiry_date = '2020/11/01';
GO 

IF EXISTS (SELECT name FROM sys.database_mirroring_endpoints WHERE name='endpoint_mirroring')

  DROP ENDPOINT endpoint_mirroring

Go
 
Create endpoint endpoint_mirroring state = started
as tcp(listener_port = 5022, listener_ip = all)
for database_mirroring (authentication = certificate Server_P_Cert, encryption = disabled, role = all);
GO 

Backup certificate Server_P_Cert to file = 'd:\Server_P_Cert.cer';
GO

create login Server_M1_Login with PASSWORD = 'cpt@2001';
GO 

create user Server_M1_User from login Server_M1_Login;
GO 

Create certificate Server_M1_Cert
Authorization Server_M1_User
From file = 'd:\Server_M1_Cert.cer';
GO 

Grant CONNECT ON Endpoint::endpoint_mirroring to [Server_M1_Login];
GO

 
go


alter database mb set partner = 'TCP://192.168.21.5:5022';

