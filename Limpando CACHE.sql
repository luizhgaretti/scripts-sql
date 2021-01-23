/*
*****************************************************************************
	Comando para Limpar Cache sem a necessidade de reiniciar a instancia
*****************************************************************************
*/


Use teste
-- O comando checkpoint faz um commit das transações que estão
-- em memória para o arquivo de dados.
CHECKPOINT
GO

DBCC DROPCLEANBUFFERS
GO

DBCC FREEPROCCACHE
GO