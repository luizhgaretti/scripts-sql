/*

--NÃO PODE SER ALTERADA
alter table sljeti add empfs char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

create  nonclustered index [empfs] on [sljeti] (empfs) on [primary]

go
*/

drop statistics [sljeesti].[_wa_sys_0000002b_46b27fe2]

go

alter table sljeesti alter column valdescs numeric(13,6)  not null

go

