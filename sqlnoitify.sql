USE [master]
GO
/****** Object:  StoredProcedure [dbo].[sp_SQLNotify]    Script Date: 12/17/2012 16:27:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_SQLNotify]
   @From varchar(100) ,
   @To varchar(max) ,
   @Subject varchar(100)=" ",
   @Body varchar(4000)
AS
  exec msdb.dbo.sp_send_dbmail @profile_name = 'SQLServer'
  , @recipients = @To
  , @subject =  @Subject
  , @body = @Body
