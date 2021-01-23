-- Realizando o Backup --
Backup Database SIGP_Ipeas
 To Disk = 'E:\sigp_ipeas.bak'
 With Init,
 Stats=10
Go

-- Realizando e Restore Sobreescrevendo e Movendo os Arquivos --
Restore Database SIGP_Test
From Disk = 'E:\sigp_ipeas.bak'
With Replace, Recovery,
Stats=10,
Move 'SIGP_IPEAS' TO 'E:\MSSQL2005\Data\SIGP_TEST.mdf',
Move 'SIGP_IPEAS_log' To 'E:\MSSQL2005\Log\SIGP_TEST_log.ldf'
Go

-- Acessando o Banco de Dados --
USE SIGP_TEST
Go

-- Exclu�ndo o Usu�rio --
Drop User Sigp
go


-- Criando o Usu�rio com base no Login --
Create User Sigp From Login SIGP
Go


-- Adicionando o Usu�rio a RoleMember DB_Owner --
sp_addrolemember 'db_owner','dbo'

-- Definindo o Banco de Dados padr�o do Usu�rio --
Alter Login SIGP
 With Default_database = SIGP_IPEAS
Go

-- Mudando o Contexto para teste de Conex�o e Permiss�es --
Exec As User = 'SIGP'
Go

-- Confirmando a Mudan�a de Contexto --
Select User_Name()
Go


-- Criando a Tabela para teste de Permiss�o --
Create Table T1
(Codigo Int)
Go

-- Exclu�ndo a Tabela T1 para teste de Permiss�o --
Drop Table T1
Go

-- Fechando a Conex�o do Banco --
Use Master
Go