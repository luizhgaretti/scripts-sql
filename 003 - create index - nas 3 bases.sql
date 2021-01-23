--nas 3 bases

create  nonclustered index [anos] on [sljeestm] (anos) on [primary]
go
create  nonclustered index [cpfs] on [sljeestm] (cpfs) on [primary]
go
create  nonclustered index [empdopnums] on [sljeestm] (empdopnums) on [primary]
go
create  nonclustered index [mes] on [sljeestm] (mes) on [primary]
gocreate  nonclustered index [skgroup1] on [sljope] (tipoops,dopes) on [primary]
go
create  nonclustered index [skgroup2] on [sljope] (dopes,tipoops,transs,ctipomarms) on [primary]
go
create  nonclustered index [skgroup4] on [sljope] (dopes,tipoops,abrevs) on [primary]
go
create  nonclustered index [tipoops] on [sljope] (tipoops) on [primary]
gocreate  nonclustered index [codscols] on [sljpro2] (codscols) on [primary]
go
create  nonclustered index [codstils] on [sljpro2] (codstils) on [primary]
gocreate  nonclustered index [sprchaves] on [sljstnfe] (sprchaves) on [primary]
go