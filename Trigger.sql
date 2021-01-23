/*
	TUDO SOBRE TRIGGER
*/

CREATE TABLE Produto
(
	ID		INT IDENTITY(1,1)  PRIMARY KEY,
	Nome	VARCHAR(30) NOT NULL,
	Data	DATETIME
)
GO

CREATE TABLE ProdutoHistorico
(
	ID		INT IDENTITY(1,1)  PRIMARY KEY,
	Nome	VARCHAR(30) NOT NULL,
	Data	DATETIME
)
GO


-- TRIGGER DML
	-- UPDATE, DELETE, INSERT
CREATE TRIGGER [ schema_name . ]trigger_name 
ON { table | view } 
[ WITH <dml_trigger_option> [ ,...n ] ]
{ FOR | AFTER | INSTEAD OF } 
{ [ INSERT ] [ , ] [ UPDATE ] [ , ] [ DELETE ] } 
[ NOT FOR REPLICATION ] 
AS { sql_statement  [ ; ] [ ,...n ] | EXTERNAL NAME <method specifier [ ; ] > }

<dml_trigger_option> ::=
    [ ENCRYPTION ]
    [ EXECUTE AS Clause ]

<method_specifier> ::= 
    assembly_name.class_name.method_name


-- Exemplo1 TRIGGER DML -> AFTER
	-- AFTER especifica que o gatilho DML é disparado apenas quando todas as operações especificadas na instrução SQL de gatilho são executadas com êxito. Todas as verificações de restrição e ações referenciais em cascata também devem obter êxito para que este gatilho seja disparado.
	-- AFTER é o padrão quando FOR é a única palavra-chave especificada.
	-- Gatilhos AFTER NÂO PODEM ser definidos em VIEWs.
CREATE TRIGGER dbo.TriggerDML01
ON Produto
WITH ENCRYPTION
AFTER INSERT, DELETE
AS
	INSERT  ProdutoHistorico (Nome, Data)
	Values ('AFTER', GETDATE())
/*
	insert ProdutoHistorico (Nome, Data)
	(Select Nome, GETDATE()From inserted)

	insert ProdutoHistorico (Nome, Data)
	(Select Nome, GETDATE()From deleted)*/
GO

INSERT PRODUTO (Nome,Data)
VALUES ('TESTE1', GETDATE())
GO

DELETE FROM PRODUTO
GO



-- Exemplo2 TRIGGER DML -> INSTEAD OF
	-- Especifica que o gatilho DML será executado em vez da instrução SQL do Trigger.Substituindo assim as ações das instruções da Trigger. INSTEAD OF não pode ser especificado para TRIGGER DDL ou de logon.
	-- No máximo, um TRIGGER INSTEAD OF por instrução INSERT, UPDATE ou DELETE pode ser definido em uma tabela ou View. Entretanto, você pode definir views sobre views, onde cada uma tem seu próprio TRIGGER INSTEAD OF.
	-- Os TRiggers INSTEAD OF não são permitidos em viewa atualizáveis que usam WITH CHECK OPTION.
CREATE TRIGGER dbo.TriggerDML02
ON Produto
WITH ENCRYPTION
INSTEAD OF INSERT
AS
	INSERT  ProdutoHistorico (Nome, Data)
	Values ('INSTEAD OF', GETDATE())
GO

INSERT Produto (Nome, Data)
VALUES ('Produto', GETDATE())
GO



-- Exemplo3 TRIGGER DDL - Escopo de BANCO DE DADOS
	-- CREATE, ALTER, DROP, GRANT, DENY, REVOKE e UPDATE STATISTICS
	-- Os Trigger DDL não são disparados em resposta a eventos que afetem tabelas temporárias locais ou globais e Stored Procedure
CREATE TRIGGER TriggerDDL01 
ON DATABASE 
FOR Alter_Table
AS 
	INSERT  ProdutoHistorico (Nome, Data)
	Values ('ALTER TABLE', GETDATE())   
GO

ALTER TABLE PRODUTO
ADD ColunaTeste1	INT NULL
GO

Select * from ProdutoHistorico



-- Exemplo4 TRIGGER DDL - Escopo de Servidor
CREATE TRIGGER TriggerDDL02
ON ALL SERVER 
FOR CREATE_DATABASE
AS 
	INSERT  ProdutoHistorico (Nome, Data)
	Values ('ALTER TABLE', GETDATE())
GO




-- Exemplo TRIGGER Logon
CREATE TRIGGER TriggerLogon
ON ALL SERVER WITH EXECUTE AS 'login_test'
FOR LOGON
AS
BEGIN
IF ORIGINAL_LOGIN()= 'login_test' AND
    (SELECT COUNT(*) FROM sys.dm_exec_sessions
            WHERE is_user_process = 1 AND
                original_login_name = 'login_test') > 3
    ROLLBACK;
END;

