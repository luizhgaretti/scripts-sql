/*
*****************************************************
		Utilizando RAISERROR
*****************************************************
*/

-- 1º EXEMPLO -> Granvando a mensagem no ERRORLOG
RAISERROR (‘Test Error’, 17, 1) WITH LOG




-- 2º EXEMPLO -> Retornando uma mensagem.
DECLARE @DBID INT;
SET @DBID = DB_ID();

DECLARE @DBNAME NVARCHAR(128);
SET @DBNAME = DB_NAME();

RAISERROR
    (N'The current database ID is:%d, the database name is: %s.',
    10, -- Severity.
    1, -- State.
    @DBID, -- First substitution argument.
    @DBNAME); -- Second substitution argument.
GO




-- 3º EXEMPLO -> Criando uma mensagm de erro personalizada e em seguida retornando.
EXECUTE sp_dropmessage 50005;
GO

EXECUTE sp_addmessage	50005, -- Message id number.
						10,		-- Severity.
						N'The current database ID is: %d, the database name is: %s.'; -- Message text
GO


DECLARE @DBID INT;
SET @DBID = DB_ID();

DECLARE @DBNAME NVARCHAR(128);
SET @DBNAME = DB_NAME();

RAISERROR (50005,
    10,			-- Severity.
    1,			-- State.
    @DBID,		-- First substitution argument.
    @DBNAME);	-- Second substitution argument.
GO