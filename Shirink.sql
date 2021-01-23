/*
	Utilizando Shirink
*/

Use afaria_cluster
dbcc shrinkfile (Afaria_PRD_Data, 14000)--reduzir o tamanho do banco



-- Diminuir tamanho do Arquivo de Dados e de Log (SHRINK FILE)
--  usando uma base de dados chamado: Exemplo

-- No Shrink deve usar o Logical Name, no exemplo abaixo é Exemplo_Log, vejo em:
-- Clicando no banco > propriety > files
BACKUP LOG Exemplo
WITH TRUNCATE_ONLY
DBCC SHRINKFILE (N'Exemplo_Log' , 0, TRUNCATEONLY)


--Shrink direto na Base
DBCC SHRINKFILE (N'Exemplo' , 0, TRUNCATEONLY)

--Autor: Antonio Alex
--Data.: 02/03/2008
--Email: pessoalex@hotmail.com
