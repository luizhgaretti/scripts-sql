/*
************************************************************
					SIMULANDO DEADLOCK

Autor: Luiz Henrique
Data: 26/04/2013
Descrição: Simulando um DeadLock e exibindo no Profile
************************************************************
*/


-- Criando Estrutura (Database e Tables)
Create Database EstudoDeadLock
GO

Use EstudoDeadLock
GO

Create Table DeadkLock1
(
	Campo1	Int Primary Key Identity
	Campo2	Int
)
GO

Create Table DeadkLock2
(
	Campo1	Int Primary Key Identity
	Campo2	Int
)
GO



-- Inserindo Dados
Insert DeadkLock1 (Campo2)
Values (1), (2),(3)
GO


Insert DeadkLock2 (Campo2)
Values (1), (2),(3)
GO


-- Bom agora... Simulando o DeadLock
-- Abra uma nova Query(Janela1) e Execute o Comando a baixo:
Set Transaction Isolation Level serializable
GO
Begin Transaction
Update DeadLock1 Set Campo = 100
Where ID = 1


-- Abra uma nova Query(Janela2) e Execute o Comando a baixo:
Set Transaction Isolation Level serializable
GO
Begin Transaction
Update DeadLock2 Set Campo = 300
Where ID = 1

Select * From DeadLock1
Where ID = 1


-- Volte para a Janela1 e execute o codigo a baixo:
Select * from DeadLock2
Where ID = 1


-- Pronto a merda tá feita.


-- Olhe o Profile
	-- Contador DeadLock Graph 


-- Script para Analise
Select * From sys.dm_exec_requests t1
CROSS APPLY sys.dm_exec_sql_text(t1.sql_handle) AS t2
CROSS APPLY sys.dm_exec_query_plan(t1.plan_handle) AS qp


Select * from sys.sysprocesses

sp_who