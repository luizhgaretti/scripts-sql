--http://www.htmlstaff.org/ver.php?id=1976
--http://imasters.com.br/artigo/3949/sql-server/triggers-instead-of (OCORRE ANTES DO COMANDO ACONTECER)

use db
go

--drop table tb1
create table tb1
(
id int,
nome varchar(10),
nome2 varchar(10),
nome3 varchar(10),
nome4 varchar(10)
)

--drop table tb2
create table tb2
(
id int,
nome varchar(10),
nome2 varchar(10),
nome3 varchar(10),
nome4 varchar(10)
)

insert into tb1 values (1, 'a', 'b', 'c', 'd'),(2,'a', 'b', 'c', 'd'),(3, 'a', 'b', 'c', 'd'),(4, 'a', 'b', 'c', 'd')

select * from tb1

--DROP TRIGGER TR_UPDATE_INSERT
CREATE TRIGGER TR_UPDATE_INSERT
on TB1 
for update, insert
as
SELECT * into TB_INSERTED FROM INSERTED
--SELECT * into TB_DELETED FROM DELETED

delete from tb2
where id in (select id from TB_INSERTED)

insert into tb2
select * from TB_INSERTED
where id not in (select id from tb2)

/*
insert into tb2
select * from tb1
where id not in (select id from tb2)
*/

DROP TABLE TB_INSERTED
--DROP TABLE TB_DELETED
/*FIM DA TRIGGER*/



update tb1
set nome = 'AA'
where id = 4

insert into tb1 values (6, 'a', 'b', 'c', 'd')

select * from tb1
select * from tb2

--drop table TB_INSERTED
--select * from TB_INSERTED --DADOS_ATUAIS
--select * from TB_DELETED --'DADOS_ANTIGOS'


