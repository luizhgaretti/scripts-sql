/*
	Rotina, Verifica Status do Mirror e envia E-mail
*/

Select * --DB.name, mirroring_state, mirroring_state_desc, mirroring_role_desc, 
Select * From sys.Database_Mirroring DM 
	Inner Join Sys.sysdatabases DB
	ON DM.database_id = DB.dbid
Where DM.mirroring_guid is not null



/*
	Rotina, Verifica Status Endpoint e envia E-mail
*/
If ((Select state_desc From sys.database_mirroring_endpoints) <> 'STARTED')
Begin
	Declare	@Status varchar(15),
			@Endpoint varchar(30),
			@Aux	varchar(80)
	Set @Status = (Select State_Desc From sys.database_mirroring_endpoints)
   Set @Endpoint = (Select Name From sys.database_mirroring_endpoints)
	Set @Aux = 'Status do Endpoint(' + @Endpoint + ') Foi Alterado para ' + @Status

	EXEC msdb.dbo.Sp_Send_DBmail
    @profile_name = 'Luiz',
    @recipients = 'luizhgr@rgm.com.br',
    @subject = 'Status Endpoint - Database Mirror',
	@Body = @Aux
End