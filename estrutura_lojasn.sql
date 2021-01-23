alter table sljnfis drop constraint sljnfis_cidchaves
go
alter table sljnfis with nocheck add constraint sljnfis_cidchaves primary key clustered (cidchaves) on [primary]
go

