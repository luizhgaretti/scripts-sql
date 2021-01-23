--CREATE INDEX
create  nonclustered index [skgroup2] on [programa] (isdotnet) include (barrapict,descricaos,parametros,programas) on [primary]

go

create  nonclustered index [skgroup3] on [programa] (isdotnet) include (descricaos,barrapict,estends) on [primary]

go

create  nonclustered index [skgroup1] on [sljbarra] (selbarras,usuarios) include (programas,parametros,barraforms) on [primary]

go

create  nonclustered index [datas] on [sljcred] (datas) on [primary]

go

create  nonclustered index [empfs] on [sljeti] (empfs) on [primary]

go

create  nonclustered index [balancos] on [sljflxcx] (balancos,datainis,datafins,grupo,conta,ccusto) on [primary]

go

create  nonclustered index [tdatas] on [sljitecf] (tdatas) on [primary]

go

create  nonclustered index [npedclis] on [sljmccr] (npedclis) on [primary]

go

create  nonclustered index [npedclis] on [sljpmccr] (npedclis) on [primary]

go

create  nonclustered index [skgroup1] on [sljptesp] (datainis,datafins,empdopnums) include (cpros,citens) on [primary]

go

create  nonclustered index [skgroup3] on [sljsphis] (ctpregs,ctpcancs,cncxav1s) on [primary]

go

create  nonclustered index [datas] on [sljtrflg] (datas) on [primary]

go

create  nonclustered index [dataalts] on [slvcfo2] (dataalts) on [primary]

go

