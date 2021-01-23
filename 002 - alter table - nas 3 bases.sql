--nas 3 bases
--nao replicadas

alter table sljemp2 add cfopserv char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljempc2 add cfopserv char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
goalter table sljsthis add datatrans datetime null
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
