USE [PROFILER]
GO
/****** Object:  StoredProcedure [dbo].[stpCreate_Trace]    Script Date: 03/17/2014 10:17:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER  PROCEDURE [dbo].[stpCreate_Trace]

AS

BEGIN

    declare @rc int, @TraceID int, @maxfilesize bigint, @on bit, @intfilter int, @bigintfilter bigint

    select @on = 1, @maxfilesize = 200

    -- Criação do trace

    exec @rc = sp_trace_create @TraceID output, 0, N'G:\Trace\Querys_Demoradas', @maxfilesize, NULL

    if (@rc != 0) goto error

    exec sp_trace_setevent @TraceID, 10, 1, @on

    exec sp_trace_setevent @TraceID, 10, 6, @on

    exec sp_trace_setevent @TraceID, 10, 8, @on

    exec sp_trace_setevent @TraceID, 10, 10, @on

    exec sp_trace_setevent @TraceID, 10, 11, @on

    exec sp_trace_setevent @TraceID, 10, 12, @on

    exec sp_trace_setevent @TraceID, 10, 13, @on

    exec sp_trace_setevent @TraceID, 10, 14, @on

    exec sp_trace_setevent @TraceID, 10, 15, @on

    exec sp_trace_setevent @TraceID, 10, 16, @on

    exec sp_trace_setevent @TraceID, 10, 17, @on

    exec sp_trace_setevent @TraceID, 10, 18, @on

    exec sp_trace_setevent @TraceID, 10, 26, @on

    exec sp_trace_setevent @TraceID, 10, 35, @on

    exec sp_trace_setevent @TraceID, 10, 40, @on

    exec sp_trace_setevent @TraceID, 10, 48, @on

    exec sp_trace_setevent @TraceID, 10, 64, @on

    exec sp_trace_setevent @TraceID, 12, 1,  @on

    exec sp_trace_setevent @TraceID, 12, 6,  @on

    exec sp_trace_setevent @TraceID, 12, 8,  @on

    exec sp_trace_setevent @TraceID, 12, 10, @on

    exec sp_trace_setevent @TraceID, 12, 11, @on

    exec sp_trace_setevent @TraceID, 12, 12, @on

    exec sp_trace_setevent @TraceID, 12, 13, @on

    exec sp_trace_setevent @TraceID, 12, 14, @on

    exec sp_trace_setevent @TraceID, 12, 15, @on

    exec sp_trace_setevent @TraceID, 12, 16, @on

    exec sp_trace_setevent @TraceID, 12, 17, @on

    exec sp_trace_setevent @TraceID, 12, 18, @on

    exec sp_trace_setevent @TraceID, 12, 26, @on

    exec sp_trace_setevent @TraceID, 12, 35, @on

    exec sp_trace_setevent @TraceID, 12, 40, @on

    exec sp_trace_setevent @TraceID, 12, 48, @on

    exec sp_trace_setevent @TraceID, 12, 64, @on

	set @bigintfilter = 3000000 -- 3 segundos
    
     exec sp_trace_setfilter @TraceID, 13, 0, 4, @bigintfilter
    -- Set the trace status to start
	
    --exec sp_trace_setfilter @TraceID, 11, 0, 0, N'captasisapl'
	-- o primeiro parametro(coluna) 11 é o textdata o segundo parametro é o de and = 0 ou or = 1  e o ultimo é o de comparação = 0 é o igual 
    -- Set the trace status to start

    --exec sp_trace_setstatus @TraceID, 1

    goto finish

    error:

    select ErrorCode=@rc

    finish:

END
