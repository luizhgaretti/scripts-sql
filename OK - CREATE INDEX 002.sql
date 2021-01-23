create  nonclustered index [empdopnums] on [sljestif] (empdopnums) on [primary]
goalter table [sljestif] with nocheck add constraint [sljestif_cidchaves] primary key clustered (cidchaves) on [primary]
go