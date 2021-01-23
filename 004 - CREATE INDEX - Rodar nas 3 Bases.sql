--create index

create  nonclustered index [skgroup20] on [sljeest] (chksubn) include (empdopnums) on [primary]

go

create  nonclustered index [ccodambs] on [sljeesti] (ccodambs) on [primary]

go

create  nonclustered index [sljeesti_cfops] on [sljeesti] (cfops) on [primary]

go

create  nonclustered index [skgroup1] on [sljestep] (emps) include (cidchaves) on [primary]

go

create  nonclustered index [sljfpro_cbars] on [sljfpro] (cbars) on [primary]

go

create  nonclustered index [empdopnums] on [sljgdmi] (empdopnums) on [primary]

go

create  nonclustered index [skgroup8] on [sljhis] (cpros,emps,datas) include (dopes,opers,qtds,empdopnums) on [primary]

go

create  nonclustered index [sljltctb_chave] on [sljltctb] (empdopnums,numlotes) on [primary]

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

create  nonclustered index [skgroup5] on [sljpar] (vencs) include (dopes,fpags,valos,vpags,empdopnums) on [primary]

go

create  nonclustered index [skgroup6] on [sljpar] (pagos,vencs) include (empdopnums) on [primary]

go

create  nonclustered index [skgroup2] on [sljsccr] (moedas) include (grupos,contas) on [primary]

go

create  nonclustered index [rpss] on [sljope2] (rpss) on [primary]

go