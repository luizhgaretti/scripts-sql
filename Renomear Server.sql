/*
	Renomear computador com instancia
*/

-- Para um computador renomeado que hospeda uma instância padrão do SQL Server, execute os seguintes procedimentos:
sp_dropserver <old_name>;
GO
sp_addserver <new_name>, local;
GO
-- Reinicie a instância do SQL Server.



-- Para um computador renomeado que hospeda uma instância nomeada do SQL Server, execute os seguintes procedimentos:
sp_dropserver <old_name\instancename>;
GO
sp_addserver <new_name\instancename>, local;
GO
--Reinicie a instância do SQL Server.


-- Para verificar se a operação renomeação foi concluída com êxito
Select @@SERVERNAME 
Select * from sys.servers

--- Link
	--http://technet.microsoft.com/pt-br/library/ms143799.aspx