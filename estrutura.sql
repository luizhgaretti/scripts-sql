alter table sljemp alter column cempsitefs char(8) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table sljgru add pesauts numeric(1,0) default 0 not null
go
alter table [sljloger] with nocheck add constraint [sljloger_pkchaves] primary key clustered (pkchaves) on [primary]
go
alter table sljope5 add vencprzm numeric(1,0) default 0 not null
go
alter table sljpara3 add gravalogs numeric(1,0) default 0 not null
go
alter table sljvxsit add cdcategori int default 0 not null
go
alter table sljvxsit add cddepartam int default 0 not null
go
alter table sljvxsit add icrest bit default 0 not null
go
alter table slvcfo add ivaajsai numeric(1,0) default 0 not null
go
