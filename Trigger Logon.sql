Alter Trigger Acesso_Limitado
On ALL Server With Execute as 'sa' For Logon
As
Begin
	IF (((Select sysadmin From sys.syslogins Where sid = SUSER_SID(ORIGINAL_LOGIN())) = 0) and ((Select ServerProperty('IsSingleUser')) = 1))
	Begin
		Rollback
	End
	
	Declare @aux varchar(100) = (Select ORIGINAL_LOGIN())
	Commit
	
	IF ((Select ORIGINAL_LOGIN()) <> 'sa')
	Begin
		Exec master..sp_dropsrvrolemember @loginame = @aux, @rolename = N'sysadmin'
	End
	Revert
End