Fa�a o seguinte:

1 - Conecta-se ao SQL Server no banco Master.

2  - Execute este scritp: 

sp_configure 'allow updates',1
reconfigure with override

3 - Depois execute este outro script:

Update sysdatabases set status =32768 where name ='SeuBanco'

4 - Ap�s mudar o status do banco para Emergency Mode, � necess�rio reconstruir o log de transa��es, utilize o DBCC rebuild_log:

Dbcc Rebuild_log ('NomedoSeuBanco','CaminhodoseuArquivodeLog') 

5 - Agora para finalizar a recupera��o do banco, � necess�rio realizar os seguintes procedimento para recupera��o de dados corrompidos e tamb�m para verificar a integridade dos dados comprometidos.

Use SeuBanco
go

sp_dboption 'SeuBanco', 'dbo use only', false
go

sp_dboption 'SeuBanco','single_user', true
go

dbcc checkdb ('SeuBanco',repair_allow_data_loss)
go



6 - Ap�s realizar este procedimento o seu banco j� dever� esta em estado normal, agora � necess�rio voltar a forma de acesso ao banco para multiuso:

Use SeuBanco
go

sp_dboption 'SeuBanco','single_user', false
go

sp_dboption 'SeuBanco', 'dbo use only', true
go


7 - Agora, vamos bloquear a permiss�o de altera��o as table de sistema, fa�a o seguinte:

sp_configure 'allow updates',0
reconfigure with override