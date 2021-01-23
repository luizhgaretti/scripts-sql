	EXEC msdb.dbo.Sp_Send_DBmail
    @profile_name = 'Luiz',
    @recipients = 'luizhgr@rgm.com.br',
    @subject = 'Status Endpoint - Database Mirror',
	@Body = @Aux