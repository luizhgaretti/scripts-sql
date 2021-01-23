/*
	Script: Bloqueia acesso á um determinado usuário e aplicação.
*/


CREATE TRIGGER AuditLogonBackup
ON ALL SERVER FOR LOGON
AS
BEGIN
	IF (ORIGINAL_LOGIN() like 'userapp%') AND APP_NAME() LIKE 'Microsoft SQL Server Management Studio%' or APP_NAME() LIKE 'SQLCMD%'
	BEGIN
		ROLLBACK
   END
END
GO