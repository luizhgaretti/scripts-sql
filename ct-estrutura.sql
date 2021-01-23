--Executar em todas as lojas bd -->Tiffanybr
create table sljloger 
(
empdopnums char(29) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,
cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,
usuars char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,
datas datetime null,usuredes text null,
tabela char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,
pkchaves char(40) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
)
go
alter table [sljloger] with nocheck add constraint [sljloger_pkchaves] primary key clustered (pkchaves) on [primary]
go

alter table [sljloger] add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid() 
go

-----------------------------------

----- excutar só no principal bd --->sb1....
exec sp_addmergearticle @publication = N'tiffanybr', 
                               @article = N'sljloger', 
                               @source_owner = N'dbo', 
                               @source_object = N'sljloger', 
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
                               @force_invalidate_snapshot = 1


------------------------------------

--Criar indices apenas nos assinantes, (no principal já é criado)
create unique index MSmerge_index_339568389 on sljloger (rowguid)
go

