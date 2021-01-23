alter table sljche alter column notas char(9) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table sljcserv add cfopservs char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
create  nonclustered index [anos] on [sljeestm] (anos) on [primary]
go
create  nonclustered index [cpfs] on [sljeestm] (cpfs) on [primary]
go
create  nonclustered index [empdopnums] on [sljeestm] (empdopnums) on [primary]
go
create  nonclustered index [mes] on [sljeestm] (mes) on [primary]
go
alter table [sljeestm] with nocheck add constraint [sljeestm_cidchaves] primary key clustered (cidchaves) on [primary]
go
alter table sljemp2 add cfopserv char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljempc2 add cfopserv char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljgccr add deptopads char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljgdmi alter column icms numeric(11,2)  not null
go
alter table sljmdsc add hab1vends numeric(1,0) default 0 not null
go
alter table sljmdsc add qtvezs numeric(3,0) default 0 not null
go
alter table sljmdsc add vmaxdes numeric(9,2) default 0 not null
go
alter table sljmdsc add ctrlutlzs numeric(1,0) default 0 not null
go
create  nonclustered index [skgroup1] on [sljope] (tipoops,dopes) on [primary]
go
create  nonclustered index [skgroup2] on [sljope] (dopes,tipoops,transs,ctipomarms) on [primary]
go
create  nonclustered index [skgroup4] on [sljope] (dopes,tipoops,abrevs) on [primary]
go
create  nonclustered index [tipoops] on [sljope] (tipoops) on [primary]
go
alter table sljorg add tpdocs numeric(1,0) default 0 not null
go
alter table sljpara3 add cliversos numeric(1,0) default 0 not null
go
alter table sljpara3 add dtgfidels datetime null
go
alter table sljpara3 add cdopeltpvx char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
create  nonclustered index [codscols] on [sljpro2] (codscols) on [primary]
go
create  nonclustered index [codstils] on [sljpro2] (codstils) on [primary]
go
alter table sljropt add mensags char(100) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljsthis add datatrans datetime null
go
create  nonclustered index [sprchaves] on [sljstnfe] (sprchaves) on [primary]
go
alter table sljtlrcp add cgrus char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljtran add vendnts char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljtran add vend2nts char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljtran add clientes numeric(1,0) default 0 not null
go
alter table sljtran add feiras numeric(1,0) default 0 not null
go
alter table sljtran add gatualzs numeric(1,0) default 0 not null
go
