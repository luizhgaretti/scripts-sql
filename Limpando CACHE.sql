/*
*****************************************************************************
	Comando para Limpar Cache sem a necessidade de reiniciar a instancia
*****************************************************************************
*/


Use teste
-- O comando checkpoint faz um commit das transa��es que est�o
-- em mem�ria para o arquivo de dados.
CHECKPOINT
GO

DBCC DROPCLEANBUFFERS
GO

DBCC FREEPROCCACHE
GO