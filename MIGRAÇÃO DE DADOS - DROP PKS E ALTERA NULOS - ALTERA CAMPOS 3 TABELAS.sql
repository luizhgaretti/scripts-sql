--DROPA AS PKS PARA ALTERAR AS COLUNAS QUE NÃO ACEITAM NULOS
SELECT 'ALTER TABLE ' + T.NAME + ' DROP CONSTRAINT '  +  I.name
FROM SYS.indexes I
JOIN SYS.tables T ON T.object_id = I.object_id
WHERE T.type = 'U'
AND I.type = 1
and t.name not like 'mss%'
go

SELECT 'DROP INDEX ' +  I.name + ' ON ' + T.name
FROM SYS.indexes I
JOIN SYS.tables T ON T.object_id = I.object_id
WHERE T.type = 'U'
--AND I.type = 1
AND I.NAME IS NOT NULL
go

--ALTERA COLUNAS PARA ACEITAR NULO PARA NÃO DAR ERROS NA IMPORTAÇÃO DO MYSQL PARA O SQL
SELECT 'ALTER TABLE ' + T.NAME + ' ALTER COLUMN ' + C.name + ' ' + TY.name + ' NULL'
FROM SYSCOLUMNS C
JOIN SYS.tables T ON T.object_id = C.ID
JOIN SYS.types TY ON TY.user_type_id = C.xtype
--WHERE C.isnullable = 0
WHERE T.type = 'U'
--AND T.NAME = 'CHEQUE'
AND TY.name = 'DATE'


-------------------------------------------------------

--DROP OS DEFAULTS
SELECT 'ALTER TABLE ' + T.NAME + ' DROP CONSTRAINT ' + D.name
FROM SYS.tables T
JOIN   SYS.default_constraints D ON T.object_id = D.parent_object_id 
GO

--ALTERA AS COLUNAS PARA BIGINT
SELECT 'ALTER TABLE ' + T.NAME + ' ALTER COLUMN ' + C.name +  ' BIGINT'
FROM SYSCOLUMNS C
JOIN SYS.tables T ON T.object_id = C.ID
JOIN SYS.types TY ON TY.user_type_id = C.xtype
--WHERE C.isnullable = 0
WHERE T.type = 'U'
--AND T.NAME = 'CHEQUE'
AND TY.name = 'INT'
and t.name not like 'mss%'


-------------------------------------------------------

SELECT * FROM CONTAS

ALTER TABLE CONTAS ALTER COLUMN MASCARA VARCHAR(15) NULL
ALTER TABLE CONTAS ALTER COLUMN DESCRICAO VARCHAR(35) NULL
GO

/******************************************************************************/

SELECT * FROM cor_mostrador

ALTER TABLE COR_MOSTRADOR ALTER COLUMN NOME VARCHAR(50) NULL
GO

/******************************************************************************/

SELECT * FROM nota_transferencia

ALTER TABLE nota_transferencia ALTER COLUMN Observacao VARCHAR(30) NULL
ALTER TABLE nota_transferencia ALTER COLUMN FuncDestino VARCHAR(30) NULL
GO