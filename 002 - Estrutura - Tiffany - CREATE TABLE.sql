--create table
create table sljclfgg (mercs char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cgrus char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,sgrus char(6) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,codigos char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)

go

alter table sljclfgg add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go

alter table [sljclfgg] with nocheck add constraint [sljclfgg_cidchaves] primary key clustered (cidchaves) on [primary]

go
-------------------------------------------------------------------------------------------------------

create table sljopcpl (dopes char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)

go

alter table sljopcpl add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go

alter table [sljopcpl] with nocheck add constraint [sljopcpl_dopes] primary key clustered (dopes) on [primary]

go
-------------------------------------------------------------------------------------------------------


create table sljpcfcp (codprecfs int default 0 not null,desprecfs char(60) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,lprecovigs char(30) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,datais datetime null,datafs datetime null,checkps numeric(6,0) default 0 not null,varmdps numeric(5,2) default 0 not null,varmdpr numeric(5,2) default 0 not null,caixapond numeric(5,2) default 0 not null,valcorrs numeric(8,2) default 0 not null,valtarrs numeric(8,2) default 0 not null,dopes char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)

go

alter table sljpcfcp add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go

alter table [sljpcfcp] with nocheck add constraint [sljpcfcp_codprecfs] primary key clustered (codprecfs) on [primary]

go
-------------------------------------------------------------------------------------------------------


create table sljpcfcx (codprecfs int default 0 not null,apuras char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cravas char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,valors numeric(8,2) default 0 not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)

go

alter table sljpcfcx add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go

alter table [sljpcfcx] with nocheck add constraint [sljpcfcx_cidchaves] primary key clustered (cidchaves) on [primary]

go
-------------------------------------------------------------------------------------------------------


create table sljpcfem (codprecfs int default 0 not null,emps char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)

go

alter table sljpcfem add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go

alter table [sljpcfem] with nocheck add constraint [sljpcfem_cidchaves] primary key clustered (cidchaves) on [primary]

go
-------------------------------------------------------------------------------------------------------


create table sljpcfmx (codprecfs int default 0 not null,cpros char(14) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,qtds numeric(11,3) default 0 not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)

go

alter table sljpcfmx add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go

alter table [sljpcfmx] with nocheck add constraint [sljpcfmx_cidchaves] primary key clustered (cidchaves) on [primary]

go
-------------------------------------------------------------------------------------------------------


create table sljpcfpa (grupos char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,estos char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,grptarr char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,grpped char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,grpcorr char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,grppas char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,ggrppas char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)

go

alter table sljpcfpa add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go

alter table [sljpcfpa] with nocheck add constraint [sljpcfpa_cidchaves] primary key clustered (cidchaves) on [primary]

go
-------------------------------------------------------------------------------------------------------


create table sljpcfpi (codprecfs int default 0 not null,cpros char(14) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cplxapur char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cplxcrav char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,pesos numeric(8,3) default 0 not null,vlrpedras numeric(11,2) default 0 not null,pescorr numeric(8,3) default 0 not null,pestarr numeric(8,3) default 0 not null,pcorrig numeric(8,3) default 0 not null,ptrfatu numeric(11,2) default 0 not null,ptrfsug numeric(11,2) default 0 not null,plistaatu numeric(11,2) default 0 not null,plistasug numeric(11,2) default 0 not null,plistaaju numeric(11,2) default 0 not null,pntabp numeric(11,2) default 0 not null,vprevatu numeric(5,2) default 0 not null,cxaajus numeric(5,2) default 0 not null,clfabcrv char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,ajucabc char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,clfestrat char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,situas numeric(1,0) default 0 not null,colecoes char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,difrevatu numeric(11,2) default 0 not null,pdfsugatu numeric(5,2) default 0 not null,vdfsugatu numeric(11,2) default 0 not null,percabc numeric(5,2) default 0 not null,sugabc char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,axqtpta numeric(11,2) default 0 not null,axqtpts numeric(11,2) default 0 not null,axqtatu numeric(11,2) default 0 not null,axqtprev numeric(11,2) default 0 not null,axqtpsug numeric(11,2) default 0 not null,pescper numeric(8,3) default 0 not null,customp numeric(11,2) default 0 not null,cusmofab numeric(11,2) default 0 not null,custotal numeric(11,2) default 0 not null,cusicpe numeric(11,2) default 0 not null,tribpcpe numeric(11,2) default 0 not null,opfincpe numeric(11,2) default 0 not null,cusfbadm numeric(11,2) default 0 not null,ptrfliq numeric(11,2) default 0 not null,prctrfs numeric(11,2) default 0 not null,cusispe numeric(11,2) default 0 not null,emprespe numeric(11,2) default 0 not null,cusick numeric(11,2) default 0 not null,tribpck numeric(11,2) default 0 not null,opfinck numeric(11,2) default 0 not null,amortz numeric(11,2) default 0 not null,retsocs numeric(11,2) default 0 not null,subtots numeric(11,2) default 0 not null,parccfs numeric(11,2) default 0 not null,parpccs numeric(11,2) default 0 not null,parplls numeric(11,2) default 0 not null,parpcis numeric(11,2) default 0 not null,parajus numeric(11,2) default 0 not null,psugvrj numeric(11,2) default 0 not null,pescorg numeric(8,3) default 0 not null,cusmpau numeric(11,2) default 0 not null,cusmppd numeric(11,2) default 0 not null,customp1 numeric(11,2) default 0 not null,fatormo numeric(5,2) default 0 not null,cusmofab1 numeric(11,2) default 0 not null,cusmofab2 numeric(11,2) default 0 not null,custotpc numeric(11,2) default 0 not null,cusindcpe numeric(11,2) default 0 not null,tribpcpe1 numeric(11,2) default 0 not null,opfincpe1 numeric(11,2) default 0 not null,cusfadm numeric(11,2) default 0 not null,ptrfliq1 numeric(11,2) default 0 not null,ptransfs numeric(11,2) default 0 not null,cusindspe numeric(11,2) default 0 not null,empresspe numeric(11,2) default 0 not null,cusindck numeric(11,2) default 0 not null,tribpck1 numeric(11,2) default 0 not null,opfinck1 numeric(11,2) default 0 not null,amortzck numeric(11,2) default 0 not null,retsoc1 numeric(11,2) default 0 not null,subtot1 numeric(11,2) default 0 not null,parccf1 numeric(11,2) default 0 not null,parcpc1 numeric(11,2) default 0 not null,parpll1 numeric(11,2) default 0 not null,parpi1 numeric(11,2) default 0 not null,parajus1 numeric(11,2) default 0 not null,psugvrj1 numeric(11,2) default 0 not null,pcorts numeric(11,2) default 0 not null,ptarchs numeric(11,2) default 0 not null,cuscors numeric(11,2) default 0 not null,custarrs numeric(11,2) default 0 not null,customp2 numeric(11,2) default 0 not null,cusmofab3 numeric(11,2) default 0 not null,custotal3 numeric(11,2) default 0 not null,cindcpe3 numeric(11,2) default 0 not null,tribpcpe3 numeric(11,2) default 0 not null,opfincpe3 numeric(11,2) default 0 not null,cusfadm3 numeric(11,2) default 0 not null,ptrfliq3 numeric(11,2) default 0 not null,ptransf3 numeric(11,2) default 0 not null,cusispe3 numeric(11,2) default 0 not null,empspe3 numeric(11,2) default 0 not null,cusindck3 numeric(11,2) default 0 not null,tribpck3 numeric(11,2) default 0 not null,opfinck3 numeric(11,2) default 0 not null,amortzck3 numeric(11,2) default 0 not null,retsoc3 numeric(11,2) default 0 not null,subtot3 numeric(11,2) default 0 not null,parccf3 numeric(11,2) default 0 not null,parpcc3 numeric(11,2) default 0 not null,parpll3 numeric(11,2) default 0 not null,parpci3 numeric(11,2) default 0 not null,parajus3 numeric(11,2) default 0 not null,psugvrj3 numeric(11,2) default 0 not null,pescper4 numeric(11,2) default 0 not null,customp4 numeric(11,2) default 0 not null,cusmofab4 numeric(11,2) default 0 not null,custotal4 numeric(11,2) default 0 not null,cusicpe4 numeric(11,2) default 0 not null,tribpcpe4 numeric(11,2) default 0 not null,opfincpe4 numeric(11,2) default 0 not null,cusfadm4 numeric(11,2) default 0 not null,caixaesp numeric(11,2) default 0 not null,ptrfliq4 numeric(11,2) default 0 not null,imposto4 numeric(11,2) default 0 not null,ptransf4 numeric(11,2) default 0 not null,cusispe4 numeric(11,2) default 0 not null,emprspe4 numeric(11,2) default 0 not null,cusindck4 numeric(11,2) default 0 not null,tribpck4 numeric(11,2) default 0 not null,opfinck4 numeric(11,2) default 0 not null,amortzck4 numeric(11,2) default 0 not null,retsoc4 numeric(11,2) default 0 not null,receita4 numeric(11,2) default 0 not null,plissugs numeric(11,2) default 0 not null,auxcheck char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,check2 numeric(1,0) default 0 not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)

go

alter table sljpcfpi add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go

alter table [sljpcfpi] with nocheck add constraint [sljpcfpi_cidchaves] primary key clustered (cidchaves) on [primary]

go
-------------------------------------------------------------------------------------------------------


create table sljpcfpp (codprecfs int default 0 not null,vouromil numeric(11,2) default 0 not null,vpreliga numeric(11,3) default 0 not null,vcambped numeric(11,2) default 0 not null,perda numeric(5,2) default 0 not null,cindfabr numeric(11,2) default 0 not null,fcuscorr numeric(11,2) default 0 not null,vau750 numeric(11,2) default 0 not null,cindcpe numeric(11,2) default 0 not null,auxcicpe numeric(5,2) default 0 not null,tribpcpe numeric(11,2) default 0 not null,auxtpcpe numeric(5,2) default 0 not null,emprecpe numeric(11,2) default 0 not null,auxecpe numeric(5,2) default 0 not null,lucroliq numeric(5,2) default 0 not null,taxax numeric(5,2) default 0 not null,impostos numeric(5,2) default 0 not null,cindspe numeric(11,2) default 0 not null,auxcispe numeric(5,2) default 0 not null,emprespe numeric(11,2) default 0 not null,auxespe numeric(5,2) default 0 not null,cindck numeric(11,2) default 0 not null,auxick numeric(5,2) default 0 not null,tribpck numeric(11,2) default 0 not null,auxtpck numeric(5,2) default 0 not null,empreck numeric(11,2) default 0 not null,auxeck numeric(5,2) default 0 not null,amortz numeric(11,2) default 0 not null,auxamtz numeric(5,2) default 0 not null,retsocias numeric(11,2) default 0 not null,auxretsoc numeric(5,2) default 0 not null,bcusfabr numeric(11,2) default 0 not null,impcfabr numeric(5,2) default 0 not null,taxaxcf numeric(5,2) default 0 not null,lucroliqcf numeric(5,2) default 0 not null,descpl numeric(5,2) default 0 not null,cmvtxc numeric(5,2) default 0 not null,comisv numeric(5,2) default 0 not null,txcars numeric(5,2) default 0 not null,txfinan numeric(5,2) default 0 not null,condpag numeric(2,0) default 0 not null,ftcicpe numeric(1,0) default 0 not null,fttpcpe numeric(1,0) default 0 not null,ftofcpe numeric(1,0) default 0 not null,ftptl numeric(1,0) default 0 not null,ftcispe numeric(1,0) default 0 not null,ftofspe numeric(1,0) default 0 not null,ftcick numeric(1,0) default 0 not null,fttpck numeric(1,0) default 0 not null,ftofck numeric(1,0) default 0 not null,ftaick numeric(1,0) default 0 not null,ftretsoc numeric(1,0) default 0 not null,ftpcf numeric(1,0) default 0 not null,ftppc numeric(1,0) default 0 not null,ftppll numeric(1,0) default 0 not null,ftppi numeric(1,0) default 0 not null,ftpsv numeric(1,0) default 0 not null)

go

alter table sljpcfpp add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go

alter table [sljpcfpp] with nocheck add constraint [sljpcfpp_codprecfs] primary key clustered (codprecfs) on [primary]

go
-------------------------------------------------------------------------------------------------------


create table sljttclf (codigos char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,tptribs char(4) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)

go

alter table sljttclf add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go

alter table [sljttclf] with nocheck add constraint [sljttclf_cidchaves] primary key clustered (cidchaves) on [primary]

go
/**************************************************************************************************/

exec sp_addmergearticle @publication = N'tiffanybr', @article = N'sljclfgg', @source_owner = N'dbo', @source_object = N'sljclfgg', @type = N'table', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000010C034FD1, @identityrangemanagementoption = N'manual', @destination_owner = N'dbo', @force_reinit_subscription = 1, @column_tracking = N'false', @subset_filterclause = null, @vertical_partition = N'false', @verify_resolver_signature = 1, @allow_interactive_resolver = N'false', @fast_multicol_updateproc = N'true', @check_permissions = 0, @subscriber_upload_options = 0, @delete_tracking = N'true', @compensate_for_errors = N'false', @stream_blob_columns = N'false', @partition_options = 0, @force_invalidate_snapshot = 1
go
exec sp_addmergearticle @publication = N'tiffanybr', @article = N'sljopcpl', @source_owner = N'dbo', @source_object = N'sljopcpl', @type = N'table', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000010C034FD1, @identityrangemanagementoption = N'manual', @destination_owner = N'dbo', @force_reinit_subscription = 1, @column_tracking = N'false', @subset_filterclause = null, @vertical_partition = N'false', @verify_resolver_signature = 1, @allow_interactive_resolver = N'false', @fast_multicol_updateproc = N'true', @check_permissions = 0, @subscriber_upload_options = 0, @delete_tracking = N'true', @compensate_for_errors = N'false', @stream_blob_columns = N'false', @partition_options = 0, @force_invalidate_snapshot = 1
go
exec sp_addmergearticle @publication = N'tiffanybr', @article = N'sljpcfcp', @source_owner = N'dbo', @source_object = N'sljpcfcp', @type = N'table', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000010C034FD1, @identityrangemanagementoption = N'manual', @destination_owner = N'dbo', @force_reinit_subscription = 1, @column_tracking = N'false', @subset_filterclause = null, @vertical_partition = N'false', @verify_resolver_signature = 1, @allow_interactive_resolver = N'false', @fast_multicol_updateproc = N'true', @check_permissions = 0, @subscriber_upload_options = 0, @delete_tracking = N'true', @compensate_for_errors = N'false', @stream_blob_columns = N'false', @partition_options = 0, @force_invalidate_snapshot = 1
go
exec sp_addmergearticle @publication = N'tiffanybr', @article = N'sljpcfcx', @source_owner = N'dbo', @source_object = N'sljpcfcx', @type = N'table', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000010C034FD1, @identityrangemanagementoption = N'manual', @destination_owner = N'dbo', @force_reinit_subscription = 1, @column_tracking = N'false', @subset_filterclause = null, @vertical_partition = N'false', @verify_resolver_signature = 1, @allow_interactive_resolver = N'false', @fast_multicol_updateproc = N'true', @check_permissions = 0, @subscriber_upload_options = 0, @delete_tracking = N'true', @compensate_for_errors = N'false', @stream_blob_columns = N'false', @partition_options = 0, @force_invalidate_snapshot = 1
go
exec sp_addmergearticle @publication = N'tiffanybr', @article = N'sljpcfem', @source_owner = N'dbo', @source_object = N'sljpcfem', @type = N'table', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000010C034FD1, @identityrangemanagementoption = N'manual', @destination_owner = N'dbo', @force_reinit_subscription = 1, @column_tracking = N'false', @subset_filterclause = null, @vertical_partition = N'false', @verify_resolver_signature = 1, @allow_interactive_resolver = N'false', @fast_multicol_updateproc = N'true', @check_permissions = 0, @subscriber_upload_options = 0, @delete_tracking = N'true', @compensate_for_errors = N'false', @stream_blob_columns = N'false', @partition_options = 0, @force_invalidate_snapshot = 1
go
exec sp_addmergearticle @publication = N'tiffanybr', @article = N'sljpcfmx', @source_owner = N'dbo', @source_object = N'sljpcfmx', @type = N'table', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000010C034FD1, @identityrangemanagementoption = N'manual', @destination_owner = N'dbo', @force_reinit_subscription = 1, @column_tracking = N'false', @subset_filterclause = null, @vertical_partition = N'false', @verify_resolver_signature = 1, @allow_interactive_resolver = N'false', @fast_multicol_updateproc = N'true', @check_permissions = 0, @subscriber_upload_options = 0, @delete_tracking = N'true', @compensate_for_errors = N'false', @stream_blob_columns = N'false', @partition_options = 0, @force_invalidate_snapshot = 1
go
exec sp_addmergearticle @publication = N'tiffanybr', @article = N'sljpcfpa', @source_owner = N'dbo', @source_object = N'sljpcfpa', @type = N'table', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000010C034FD1, @identityrangemanagementoption = N'manual', @destination_owner = N'dbo', @force_reinit_subscription = 1, @column_tracking = N'false', @subset_filterclause = null, @vertical_partition = N'false', @verify_resolver_signature = 1, @allow_interactive_resolver = N'false', @fast_multicol_updateproc = N'true', @check_permissions = 0, @subscriber_upload_options = 0, @delete_tracking = N'true', @compensate_for_errors = N'false', @stream_blob_columns = N'false', @partition_options = 0, @force_invalidate_snapshot = 1
go
exec sp_addmergearticle @publication = N'tiffanybr', @article = N'sljpcfpi', @source_owner = N'dbo', @source_object = N'sljpcfpi', @type = N'table', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000010C034FD1, @identityrangemanagementoption = N'manual', @destination_owner = N'dbo', @force_reinit_subscription = 1, @column_tracking = N'false', @subset_filterclause = null, @vertical_partition = N'false', @verify_resolver_signature = 1, @allow_interactive_resolver = N'false', @fast_multicol_updateproc = N'true', @check_permissions = 0, @subscriber_upload_options = 0, @delete_tracking = N'true', @compensate_for_errors = N'false', @stream_blob_columns = N'false', @partition_options = 0, @force_invalidate_snapshot = 1
go
exec sp_addmergearticle @publication = N'tiffanybr', @article = N'sljpcfpp', @source_owner = N'dbo', @source_object = N'sljpcfpp', @type = N'table', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000010C034FD1, @identityrangemanagementoption = N'manual', @destination_owner = N'dbo', @force_reinit_subscription = 1, @column_tracking = N'false', @subset_filterclause = null, @vertical_partition = N'false', @verify_resolver_signature = 1, @allow_interactive_resolver = N'false', @fast_multicol_updateproc = N'true', @check_permissions = 0, @subscriber_upload_options = 0, @delete_tracking = N'true', @compensate_for_errors = N'false', @stream_blob_columns = N'false', @partition_options = 0, @force_invalidate_snapshot = 1
go
exec sp_addmergearticle @publication = N'tiffanybr', @article = N'sljttclf', @source_owner = N'dbo', @source_object = N'sljttclf', @type = N'table', @description = null, @creation_script = null, @pre_creation_cmd = N'drop', @schema_option = 0x000000010C034FD1, @identityrangemanagementoption = N'manual', @destination_owner = N'dbo', @force_reinit_subscription = 1, @column_tracking = N'false', @subset_filterclause = null, @vertical_partition = N'false', @verify_resolver_signature = 1, @allow_interactive_resolver = N'false', @fast_multicol_updateproc = N'true', @check_permissions = 0, @subscriber_upload_options = 0, @delete_tracking = N'true', @compensate_for_errors = N'false', @stream_blob_columns = N'false', @partition_options = 0, @force_invalidate_snapshot = 1




--CRIAÇÃO DE INDICES

create unique index MSmerge_index_339568389 on sljclfgg(rowguid)
go
create unique index MSmerge_index_467568845 on sljopcpl(rowguid)
go
create unique index MSmerge_index_531569073 on sljpcfcp(rowguid)
go
create unique index MSmerge_index_739569814 on sljpcfcx(rowguid)
go
create unique index MSmerge_index_867570270 on sljpcfem(rowguid)
go
create unique index MSmerge_index_963570612 on sljpcfmx(rowguid)
go
create unique index MSmerge_index_1075571011 on sljpcfpa(rowguid)
go
create unique index MSmerge_index_1251571638 on sljpcfpi(rowguid)
go
create unique index MSmerge_index_1312095856 on sljpcfpp(rowguid)
go
create unique index MSmerge_index_124615628 on sljttclf(rowguid)
