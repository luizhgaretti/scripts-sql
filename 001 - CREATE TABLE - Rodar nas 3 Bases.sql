create table sljltctb (empdopnums char(29) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,numlotes numeric(8,0) default 0 not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)

go


alter table sljltctb add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go


alter table [sljltctb] with nocheck add constraint [sljltctb_cidchaves] primary key clustered (cidchaves) on [primary]

go


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