USE [msdb]
GO

/****** Object:  Alert [ADM_ReplicaNotRunning]    Script Date: 09/06/2015 09:47:21 ******/
EXEC msdb.dbo.sp_add_alert @name=N'ADM_ReplicaNotRunning', 
		@message_id=35206, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=0, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO




USE [msdb]
GO

/****** Object:  Alert [ADM_ReplicaStopping]    Script Date: 09/06/2015 09:47:25 ******/
EXEC msdb.dbo.sp_add_alert @name=N'ADM_ReplicaStopping', 
		@message_id=41061, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=0, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO





USE [msdb]
GO

/****** Object:  Alert [ADM_ConnectionBetweenPrincipalSecundaryEstablished]    Script Date: 09/06/2015 09:47:06 ******/
EXEC msdb.dbo.sp_add_alert @name=N'ADM_ConnectionBetweenPrincipalSecundaryEstablished', 
		@message_id=35202, 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=0, 
		@include_event_description_in=1, 
		@category_name=N'[Uncategorized]', 
		@job_id=N'00000000-0000-0000-0000-000000000000'
GO


