/*========================================================================================
						Restringir o Banco de Dados
========================================================================================*/
use master
go
alter database <nome do banco> set restricted_user with rollback immediate
go


/* ========================================================================================
						Voltar o Banco para o Modo normal
===========================================================================================*/
use master
go
alter database <nome do banco> set multi_user
go