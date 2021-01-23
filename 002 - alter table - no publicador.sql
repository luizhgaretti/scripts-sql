--no publicador
--replicadas

alter table sljche alter column notas char(9) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table sljcserv add cfopservs char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
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

alter table sljorg add tpdocs numeric(1,0) default 0 not null
go
alter table sljpara3 add cliversos numeric(1,0) default 0 not null
go
alter table sljpara3 add dtgfidels datetime null
go
alter table sljpara3 add cdopeltpvx char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go

alter table sljropt add mensags char(100) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go

alter table sljtlrcp add cgrus char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go

