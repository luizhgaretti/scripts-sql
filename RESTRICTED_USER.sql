/*
******************************************************************************
				RESTRICTED_USER
Colocando o Banco de Dados em RESTRICTED_USER e terminando todas as conexões
******************************************************************************
*/

ALTER DATABASE Estudo
SET RESTRICTED_USER WITH ROLLBACK IMMEDIATE
GO