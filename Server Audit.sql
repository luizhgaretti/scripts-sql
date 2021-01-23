/****************************************************
	Script: Criando auditoria a nivel de Instancia
****************************************************/

USE Master
GO

-- Criando auditoria á nivel de Instancia
	-- Existem outras Opções que podem ser 
CREATE SERVER AUDIT Audit_CreateDatabase
TO FILE ( FILEPATH ='E:\Area de Manobra\Auditoria\') --TO APPLICATION_LOG | TO SECURITY_LOG
WITH (ON_FAILURE = CONTINUE) -- CONTINUE|SHUTDOWN|FAIL_OPERATION
GO

-- Criando Especificação da Auditoria a nivel de Servidor
	-- Exitem várias opções de especificações que podem ser auditadas, e podemos adicionar na mesma auditoria usando om ADD
CREATE SERVER AUDIT SPECIFICATION Audit_Especi_CreateDatabase
FOR SERVER AUDIT Audit_CreateDatabase
    ADD (DATABASE_CHANGE_GROUP);
GO

-- Habilitando Auditoria
ALTER SERVER AUDIT Audit_CreateDatabase
WITH (STATE = ON); -- OFF
GO

-- Habilitando a Specification
ALTER SERVER AUDIT SPECIFICATION Audit_Especi_CreateDatabase
WITH (STATE = ON); -- OFF
GO

-- Excluindo Auditoria e Specification
DROP SERVER AUDIT Audit_CreateDatabase -- Precisa estar OFF
GO
DROP SERVER AUDIT SPECIFICATION Audit_Especi_CreateDatabase -- Precisa estar OFF
GO

-- Visualizando o Log da Auditoria
SELECT * FROM sys.fn_get_audit_file (N'E:\Area de Manobra\Auditoria\*',default,default);
GO

-- Retorna tipos de Specifications
Select * From sys.dm_audit_actions

-- http://msdn.microsoft.com/pt-br/library/cc280663.aspx