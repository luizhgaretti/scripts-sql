sp_dropmergearticle @publication = 'tiffanybr'
    ,  @article = 'tabela'
    ,  @force_invalidate_snapshot = 1

Go

exec sp_addmergearticle @publication = N'tiffanybr', 
		@article = N'tabela', 
		@source_owner = N'dbo', 
		@source_object = N'tabela', 
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
