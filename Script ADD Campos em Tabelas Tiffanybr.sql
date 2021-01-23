use tiffanybr
go

select top 1 * from SLJEMP2
select top 1 * from SLJEMPC2
select top 1 * from SLVCFO
select top 1 * from SLVCFO2



--rodar nos 3 bancos pq nao esta na replicacao
--tabela SLJEMP2
alter table SLJEMP2 add ninccprev numeric(1) not null default 0
alter table SLJEMP2 add cdreccprev char(6) not null default ''
alter table SLJEMP2 add tplucros numeric(1) not null default 0

--rodar nos 3 bancos pq nao esta na replicacao
--tabvela SLJEMPC2
alter table SLJEMPC2 add ninccprev numeric(1) not null default 0
alter table SLJEMPC2 add cdreccprev char(6) not null default ''
alter table SLJEMPC2 add tplucros numeric(1) not null default 0

/**************************************************************************************************/

--rodar so no banco publicador
--tabela SLVCFO
alter table SLVCFO add envspedpcs numeric(1) not null default 0
alter table SLVCFO add ninccprev numeric(1) not null default 0
alter table SLVCFO add ativecons char(8) not null default ''
alter table SLVCFO add aliqcprevs numeric(8,4) not null default 0
alter table SLVCFO add codtpdet char(8) not null default ''

--rodar so no banco publicador
--tabela SLVCFO2
alter table SLVCFO2 add envspedpcs numeric(1) not null default 0
alter table SLVCFO2 add ninccprev numeric(1) not null default 0
alter table SLVCFO2 add ativecons char(8) not null default ''
alter table SLVCFO2 add aliqcprevs numeric(8,4) not null default 0
alter table SLVCFO2 add codtpdet char(8) not null default ''