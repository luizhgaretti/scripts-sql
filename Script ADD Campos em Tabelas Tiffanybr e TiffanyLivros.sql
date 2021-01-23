/*
select OBJECT_NAME(c.id), c.name as coluna, t.name as type from sys.syscolumns c
join sys.types t on t.user_type_id = c.xusertype
where OBJECT_NAME(id) = 'slvcdajd'
order by c.name asc
*/


--Base ERP: (tiffanybr)

--Tabelas (slvcfo e slvcfo2)  - campos alterados tamanho

--slvcfo
alter table slvcfo alter column ajucreds char(10)
alter table slvcfo alter column ajudebs char(10)
alter table slvcfo alter column ajucredspn char(10)
alter table slvcfo alter column ajudcreds char(12)
alter table slvcfo alter column ajuddebs char(12)
alter table slvcfo alter column ajudcredsp char(12)

--slvcfo2
alter table slvcfo2 alter column ajucreds char(10)
alter table slvcfo2 alter column ajudebs char(10)
alter table slvcfo2 alter column ajucredspn char(10)
alter table slvcfo2 alter column ajudcreds char(12)
alter table slvcfo2 alter column ajuddebs char(12)
alter table slvcfo2 alter column ajudcredsp char(12)

--Tabela (slvcfouf) – campos alterados tamanho

--slvcfouf
alter table slvcfouf alter column codajdebs char(10)
alter table slvcfouf alter column codajcreds char(10)
alter table slvcfouf alter column codajdocdb char(12)
alter table slvcfouf alter column codajdoccr char(12)


/******************************************************************************************************/


--Base Livros: (tiffanylivros)

--Tabela (slvcdaj) 
--slvcdaj
drop index codigos on slvcdaj
go
alter table slvcdaj alter column codigos char(10) --remover antes o indice
go
create index codigos on slvcdaj (codigos)
go

alter table slvcdaj add codrecs char(10) not null default ''


--Tabela (slvcdajd)
--slvcdajd
drop index slvcdajd_codigos on slvcdajd
go
alter table slvcdajd alter column codigos char(12) --remover antes o indice
go
create index slvcdajd_codigos on slvcdajd (codigos)
go


--Tabela (slvricmi)
--slvricmi
alter table slvricmi alter column codajustes char(10)

--Tabela (slvricma)
--slvricma
alter table slvricma alter column codajustes char(10)

--tabela (slvricmd)
--slvricmd
alter table slvricmd alter column codajustes char(10)

alter table slvricmd alter column codajdoc char(12)
