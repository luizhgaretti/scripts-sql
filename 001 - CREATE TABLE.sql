--CREATE TABLEEEEE
create table sljbardc (codigos numeric(6,0) default 0 not null,emps char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,datas datetime null,status numeric(1,0) default 0 not null)

go

alter table sljbardc add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid() --FALTA CRIAR EM TODOS OS SERVERS APOS CRIAR NO RJ
go

alter table [sljbardc] with nocheck add constraint [sljbardc_codigos] primary key clustered (codigos) on [primary]

go

create  nonclustered index [codigos] on [sljbardc] (codigos) on [primary]

go

--CRIAR INIDICE NA COLUNA ROWGUID
create unique index MSmerge_index_339568389 on [sljbardc] (rowguid)
go

----------------------------------------------------

create table sljbardi (codigos numeric(6,0) default 0 not null,cbars numeric(8,0) default 0 not null,units numeric(11,2) default 0 not null,series char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,modelos char(2) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,notas char(9) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,dtemis datetime null,status numeric(1,0) default 0 not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cpros char(14) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)

go

alter table [sljbardi] add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go

alter table [sljbardi] with nocheck add constraint [sljbardi_cidchaves] primary key clustered (cidchaves) on [primary]

go

create  nonclustered index [codigos] on [sljbardi] (codigos) on [primary]

go

--CRIAR INIDICE NA COLUNA ROWGUID
create unique index MSmerge_index_339568389 on [sljbardi] (rowguid)
go