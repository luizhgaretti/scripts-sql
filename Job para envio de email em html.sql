USE [msdb]
GO

/****** Object:  Job [CPT_AGEND_NEW]    Script Date: 03/05/2013 10:51:38 ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [[Uncategorized (Local)]]]    Script Date: 03/05/2013 10:51:38 ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'[Uncategorized (Local)]' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'[Uncategorized (Local)]'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'CPT_AGEND_NEW', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Nenhuma descrição disponível.', 
		@category_name=N'[Uncategorized (Local)]', 
		@owner_login_name=N'sa', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [.]    Script Date: 03/05/2013 10:51:39 ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'.', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'use MonitorDBA

DECLARE @CLIENTE VARCHAR(50)

DECLARE @BODY VARCHAR(500),

             @SUBJECT VARCHAR(150) ,
				@CONTADOR INT


DECLARE C_CPT_AG  CURSOR LOCAL FOR

SELECT CLIENTE
FROM tb_monitor_cptagEND
WHERE STATUS_ANTERIOR <> nr_processos

OPEN C_CPT_AG 

FETCH NEXT FROM  C_CPT_AG  INTO @CLIENTE

WHILE @@FETCH_STATUS = 0
BEGIN
                    IF (Select COUNT(cliente)
                                  from [tb_monitor_cptagEND ] 
                                  where  nr_processos = 0
		   and STATUS_ANTERIOR = 1
                                    ) >0
                                         begin
                           
						                                                            SELECT @SUBJECT = ''Capta Processos Parado no Cliente '' + '''''''' + A.CLIENTE + '''''''' ,

                                                                                       @BODY = ''Capta Processos parado: '' + CHAR(13) + CHAR(13) + 

                                                                                                     ''Instância do SQL Server: '' + A.SQLINSTANCE + CHAR(13) + CHAR(13) + 

                                                                                                     ''Hostname do SQL Server: '' + A.SQLHOSTNAME + CHAR(13) + CHAR(13) + 

                                                                                                     ''IP do SQL Server: '' + A.IPSQL + CHAR(13) + CHAR(13) + CHAR(13) + 

                                                                                                     ''Hostname do Capta Processos: '' + A.NICKNAME + CHAR(13) + CHAR(13) +

                                                                                                     ''Favor Verificar Urgente!''

                                                                          FROM TB_MONITOR_CPTAGEND  A (NOLOCK) 
                                                                          WHERE CLIENTE = @CLIENTE 

                                                                          PRINT @CLIENTE
                                                                          print @SUBJECT
                                                                          print @body
             
                                                                          
                                                                          EXEC msdb.dbo.sp_sEND_dbmail  

                                                                                 @profile_name = ''CAPTASQL3'',

                                                                                 @recipients=''andre.kioshi@capta.com.br;captamon@capta.com.br'',

                                                                                 @subject = @SUBJECT,

                                                                                 @body = @BODY,   

                                                                                 @body_format = ''text'' 
					/*														 
                    UPDATE [tb_monitor_cptagEND ]
                           SET STATUS_ANTERIOR = NR_PROCESSOS
                                  WHERE CLIENTE = @CLIENTE 
                   */

 END
                                                                
                                                                 


 
IF (Select count(cliente)
                                  from [tb_monitor_cptagEND ] 
                                  where  nr_processos = 1
		  and STATUS_ANTERIOR =0
                                    ) > 0
 

SELECT @SUBJECT = ''Capta Processos Iniciado no Cliente '' + '''''''' + A.CLIENTE + '''''''' ,

                           @BODY = ''Capta Processos INICIADO: '' + CHAR(13) + CHAR(13) + 

                                        ''Instância do SQL Server: '' + A.SQLINSTANCE + CHAR(13) + CHAR(13) + 

                                        ''Hostname do SQL Server: '' + A.SQLHOSTNAME + CHAR(13) + CHAR(13) + 

                                        ''IP do SQL Server: '' + A.IPSQL + CHAR(13) + CHAR(13) + CHAR(13) + 

                                        ''Hostname do Capta Processos: '' + A.NICKNAME + CHAR(13) + CHAR(13) 

                                        

             FROM TB_MONITOR_CPTAGEND  A (NOLOCK) 
             WHERE CLIENTE = @CLIENTE 
            
             EXEC msdb.dbo.sp_sEND_dbmail  

                    @profile_name = ''CAPTASQL3'',

                    @recipients=''andre.kioshi@capta.com.br;captamon@capta.com.br'',

                    @subject = @SUBJECT,

                    @body = @BODY,   

                    @body_format = ''text'' 
                    

                                                           
             
			 /*
                    UPDATE [tb_monitor_cptagEND ]
                           SET STATUS_ANTERIOR = NR_PROCESSOS
                                  WHERE CLIENTE = @CLIENTE 
			*/
 
FETCH NEXT FROM C_CPT_AG  INTO @CLIENTE 
 UPDATE [tb_monitor_cptagEND ]
                           SET STATUS_ANTERIOR = NR_PROCESSOS
                                  WHERE CLIENTE = @CLIENTE 


END

CLOSE C_CPT_AG  


DEALLOCATE C_CPT_AG 

PRINT @CLIENTE


/*
                    UPDATE [tb_monitor_cptagEND ]
                           SET STATUS_ANTERIOR = 1
                                  WHERE CLIENTE = ''teste\andre'' */', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'envia email', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=5, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20130304, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'2c56bba1-0c27-485c-8d89-e5568ec49baf'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:

GO


