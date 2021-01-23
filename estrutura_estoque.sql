alter table sljctplw drop constraint sljctplw_cidchaves
go
alter table sljctplw with nocheck add constraint sljctplw_cidchaves primary key clustered (cidchaves) on [primary]
go	

alter table SljCli2 with nocheck add constraint sljcli2_idconta primary key clustered (idconta) on [primary]
go	
	




