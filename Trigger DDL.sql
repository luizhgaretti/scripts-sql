Listagem 2. Exemplo de criação de um trigger de DDL.

CREATE TRIGGER ddl_trigger_drop_table 
ON DATABASE 
FOR DROP_TABLE
AS 
PRINT 'Você não pode excluir a tabela.!' 
ROLLBACK
GO

***********************************************************
Listagem 3. Trigger de DDL que impede a exclusão e alteração de tabelas.

USE AdventureWorks
GO

--Cria uma tabela de teste
IF OBJECT_ID('dbo.TBTESTEDDL') IS NOT NULL
DROP TABLE dbo.TBTESTEDDL
GO
CREATE TABLE dbo.TBTESTEDDL
(
ID	INT IDENTITY,
NOME	VARCHAR(30)
)
GO

--Cria uma trigger de DDL no banco de dados
IF (SELECT name FROM sys.triggers where name='DDL_DROP_ALTER_TABLE') IS NOT NULL
BEGIN
DROP TRIGGER DDL_DROP_ALTER_TABLE ON DATABASE
END
GO
CREATE TRIGGER DDL_DROP_ALTER_TABLE 
ON DATABASE 
FOR DROP_TABLE, ALTER_TABLE
AS 
PRINT 'Você não tem permissão para excluir ou alterar tabelas. Contate o administrador.'
ROLLBACK
GO

--Tenta excluir a tabela
DROP TABLE dbo.TBTESTEDDL
GO

-- Tenta alterar tabela
ALTER TABLE dbo.TBTESTEDDL
ALTER COLUMN NOME VARCHAR (40)

--Exclui os objetos criados
DROP TRIGGER DDL_DROP_ALTER_TABLE ON DATABASE
DROP TABLE dbo.TBTESTEDDL 
***********************************************************
Listagem 5. Trigger de DDL para imprimir o resultado da função EVENTDATA() para o evento CREATE TABLE.

CREATE TRIGGER DDL_PRINT_EVENTDATA 
ON DATABASE 
FOR CREATE_TABLE
AS 
DECLARE @data XML
SET @data = EVENTDATA()
PRINT CONVERT(varchar(5000),@data)
GO

-- Evento que dispara a trigger
CREATE TABLE TTTT(col1 int)
***********************************************************
Listagem 6. Trigger de DDL para monitorar todos os eventos do nível banco de dados.

USE AdventureWorks;
GO

-- Cria tabela de auditoria
CREATE TABLE tb_ddl_audit (Data_ocorr datetime, dbname nvarchar(50),
LoginName nvarchar(20),Objeto nvarchar(100),Evento nvarchar(100),TSQL nvarchar(2000))
GO

-- Cria trigger de DDL para monitorrar eventos do DATABASE
CREATE TRIGGER ddl_trigger_log 
ON DATABASE 
FOR DDL_DATABASE_LEVEL_EVENTS 
AS
DECLARE @data XML
SET @data = EVENTDATA()
INSERT tb_ddl_audit 
(Data_ocorr, dbname, LoginName,Objeto,Evento, TSQL) 
VALUES (GETDATE(), 
@data.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'nvarchar(100)'),
@data.value('(/EVENT_INSTANCE/LoginName)[1]', 'nvarchar(100)'),
@data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(100)'),
@data.value('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(100)'), 
@data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(2000)') ) 
GO
*************************************************************
Listagem 7. Script para testar a DDL Trigger.

-- O CREATE LOGIN está no nível SERVIDOR, portanto, não é capturado pela trigger
CREATE LOGIN ddl_teste WITH PASSWORD='ddl_teste123'

-- os eventos abaixo estão no nível DATABASE e serão capturados pela trigger
CREATE TABLE tb_teste (a int)
DROP TABLE tb_teste
CREATE USER ddl_teste
DROP USER ddl_teste 
GO

-- Verifica a tabela de auditoria.
-- Foi registrado os eventos de CREATE/DROP TABLE e CREATE/DROP USER
SELECT * FROM tb_ddl_audit
GO

-- Exclui os objetos criados
DROP TRIGGER ddl_trigger_log ON DATABASE
DROP TABLE tb_ddl_audit
DROP LOGIN ddl_teste
GO

