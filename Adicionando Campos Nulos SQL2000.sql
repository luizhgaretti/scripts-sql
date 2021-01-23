--Adicionando Campos Nulos SQL2000
--No SQL2005-2008, vc consegue ins inserir desta forma:

alter table SLJPTESP add dtbaixa datetime not null

--No SQL2000, vc nao consegue, ai vc tem que fazer da seguinte forma:

alter table SLJPTESP add dtbaixa datetime not null default ''

--ou
alter table SLJPTESP add dtbaixa datetime
alter table SLJPTESP alter column dtbaixa datetime not null