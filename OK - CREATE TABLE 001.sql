create table sljstcpl (codstatus char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,statuscpl char(25) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)

go

alter table sljstcpl add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go

alter table [sljstcpl] with nocheck add constraint [sljstcpl_cidchaves] primary key clustered (cidchaves) on [primary]

go

/***********************************************************************************************/

create table sljmannf (chnfes char(44) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,empdopnums char(29) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,statnfes numeric(1,0) default 0 not null,codevento char(6) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,descricao char(254) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,status char(2) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,nprotos char(15) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,dataevto datetime null,usuario char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,usuaredes char(100) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,ultlogs char(254) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,emps char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,ntents numeric(2,0) default 0 not null,nenvia numeric(1,0) default 0 not null)

go

alter table sljmannf add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go

alter table [sljmannf] with nocheck add constraint [sljmannf_cidchaves] primary key clustered (cidchaves) on [primary]

go

/***********************************************************************************************/

create table sljflxcx (grupo char(30) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,conta char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,ccusto char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,valor numeric(13,2) default 0 not null,percs numeric(6,2) default 0 not null,balancos char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,datainis datetime not null,datafins datetime not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)

go

alter table sljflxcx add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go

alter table [sljflxcx] with nocheck add constraint [sljflxcx_cidchaves] primary key clustered (cidchaves) on [primary]

go

/************************************************************************************************/

/*
exec sp_addmergearticle @publication = N'tiffanybr', 
		@article = N'sljltctb', 
		@source_owner = N'dbo', 
		@source_object = N'sljltctb', 
		@type = N'table', @description = null, 
		@creation_script = null, 
		@pre_creation_cmd = N'drop', 
		@schema_option = 0x000000010C034FD1, 
		@identityrangemanagementoption = N'manual', 
		@destination_owner = N'dbo', 
		@force_reinit_subscription = 1, 
		@column_tracking = N'false', 
		@subset_filterclause = null, 
		@vertical_partition = N'false', 
		@verify_resolver_signature = 1, 
		@allow_interactive_resolver = N'false', 
		@fast_multicol_updateproc = N'true', 
		@check_permissions = 0, 
		@subscriber_upload_options = 0, 
		@delete_tracking = N'true', 
		@compensate_for_errors = N'false', 
		@stream_blob_columns = N'false', 
		@partition_options = 0,
		@force_invalidate_snapshot = 1 --Se um instantâneo já foi gerado para a publicação, e desta forma, nao gera td de novo quando sincronizar, somente o que foi adicionado




--obs: apos add a tabela na replicacao, criar o indice no assinante na coluna rowguid. ex: create unique index MSmerge_index_780865494 on sljltctb(rowguid)

*/

--create unique index MSmerge_index_780865494 on sljstcpl(rowguid)
--create unique index MSmerge_index_780865494 on sljmannf(rowguid)
--create unique index MSmerge_index_780865494 on sljflxcx(rowguid)