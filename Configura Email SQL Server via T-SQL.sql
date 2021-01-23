--habilita database email
sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
sp_configure 'Database Mail XPs', 1;
GO
RECONFIGURE
GO

--cria o perfil
if exists (select * from msdb..sysmail_profile where name = 'Alerta SQL')
exec msdb..sysmail_delete_profile_sp  @profile_name = 'Alerta SQL'
go
EXECUTE msdb.dbo.sysmail_add_profile_sp
       @profile_name = 'Alerta SQL',
       @description = 'Alerta SQL' ;

--cria o email
if exists (select * from msdb..sysmail_account where name = 'sql.server')
exec msdb..sysmail_delete_account_sp @account_name = 'sql.server'
go
EXECUTE msdb.dbo.sysmail_add_account_sp
    @account_name = 'sql.server',
    @description = 'sql.server',
    @email_address = 'sql.server@capta.com.br',
	@replyto_address = 'sql.server@capta.com.br', 
    @display_name = 'sql.server',
    @mailserver_name = 'mail.capta.com.br',
	@port = 25,
	@username = 'sql.server@capta.com.br',
    @password = '*&quest&*'

--adiciona o perfil a conta criada
EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = 'Alerta SQL',
    @account_name = 'sql.server',
	@sequence_number = null

--deixa o perfil publico como padrao
EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
    @principal_name = 'public',
    @profile_name = 'Alerta SQL',
    @is_default = 1 ;

--testa o envio do email
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Alerta SQL',
    @recipients = 'andre.kioshi@capta.com.br',
    @body = 'Teste de envio de email SQL Server OK',
    @subject = 'Teste Email SQL' ;
GO