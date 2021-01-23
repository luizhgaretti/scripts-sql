USE MASTER
GO

-- Habilita o Resource Governor
ALTER RESOURCE GOVERNOR RECONFIGURE;
GO

--DROP RESOURCE POOL Pool_Super_Chefe
CREATE RESOURCE POOL Pool_Super_Chefe
  WITH (MAX_CPU_PERCENT = 100)
GO

--DROP WORKLOAD GROUP Group_Super_Chefe
CREATE WORKLOAD GROUP Group_Super_Chefe
 USING Pool_Super_Chefe
GO

--DROP RESOURCE POOL Pool_Estagiario
CREATE RESOURCE POOL Pool_Estagiario
  WITH (MAX_CPU_PERCENT = 100)
GO

--DROP WORKLOAD GROUP Group_Estagiario
CREATE WORKLOAD GROUP Group_Estagiario
 USING Pool_Estagiario
GO

-- DROP LOGIN Joaozinho
CREATE LOGIN Joaozinho WITH PASSWORD = '102030', CHECK_POLICY = OFF
GO

-- DROP LOGIN [Admin]
CREATE LOGIN [Admin] WITH PASSWORD = '102030', CHECK_POLICY = OFF
GO


/*
ALTER RESOURCE GOVERNOR WITH (CLASSIFIER_FUNCTION = NULL)
ALTER RESOURCE GOVERNOR RECONFIGURE
*/

DROP FUNCTION dbo.Func_Classifica
GO

CREATE FUNCTION dbo.Func_Classifica()
RETURNS SYSNAME
WITH SCHEMABINDING -- SCHEMA BINDING IS REQUIRED
AS
BEGIN
  DECLARE @Group NVarChar(40)

  IF SUSER_NAME() like 'Joaozinho'
    SET @Group = 'Group_Estagiario'

  IF SUSER_NAME() like 'Admin'
    SET @Group = 'Group_Super_Chefe'

  RETURN @Group
END
GO

-- Altera o RESOURCE GOVERNOR para usar a função criada.
ALTER RESOURCE GOVERNOR WITH (CLASSIFIER_FUNCTION = dbo.Func_Classifica)
ALTER RESOURCE GOVERNOR RECONFIGURE

-- Abrir performance monitor e analisar os contadores do MSSQL$SQL2008R2:WorkLoad Group Stats

-- Abrir sessões e logar com os usuários criados. Criar um loop infinito para gastar CPU.
/* Loop

DECLARE @I INT = 0, @TESTE INT

WHILE @I < 1
BEGIN
  SET @TESTE = CHECKSUM(NEWID())
END

*/

-- Query para verificar para qual Resorce Group os usuários foram mapeados
select a.session_id, a.original_login_name, a.group_id, b.name
  from sys.dm_exec_sessions a
 inner join sys.dm_resource_governor_workload_groups b
    on a.group_id = b.group_id
 where session_id > 50


ALTER RESOURCE POOL Pool_Super_Chefe WITH(MAX_CPU_PERCENT = 90)
GO
ALTER RESOURCE POOL Pool_Estagiario WITH(MAX_CPU_PERCENT = 10)
GO
ALTER RESOURCE GOVERNOR RECONFIGURE