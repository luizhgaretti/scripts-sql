
USE TSQL2012;
GO

--Configurações do Servidor
SELECT name, value, value_in_use, description
FROM sys.configurations
ORDER BY name;

-- View list of databases on instance
SELECT  name ,
        database_id ,
        create_date ,
        collation_name ,
        user_access ,
        user_access_desc ,
        state ,
        state_desc 
FROM sys.databases;



-- Lista de tabelas e Views
SELECT  s.name AS schemaname,
		t.name AS tablename ,
        t.object_id ,
        type_desc ,
        create_date
FROM sys.tables AS t
JOIN sys.schemas AS s
ON t.schema_id = s.schema_id
ORDER BY schemaname, tablename;



----------------------------------------
SELECT * FROM sys.types
SELECT * FROM sys.columns ORDER BY object_id, column_id


-------------------------------------------


-- Lista de colunas na respectiva tabela

SELECT  OBJECT_NAME(object_id) AS tablename,
        name AS columnname,
        column_id ,
		TYPE_NAME(user_type_id) AS typename,
        max_length ,
        collation_name        
FROM sys.columns
WHERE object_id = object_id('Sales.Customers');


-- Mostrar INFORMATION_SCHEMA views
SELECT  TABLE_CATALOG,TABLE_SCHEMA,TABLE_NAME,TABLE_TYPE
FROM    INFORMATION_SCHEMA.TABLES;

SELECT VIEW_CATALOG, VIEW_SCHEMA, VIEW_NAME, TABLE_CATALOG, TABLE_SCHEMA, TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.VIEW_COLUMN_USAGE;

-- 
SELECT @@VERSION AS SQL_Version;
SELECT SERVERPROPERTY('ProductVersion') AS version;
SELECT SERVERPROPERTY('Collation') AS collation;

/*************************************************************************************************

***************************************************************************************************/



-- Step 1: Open a new query window to the TSQL2012 database
USE TSQL2012;
GO

-- Step 2: Use System Stored Procedures (not supported on Azure)
-- Execute a stored procedure with no parameters
EXEC sys.sp_databases; 

-- Execute a stored procedure with a single parameters
EXEC sys.sp_help N'Sales.Customers';

-- Execute a stored procedure which accepts
-- multiple parameters
EXEC sys.sp_tables 
	@table_name = '%', 
	@table_owner = 'Sales';

-- Step 3: Return system language information
EXEC sys.sp_helplanguage;

-- Step 4: List stored procedures
-- Note: TSQL2012 db has no user procedures
-- so this will show system procedures only
-- For a result which includes user procedures,
-- Switch to AdventureWorks2008R2 if available
USE TSQL2012;
GO
EXEC sys.sp_stored_procedures;

-- Step 5: Optional demo to show filtering by schema
USE AdventureWorks2008R2;
GO
EXECUTE sys.sp_stored_procedures @sp_owner='HumanResources';


-- Step 1: Open a new query window to the TSQL2012 database
USE TSQL2012;
GO

-- Step 2:  List system objects
SELECT  name, type, type_desc
FROM sys.system_objects
WHERE name LIKE 'dm_%'
ORDER BY name;

USE master ;
GO
-- Step 3:  List DMVs
SELECT  name, type, type_desc
FROM sys.system_objects
WHERE name LIKE 'dm_%'
ORDER BY name;

-- Step 4:  Show information about all active user connections and internal tasks.
SELECT  session_id ,
        login_time ,
        host_name ,
        program_name ,
        login_name ,
        status ,
        cpu_time ,
        memory_usage ,
        last_request_start_time ,
        last_request_end_time ,
        reads ,
        writes ,
        logical_reads ,
        is_user_process ,
        language ,
        date_format ,
        row_count
FROM    sys.dm_exec_sessions
WHERE   program_name IS NOT NULL ;






--*******************************************************************************************
-- METADATA
--*******************************************************************************************

-- ===========================================
-- Retornando informações dos banco de dados
-- ===========================================
SELECT * FROM SYS.DATABASES
SELECT * FROM SYS.SYSDATABASES

-- ===========================================
-- Descobrindo os objetos do Banco
-- ===========================================

SELECT * FROM SYS.SYSOBJECTS 
WHERE TYPE = 'P'

SELECT * FROM SYS.TABLES 

SELECT * FROM SYS.VIEWS 


-- ===========================================
-- INFORMATION_SCHEMA
-- ===========================================

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = N'Product';

SELECT CONSTRAINT_NAME 
FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS 
WHERE CONSTRAINT_SCHEMA = 'PERSON'


SELECT * 
FROM INFORMATION_SCHEMA.VIEW_TABLE_USAGE 
WHERE VIEW_NAME = 'VEMPLOYEE'


-- ==========================================================
-- DMV e DMF
-- ==========================================================

-- *********************
-- SYS.DM_EXEC_REQUESTS 
-- *********************
SELECT COUNT(*) AS CNT, COMMAND 
FROM SYS.DM_EXEC_REQUESTS
GROUP BY COMMAND

-- ****************************
--SYS.DM_IO_VIRTUAL_FILE_STATS
-- ****************************
SELECT DATABASE_ID, NUM_OF_READS, NUM_OF_WRITES 
FROM SYS.DM_IO_VIRTUAL_FILE_STATS(DB_ID(N'ADVENTUREWORKS'),2);

-- *********************
-- SYS.DM_OS_SYS_INFO
-- *********************
SELECT CPU_COUNT, PHYSICAL_MEMORY_IN_BYTES, SQLSERVER_START_TIME
FROM SYS.DM_OS_SYS_INFO


-- ***************************
-- Procedures de Metadados
-- ***************************

-- #1 Retorna tamanho do banco de dados
sp_databases
sp_helpdb

-- #2 Retorna tabelas e seus owners
sp_tables

-- #3 Retorna informações sobre as colunas de uma tabela
sp_columns 'Address'

sp_help 'Person.Address'

-- #4 Estatísticas sobre a tabela
sp_statistics 'employee'

-- #5 Retornando PK e FK
sp_pkeys 'Department', 'HumanResources'
sp_fkeys 'Department', 'HumanResources'


-- ***************************
-- Funções de Metadados
-- ***************************

-- #1 Propriedades dos bancos
SELECT DATABASEPROPERTY('AdventureWorks2008','IsDboOnly')

-- #2 Propriedades de Tabelas
USE AdventureWorks;
GO
SELECT COLUMNPROPERTY( OBJECT_ID('Person.Contact'),'LastName','IsIndexable')
SELECT COLUMNPROPERTY( OBJECT_ID('Person.Contact'),'LastName','AllowsNull')
GO

-- #3 Propriedades de Objetos

USE AdventureWorks;
GO
SELECT OBJECTPROPERTY(OBJECT_ID('Person.Address'), 'IsTable');
GO


USE AdventureWorks;
GO
IF OBJECTPROPERTY (OBJECT_ID(N'Production.UnitMeasure'),'ISTABLE') = 1
   PRINT 'UnitMeasure é uma tabela.'
ELSE IF OBJECTPROPERTY (OBJECT_ID(N'Production.UnitMeasure'),'ISTABLE') = 0
   PRINT 'UnitMeasure Não é uma table.'
ELSE IF OBJECTPROPERTY (OBJECT_ID(N'Production.UnitMeasure'),'ISTABLE') IS NULL
   PRINT 'ERROR: UnitMeasure não é um objeto válido.';
GO


-- #3 Tamanho máximo das colunas

USE AdventureWorks;
GO
CREATE TABLE t1
   (c1 varchar(40),
    c2 nvarchar(40)
   );
GO
SELECT COL_LENGTH('t1','c1')AS 'VarChar',
      COL_LENGTH('t1','c2')AS 'NVarChar';
GO
DROP TABLE t1;


-- #4 Retornando o banco atual

select DB_NAME()

select DB_NAME(2)

select DB_ID('AdventureWorks2008')


----------------------------------------------------------------------