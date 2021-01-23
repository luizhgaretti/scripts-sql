alter table cptacess drop constraint cptacess_cidchaves
goalter table cptacess with nocheck add constraint [cptacess_cidchaves] primary key clustered (cidchaves) on [primary]go
alter table cptlog drop constraint cptlog_cidchaves
goalter table cptlog with nocheck add constraint [cptlog_cidchaves] primary key clustered (cidchaves) on [primary]go

alter table cptprogr drop constraint cptprogr_cidchaves
goalter table cptprogr with nocheck add constraint cptprogr_cidchaves primary key clustered (cidchaves) on [primary]go

alter table fopcff drop constraint fopcff_cidchaves
goalter table fopcff with nocheck add constraint fopcff_cidchaves primary key clustered (cidchaves) on [primary]go

alter table foplogcr drop constraint foplogcr_cidchaves
goalter table foplogcr with nocheck add constraint foplogcr_cidchaves primary key clustered (cidchaves) on [primary]go




