SELECT command,

               'EstimatedEndTime' = Dateadd(ms,estimated_completion_time,Getdate()),

               'EstimatedSecondsToEnd' = estimated_completion_time / 1000,

               'EstimatedMinutesToEnd' = estimated_completion_time / 1000 / 60,

               'QeryStartTime' = start_time,

               'TimeExecution'=  DateDiff(minute,Getdate(),Start_time),

               'PercentComplete' = percent_complete

FROM sys.dm_exec_requests

 WHERE session_id = 125