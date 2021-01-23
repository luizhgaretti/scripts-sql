/********************************************************************************
					Tudo Sobre Logins/Usuarios
*********************************************************************************/

-- Create LOGIN SQL Server
Create Login Teste With Password = 'Teste123'
GO

-- Create LOGIN de AD
Create Login [PARAISO\Rafaelws] From Windows
With Default_Database = DW
GO

-- Create USUARIO baseado no Logins
Use SeuBD
GO
CREATE USER [PARAISO\Rafaelws] FOR LOGIN [PARAISO\Rafaelws]
GO

-- Adicionando á uma Role de Banco de Dados
Use SeuBD
GO
ALTER ROLE [db_owner] ADD MEMBER [PARAISO\Rafaelws]
GO

-- Adicionando a uma Role de Servidor
Alter Server Role sysadmin
add member  [PARAISO\Rafaelws]
GO

-- Dropando de uma Role de Servidor
Alter Server Role sysadmin
Drop member  [PARAISO\Rafaelws]
GO