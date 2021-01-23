alter table sljcol add situas numeric(1,0) default 0 not null
go
create  nonclustered index [skgroup20] on [sljeest] (chksubn) include (empdopnums) on [primary]
go
create  nonclustered index [ccodambs] on [sljeesti] (ccodambs) on [primary]
go
create  nonclustered index [sljeesti_cfops] on [sljeesti] (cfops) on [primary]
go
alter table sljemp2 add autgerarqs numeric(1,0) default 0 not null
go
alter table sljempc2 add autgerarqs numeric(1,0) default 0 not null
go
create  nonclustered index [skgroup1] on [sljestep] (emps) include (cidchaves
) on [primary]
go
create  nonclustered index [sljfpro_cbars] on [sljfpro] (cbars) on [primary]
go
create  nonclustered index [empdopnums] on [sljgdmi] (empdopnums) on [primary]
go
create  nonclustered index [skgroup8] on [sljhis] (cpros,emps,datas) include (dopes,opers,qtds,empdopnums) on [primary]
go
create table sljltctb (empdopnums char(29) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,numlotes numeric(8,0) default 0 not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create  nonclustered index [sljltctb_chave] on [sljltctb] (empdopnums,numlotes) on [primary]
go
alter table [sljltctb] with nocheck add constraint [sljltctb_cidchaves] primary key clustered (cidchaves) on [primary]
go
create  nonclustered index [skgroup15] on [sljmccr] (moedas,vencs,titcancs) include (contas,emps,grupos,hists,nfs,nopers,opers,scontas,sgrupos,titulos,valors,valpags,vopers,contapgs,dopcs,hist2s,cidchaves,empdopnums,empdopncs) on [primary]
go
create  nonclustered index [skgroup16] on [sljmccr] (tipos,titcancs) include (contages,contas,emps,grupos,hists,moedas,nfs,nopers,opers,scontas,sgrupos,titulos,valors,valpags,vencs,vopers,contapgs,dopcs,hist2s,cidchaves,empdopnums,empdopncs) on [primary]
go
create  nonclustered index [sljnfepr_stats] on [sljnfepr] (stats) include (cidchaves,empdopnums,cancelas,chnfes,nprioris,ntents,procsteps) on [primary]
go
create  nonclustered index [cfis] on [sljnfis] (cfis) on [primary]
go
create  nonclustered index [skgroup8] on [sljnfis] (dtsaidas) include (dopes,emis,cidchaves,empdopnums) on [primary]
go
create  nonclustered index [skgroup9] on [sljnfis] (operas,dopes) include (empdopnums,emps,nfis,emis) on [primary]
go
select index_col('sljope2                         ',1,2) as cfield1s
go
alter table sljope2 alter column trfservs numeric(2,0)  not null
go
create  nonclustered index [rpss] on [sljope2] (rpss) on [primary]
go
alter table sljope4 add naoehrps numeric(1,0) default 0 not null
go
alter table sljope4 add fixevts numeric(1,0) default 0 not null
go
alter table sljope4 add carevts numeric(1,0) default 0 not null
go
create  nonclustered index [skgroup5] on [sljpar] (vencs) include (dopes,fpags,valos,vpags,empdopnums) on [primary]
go
create  nonclustered index [skgroup6] on [sljpar] (pagos,vencs) include (empdopnums) on [primary]
go
alter table sljpara2 add tpopdvs numeric(2,0) default 0 not null
go
alter table sljpara2 add fildevvds numeric(1,0) default 0 not null
go
alter table sljpara2 add chkdevvds numeric(1,0) default 0 not null
go
alter table sljpara3 add nhababacmp numeric(1,0) default 0 not null
go
alter table sljpara3 add dsconftpvx char(150) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
select index_col('sljpro                          ',1,2) as cfield1s
go
alter table sljpro alter column margems numeric(10,6)  not null
go
select index_col('sljpro2                         ',12,2) as cfield1s
go
alter table sljpro2 alter column margems numeric(10,6)  not null
go
create  nonclustered index [skgroup2] on [sljsccr] (moedas) include (grupos,contas) on [primary]
go
