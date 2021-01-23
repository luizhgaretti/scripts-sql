alter table cptprogr drop constraint cptprogr_cidchaves
go
alter table cptprogr with nocheck add constraint cptprogr_cidchaves primary key clustered (cidchaves) on [primary]
go