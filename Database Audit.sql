/********************************************************
	Script: Criando auditoria a nivel de Banco De Dados
********************************************************/

USE Master
GO

-- Criando auditoria á nivel de Instancia
	-- Existem outras Opções que podem ser 
CREATE SERVER AUDIT Audit_CreateDropTable
TO FILE ( FILEPATH ='E:\Area de Manobra\Auditoria\') --TO APPLICATION_LOG | TO SECURITY_LOG
WITH (ON_FAILURE = CONTINUE) -- CONTINUE|SHUTDOWN|FAIL_OPERATION
GO

-- Criando Specification á nivel de Banco de Dados
CREATE DATABASE AUDIT SPECIFICATION AuditSpecificationBD
FOR SERVER AUDIT Audit_CreateDatabase
ADD (DATABASE_OBJECT_CHANGE_GROUP)
/*ADD (SELECT , INSERT
     ON HumanResources.EmployeePayHistory BY dbo)*/
WITH (STATE = ON) ;
GO

-- Habilitando / Desabilitando
ALTER SERVER AUDIT SPECIFICATION Audit_Especi_CreateDatabase
WITH (STATE = ON); -- OFF
GO

ALTER SERVER AUDIT SPECIFICATION AuditSpecificationBD
WITH (STATE = ON); -- OFF
GO

-- Dropando
DROP SERVER AUDIT Audit_CreateDropTable -- Precisa estar OFF
GO
DROP SERVER AUDIT SPECIFICATION AuditSpecificationBD -- Precisa estar OFF
GO


-- http://msdn.microsoft.com/pt-br/library/cc280663.aspx
