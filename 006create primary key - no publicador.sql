alter table sljeest add CONSTRAINT DF__sljeest__localen__40826CA7 DEFAULT 0 FOR localents
go
alter table sljeest add CONSTRAINT DF__sljeest__localen__553C954A DEFAULT 0 FOR localents
go
alter table sljeest add CONSTRAINT DF__sljeest__localen__501753ED DEFAULT 0 FOR localents
go

alter table sljeti add CONSTRAINT DF__sljeti__cbars__5ACC4E8F DEFAULT 0 FOR cbars
go
alter table sljeti add CONSTRAINT DF__sljeti__cbars__6F867732 DEFAULT 0 FOR cbars
go
alter table sljeti add CONSTRAINT DF__sljeti__cbars__6A6135D5 DEFAULT 0 FOR cbars
go
alter table sljtope add CONSTRAINT DF__sljtope__cptagsv__3CCAB145 DEFAULT 0 FOR cptagsvc
go
alter table sljtope add CONSTRAINT DF__sljtope__cptagsv__0253C523 DEFAULT 0 FOR cptagsvc
go
alter table sljtope add CONSTRAINT DF__sljtope__cptagsv__77E2EC20 DEFAULT 0 FOR cptagsvc
go

alter table [sljcalcl] with nocheck add constraint [sljcalcl_cidchaves] primary key clustered (cidchaves) on [primary]
goalter table [sljconn] with nocheck add constraint [sljconn_cods] primary key clustered (cods) on [primary]
go

alter table [sljcrdmr] with nocheck add constraint [sljcrdmr_cidchaves] primary key clustered (cidchaves) on [primary]
goalter table [sljctpc] with nocheck add constraint [sljctpc_cidchaves] primary key clustered (cidchaves) on [primary]
go

alter table [sljemail] with nocheck add constraint [sljemail_cidchaves] primary key clustered (cidchaves) on [primary]
go

alter table [sljemppr] with nocheck add constraint [sljemppr_cidchaves] primary key clustered (cidchaves) on [primary]
go

alter table [sljestag] with nocheck add constraint [sljestag_cods] primary key clustered (cods) on [primary]
go

alter table [sljeti] with nocheck add constraint [sljeti_cbars] primary key clustered (cbars) on [primary]
go

alter table [sljfilik] with nocheck add constraint [sljfilik_cidchaves] primary key clustered (cidchaves) on [primary]
go
alter table [sljggrpr] with nocheck add constraint [sljggrpr_cidchaves] primary key clustered (cidchaves) on [primary]
go

alter table [sljgrupr] with nocheck add constraint [sljgrupr_cidchaves] primary key clustered (cidchaves) on [primary]goalter table [sljgrvpr] with nocheck add constraint [sljgrvpr_cidchaves] primary key clustered (cidchaves) on [primary]
go

alter table [sljlocpr] with nocheck add constraint [sljlocpr_cidchaves] primary key clustered (cidchaves) on [primary]
go

alter table [sljmarca] with nocheck add constraint [sljmarca_cidchaves] primary key clustered (cidchaves) on [primary]
go

alter table [sljmarct] with nocheck add constraint [sljmarct_cidchaves] primary key clustered (cidchaves) on [primary]
go

alter table [sljpara3] with nocheck add constraint [sljpara3_cidchaves] primary key clustered (cidchaves) on [primary]
go
alter table [sljpedcc] with nocheck add constraint [sljpedcc_cidchaves] primary key clustered (cidchaves) on [primary]
goalter table [sljpfoto] with nocheck add constraint [sljpfoto_cidchaves] primary key clustered (cidchaves) on [primary]
go
alter table [sljprest] with nocheck add constraint [sljprest_cidchaves] primary key clustered (cidchaves) on [primary]
goalter table [sljprvci] with nocheck add constraint [sljprvci_codprovs] primary key clustered (codprovs) on [primary]
goalter table [sljptesp] with nocheck add constraint [sljptesp_cidchaves] primary key clustered (cidchaves) on [primary]
go
alter table [sljrefpr] with nocheck add constraint [sljrefpr_cidchaves] primary key clustered (cidchaves) on [primary]
goalter table [sljrspag] with nocheck add constraint [sljrspag_cidchaves] primary key clustered (cidchaves) on [primary]
goalter table [sljscol] with nocheck add constraint [sljscol_codigos] primary key clustered (codigos) on [primary]
go
alter table [sljsgrpr] with nocheck add constraint [sljsgrpr_cidchaves] primary key clustered (cidchaves) on [primary]
goalter table [sljstil] with nocheck add constraint [sljstil_codigos] primary key clustered (codigos) on [primary]
goalter table [sljtpfot] with nocheck add constraint [sljtpfot_cods] primary key clustered (cods) on [primary]
go
alter table [sljufd] with nocheck add constraint [sljufd_cidchaves] primary key clustered (cidchaves) on [primary]
goalter table [slvserop] with nocheck add constraint [slvserop_cidchaves] primary key clustered (cidchaves) on [primary]
go
alter table [sljfrete] with nocheck add constraint [sljfrete_cidchaves] primary key clustered (cidchaves) on [primary]go