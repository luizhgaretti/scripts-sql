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
	-- AFTER especifica que o gatilho DML � disparado apenas quando todas as opera��es especificadas na instru��o SQL de gatilho s�o executadas com �xito. Todas as verifica��es de restri��o e a��es referenciais em cascata tamb�m devem obter �xito para que este gatilho seja disparado.
	-- AFTER � o padr�o quando FOR � a �nica palavra-chave especificada.
	-- Gatilhos AFTER N�O PODEM ser definidos em VIEWs.
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
	-- Especifica que o gatilho DML ser� executado em vez da instru��o SQL do Trigger.Substituindo assim as a��es das instru��es da Trigger. INSTEAD OF n�o pode ser especificado para TRIGGER DDL ou de logon.
	-- No m�ximo, um TRIGGER INSTEAD OF por instru��o INSERT, UPDATE ou DELETE pode ser definido em uma tabela ou View. Entretanto, voc� pode definir views sobre views, onde cada uma tem seu pr�prio TRIGGER INSTEAD OF.
	-- Os TRiggers INSTEAD OF n�o s�o permitidos em viewa atualiz�veis que usam WITH CHECK OPTION.
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
	-- Os Trigger DDL n�o s�o disparados em resposta a eventos que afetem tabelas tempor�rias locais ou globais e Stored Procedure
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

