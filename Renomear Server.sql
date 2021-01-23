/*
	Renomear computador com instancia
*/

-- Para um computador renomeado que hospeda uma inst�ncia padr�o do SQL Server, execute os seguintes procedimentos:
sp_dropserver <old_name>;
GO
sp_addserver <new_name>, local;
GO
-- Reinicie a inst�ncia do SQL Server.



-- Para um computador renomeado que hospeda uma inst�ncia nomeada do SQL Server, execute os seguintes procedimentos:
sp_dropserver <old_name\instancename>;
GO
sp_addserver <new_name\instancename>, local;
GO
--Reinicie a inst�ncia do SQL Server.


-- Para verificar se a opera��o renomea��o foi conclu�da com �xito
Select @@SERVERNAME 
Select * from sys.servers

--- Link
	--http://technet.microsoft.com/pt-br/library/ms143799.aspx