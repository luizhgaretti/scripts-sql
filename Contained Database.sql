/***************************************************
	Script: Cria��o do Contained Database
***************************************************/

EXEC sp_configure 'contained database authentication', 1
GO
RECONFIGURE
GO

CREATE DATABASE TesteContained
CONTAINMENT = PARTIAL
GO

CREATE USER User1
WITH PASSWORD=N'Wfarma6141'
GO

EXEC sp_addrolemember'db_owner', 'User1'
GO

-- Depois Connect alterando a Conex�o para se conectar direto no Banco