/**************************************************************************************************
									Corrigindo usuarios orf�os
***************************************************************************************************/
--OBS:  Esse problema ocorre quando � feito restore de uma base em servidor diferente. E neste servidor
--		n�o existe os usuarios que existem no servidor que foi feito o backup


-- Lista Usuarios orf�os
EXEC sp_change_users_login 'Report'
GO

-- Corrige Usuarios orf�os
sp_change_users_login @Action='update_one', @UserNamePattern='Luiz1', @LoginName='Luiz1'
GO

sp_change_users_login @Action='update_one', @UserNamePattern='Luiz2', @LoginName='Luiz2'
GO

sp_change_users_login @Action='update_one', @UserNamePattern='Luiz3', @LoginName='Luiz3'
GO