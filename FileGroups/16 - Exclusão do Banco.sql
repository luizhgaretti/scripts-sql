-- Muda o contexto do banco de dados
USE Master

-- Elimina todas as conex�es da base
ALTER DATABASE BDSSD SET OFFLINE WITH ROLLBACK IMMEDIATE

-- Elimina a base de dados
DROP DATABASE BDSSD

-- Excluir arquivos no diret�rio

-- E agora ?