create table sljcalcl (emps char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,grupos char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,estos char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,localizas char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cpros char(14) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,datas datetime null,usuars char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,qtds numeric(11,3) default 0 not null)























































alter table sljcalcl add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljcrdmr add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljctpc add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljemail add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljemppr add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljestag add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljfilik add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljggrpr add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljgrupr add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljgrvpr add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljlocpr add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljmarca add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljmarct add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljpara3 add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljpedcc add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljpfoto add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljprest add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljprvci add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljptesp add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljrefpr add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljrspag add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljscol add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljsgrpr add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljstil add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljtpfot add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljufd add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table slvserop add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go



