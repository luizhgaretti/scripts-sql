create  nonclustered index [skgroup25] on [sljeest] (dopes,notas) include (empdopnums,valos,valobxs,cidchaves) on [primary]

go

create  nonclustered index [balancos] on [sljflxcx] (balancos,datainis,datafins,grupo,conta,ccusto) on [primary]

go

create  nonclustered index [chnfes] on [sljmannf] (chnfes,empdopnums) on [primary]

go

create  nonclustered index [empdopnums] on [sljmannf] (empdopnums) on [primary]

go

create  nonclustered index [cmats] on [sljnensi] (cmats) on [primary]

go

create  nonclustered index [nprioris] on [sljnfepr] (nprioris) include (empdopnums) on [primary]

go


