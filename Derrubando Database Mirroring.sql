Listagem 1. Script Transact-SQL para quebrar uma sessão de mirroring.

--Executar no servidor principal ou servidor espelho para desfazer o Mirror
ALTER DATABASE AdventureWorks SET PARTNER OFF

******************************************************
Listagem 2. Script Transact-SQL para executar o recover do DB espelho.

-- Rodar no Servidor espelho
RESTORE DATABASE AdventureWorks WITH RECOVERY

******************************************************