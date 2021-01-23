--como reconstruir o log (LDF), ou pq zuou ou pq ele não limpa convencionalmente
--sql2005-2008
ALTER DATABASE dbname set emergency --1º o banco tem que estar no modo emergency
go

SELECT NAME,STATE_DESC FROM SYS.DATABASES --verifica o estado do banco
WHERE name = 'dbname'
go

ALTER DATABASE teste REBUILD LOG ON (NAME=TESTE_log_old,FILENAME='D:\DBMSSQLSERVER\LOG\TESTE_log_new.ldf') --reconstroi o novo log
go

ALTER DATABASE teste set online --volta a base como online
go

SELECT NAME,STATE_DESC FROM SYS.DATABASES --verifica o estado do banco
WHERE name = 'dbname'
go

--sql2000
ALTER DATABASE teste set emergency --1º o banco tem que estar no modo emergency
go

SELECT NAME,STATE_DESC FROM SYS.DATABASES --verifica o estado do banco
WHERE name = 'dbname'
go

DBCC REBUILD_LOG ('dbname', 'D:\DBMSSQLSERVER\LOG\teste_log_new.ldf') --reconstroi o novo log
go

ALTER DATABASE dbaname set online --volta a base como online
go




OBS: Tbm seria possivel, parar o banco, detach no banco, deletar ou renomear o log e atachar de novo o mdf e o log reconstruiria de novo