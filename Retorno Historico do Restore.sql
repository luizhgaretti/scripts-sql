/*
	Informações e Historico do Restore dos Bancos de Dados
*/


use msdb
go

Select * From RESTOREHISTORY
Order By restore_date desc