
alter table sljcocli add estagcls char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljcocli add ntcompras numeric(6,0) default 0 not null
go
alter table sljcocli add cparams char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljcocli add vcompras numeric(14,2) default 0 not null
go
alter table sljcocli add qcompras numeric(6,0) default 0 not null
go
alter table sljemp2 add contmapres numeric(1,0) default 0 not null
go
alter table sljemp2 add atucustps numeric(1,0) default 0 not null
go
alter table sljemp2 add cmd5_2s char(32) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljemp2 add tdtestpafs datetime null
go
alter table sljemp2 add chvrps char(48) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljempc2 add contmapres numeric(1,0) default 0 not null
go
alter table sljempc2 add chvrps char(48) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljfpag add idfpag int default 0 not null
go
alter table sljfpag add gerpgrcs numeric(1,0) default 0 not null
go
drop index [sljope].[skgroup1]
go
drop index [sljope].[skgroup2]
go
drop index [sljope].[skgroup4]
go
drop index [sljope].[tipoops]
go
alter table sljope drop CONSTRAINT DF__sljope__tipoops__0558508F
alter table sljope alter column tipoops int  not null

alter table sljope add CONSTRAINT DF__sljope__tipoops__0558508F DEFAULT 0 FOR tipoops


select index_col('sljope2                         ',1,2) as cfield1s
go
alter table sljope2 alter column relgerencs numeric(2,0)  not null
go
--alter table [sljope3] with nocheck add constraint [sljope3_dopes] primary key clustered (dopes) on [primary]
Exec sp_rename 'dopes', 'sljope3_dopes', 'OBJECT' 
go
alter table sljope4 add optrfs char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljope4 add carfins numeric(1,0) default 0 not null
go
alter table sljope4 add impdupod numeric(1,0) default 0 not null
go
alter table sljope4 add ecommerc numeric(1,0) default 0 not null
go
alter table sljope4 add acessts numeric(1,0) default 0 not null
go
alter table sljope4 add stautos numeric(1,0) default 0 not null
go
alter table sljope4 add selnpeds numeric(1,0) default 0 not null
go
alter table sljope4 add gnfqbggs numeric(1,0) default 0 not null
go
alter table sljope4 add gnfpres numeric(1,0) default 0 not null
go
alter table sljope4 add cmvtrs numeric(1,0) default 0 not null
go
alter table sljope4 add blqexies numeric(1,0) default 0 not null
go
alter table sljope4 add ccobrig numeric(1,0) default 0 not null
go
alter table sljope4 add questions numeric(1,0) default 0 not null
go
alter table sljope4 add inffins numeric(1,0) default 0 not null
go
alter table sljope4 add blqcnpjs numeric(1,0) default 0 not null
go
alter table sljope4 add empdobrig numeric(1,0) default 0 not null
go
alter table sljope4 add emailauto numeric(1,0) default 0 not null
go
alter table sljope4 add emailod numeric(1,0) default 0 not null
go
alter table sljope4 add emailmod numeric(1,0) default 0 not null
go
alter table sljope4 add gerpgrcs numeric(1,0) default 0 not null
go
alter table sljope4 add credpends numeric(1,0) default 0 not null
go
alter table sljope4 add emppgrcs char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljope4 add apsimppai numeric(1,0) default 0 not null
go
alter table sljope4 add emailanex numeric(1,0) default 0 not null
go
alter table sljope4 add inffinbs numeric(1,0) default 0 not null
go
alter table sljope4 add justexcs numeric(1,0) default 0 not null
go
alter table sljope4 add juntpars numeric(1,0) default 0 not null
go
alter table sljope4 add cgrpprocs char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljope4 add titetabds numeric(1,0) default 0 not null
go
alter table sljope4 add inibmoeds numeric(1,0) default 0 not null
go
alter table sljope4 add nomedopes char(40) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljope4 add doctbas char(12) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljope4 add dcktbas numeric(1,0) default 0 not null
go
create  nonclustered index [nomedopes] on [sljope4] (NomeDopes) on [primary]
go
alter table sljpara2 add idsqlsetups numeric(10,0) default 0 not null
go
alter table sljpara2 add cleretipaf char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljpara2 add dtnotshrink datetime null
go
alter table sljpara2 add cusualags char(15) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljpara2 add csenalags char(15) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljpara2 add catusalags numeric(1,0) default 0 not null
go
select index_col('sljparam                        ',2,2) as cfield1s
go
alter table sljparam alter column commetods numeric(2,0)  not null
go
drop index [sljstnfe].[sprchaves]
go
select index_col('sljstnfe                        ',1,2) as cfield1s
go
alter table sljstnfe alter column sprchaves char(30) collate SQL_Latin1_General_CP1_CI_AS  not null
go
--alter table [sljstnfe] with nocheck add constraint [sljstnfe_cidchaves] primary key clustered (cidchaves) on [primary]
Exec sp_rename 'stnfe_cidchaves', 'sljstnfe_cidchaves', 'OBJECT' 
go
create  nonclustered index [skgroup1] on [sljstope] (dopes, siglas, nomstats, ncors) on [primary]
go
--alter table [sljstope] with nocheck add constraint [sljstope_cidchaves] primary key clustered (cidchaves) on [primary]

Exec sp_rename 'sljstpe_cidchaves', 'sljstope_cidchaves', 'OBJECT' 
go
create  nonclustered index [slvcfocl_skgroup1] on [slvcfocl] (cfops,estas,clfiscals) on [primary]
go
