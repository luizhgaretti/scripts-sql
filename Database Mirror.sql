/**************************************************************************
						PASSO a PASSO DATABASE MIRROING
****************************************************************************/

-- Conect no Servidor PRINCIPAL e execute o comando para criar o ENDPOINT
CREATE ENDPOINT ENDPOINT_MIRROR
STATE = STARTED
AS TCP(LISTENER_PORT = 1400, LISTENER_IP = ALL)
FOR DATA_MIRRORING (ROLE = PARTNER, AUTHENTICATION = WINDOWS NEGOTIATE,
ENCRYPTION = REQUIRED ALGORITHM RC4)



-- Conect no Servidor de ESPELHO e execute o comando para criar o ENDPOINT
CREATE ENDPOINT ENDPOINT_MIRROR
STATE = STARTED
AS TCP(LISTENER_PORT = 1450, LISTENER_IP = ALL)
FOR DATA_MIRRORING (ROLE = PARTNER, AUTHENTICATION = WINDOWS NEGOTIATE,
ENCRYPTION = REQUIRED ALGORITHM RC4)



-- Listando os Endpoints
Select * From sys.tcp_endpoints
Select * From sys.database_mirroring_endpoints


-- Concedendo permissão ao usuario luizhgr para conectar no ENDPOINT
-- Execute este comando no servidor PRINCIPAL e ESPELHO
GRANT CONNECT ON ENDPOINT::ENDPOINT_MIRROR TO [luizhgr]


-- Conect no PRINCIPAL e faça Backup FULL e de LOG do Banco de Dados
-- Conect no ESPELHO e restaure o Banco de Dados com a Opção NORECOVERY


-- Conect do PRINCIPAL e execute o comando
Alter Database [EstudoMCTS]
Set PARTNER = 'TCP://WKS308:1400'

-- Conect no ESPELHO e execute o comando
Alter Database [EstudoMCTS]
Set PARTNER = 'TCP://SQL2012:1450'