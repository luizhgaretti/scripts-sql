--create index
create  nonclustered index [regparts] on [sljbordi] (regparts,emps) on [primary]

go

create  nonclustered index [mercs] on [sljclfgg] (mercs) on [primary]

go

create  nonclustered index [skgroup12] on [sljcli] (iclis) include (inativas
) on [primary]

go

create  nonclustered index [skgroup13] on [sljcli] (rclis) include (cpfs,iclis,grupos,situas,inativas
) on [primary]

go

create  nonclustered index [skgroup2] on [sljfpag] (situas) include (contads,contaos,dcarts,dias,fpags,fparcs,grupods,grupoos,infos,moefpgs,tvens,encargos) on [primary]

go

create  nonclustered index [codstos] on [sljgopeo] (codstos) on [primary]

go

create  nonclustered index [ncodstos] on [sljgopeo] (ncodstos) on [primary]

go

create  nonclustered index [semstats] on [sljgopeo] (semstats) on [primary]

go

create  nonclustered index [nchkcerts] on [sljgru] (nchkcerts) on [primary]

go

create  nonclustered index [skgroup9] on [sljhis] (cpros,datas) include (cidchaves) on [primary]

go

create  nonclustered index [skgroup19] on [sljmccr] (grupos,opers,datas) include (dopes,emps,nfs,nopers,numes,scontas,valors,hist2s,empdopnums
) on [primary]

go

create  nonclustered index [skgroup20] on [sljmccr] (gruconmoes, pagos, nopers, vencs, contapgs, grupages, contages, emps) include (cidchaves
) on [primary]

go

create  nonclustered index [skgroup5] on [sljmfas] (emps, datas) include (cidchaves
) on [primary]

go

create  nonclustered index [empdnauts] on [sljnens] (empdnauts) on [primary]

go

create  nonclustered index [naceites] on [sljnens] (naceites) on [primary]

go

create  nonclustered index [skgroup8] on [sljpar] (nopers) include (cnnsuparcs, autorizs, codbcrts
) on [primary]

go

create  nonclustered index [codprecfs] on [sljpcfcx] (codprecfs) on [primary]

go

create  nonclustered index [codprecfs] on [sljpcfem] (codprecfs) on [primary]

go

create  nonclustered index [codprecfs] on [sljpcfmx] (codprecfs) on [primary]

go

create  nonclustered index [codprecfs] on [sljpcfpi] (codprecfs) on [primary]

go

create  nonclustered index [skgroup10] on [sljpro] (cgrus) include (cpros,dpros
) on [primary]

go

create  nonclustered index [cgrus] on [sljpro2] (cgrus) on [primary]

go

create  nonclustered index [skgroup1] on [sljpro2] (cpros,dataalts) on [primary]

go

create  nonclustered index [codigos] on [sljttclf] (codigos) on [primary]

go

create  nonclustered index [skgroup26] on [sljeest] (chksubn,emps,chkpagos,dopes) on [primary]

go