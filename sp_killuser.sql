USE [master]
GO

/****** Object:  StoredProcedure [dbo].[sp_killuser]    Script Date: 01/07/2011 16:30:11 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/* AUTHOR: RMcCauley (with some help from Microsoft)  
 CREATED: 10/17/2003  
 PURPOSE: This procedure is user to kill multiple user processes  
  at once. If run without a parameter, it will list each  
  user currently connected, as well as the total number  
  of processes and databases their connected to. Run it  
  again with that person's login as a parameter, and the  
  procedure will shred each of that person's processes,  
  releasing their QA session to execute more poorly  
  planned and horribly un-optimized queries.  
  
         SIDE NOTE: Don't kill the 'sa' user - that's bad.  
*/  
  
  
create PROCEDURE [dbo].[sp_killuser] -- 1995/11/03 10:16  
 @loginame    sysname = NULL  
as  
  
IF @loginame like 'sa'  
BEGIN  
 Print 'You can''t kill the SA user!'  
 GOTO LABEL_86RETURN  
END  
  
  
  
set nocount on  
  
declare  
    @retcode         int  
  
declare  
    @sidlow         varbinary(85)  
   ,@sidhigh        varbinary(85)  
   ,@sid1           varbinary(85)  
   ,@spidlow         int  
   ,@spidhigh        int  
  
declare  
    @charMaxLenLoginName      varchar(6)  
   ,@charMaxLenDBName         varchar(6)  
   ,@charMaxLenCPUTime        varchar(10)  
   ,@charMaxLenDiskIO         varchar(10)  
   ,@charMaxLenHostName       varchar(10)  
   ,@charMaxLenProgramName    varchar(10)  
   ,@charMaxLenLastBatch      varchar(10)  
   ,@charMaxLenCommand        varchar(10)  
  
declare  
    @charsidlow              varchar(85)  
   ,@charsidhigh             varchar(85)  
   ,@charspidlow              varchar(11)  
   ,@charspidhigh             varchar(11)  
  
DECLARE @current_process  int  
  
--------  
  
select  
    @retcode         = 0      -- 0=good ,1=bad.  
  
--------defaults  
select @sidlow = convert(varbinary(85), (replicate(char(0), 85)))  
select @sidhigh = convert(varbinary(85), (replicate(char(1), 85)))  
  
select  
    @spidlow         = 0  
   ,@spidhigh        = 32767  
  
--------------------------------------------------------------  
IF (@loginame IS     NULL)  --Simple default to all LoginNames.  
      GOTO LABEL_17PARM1EDITED  
  
--------  
  
-- select @sid1 = suser_sid(@loginame)  
select @sid1 = null  
if exists(select * from master.dbo.syslogins where loginname = @loginame)  
 select @sid1 = sid from master.dbo.syslogins where loginname = @loginame  
  
IF (@sid1 IS NOT NULL)  --Parm is a recognized login name.  
   begin  
   select @sidlow  = suser_sid(@loginame)  
         ,@sidhigh = suser_sid(@loginame)  
   GOTO LABEL_17PARM1EDITED  
   end  
  
--------  
  
IF (lower(@loginame) IN ('active'))  --Special action, not sleeping.  
   begin  
   select @loginame = lower(@loginame)  
   GOTO LABEL_17PARM1EDITED  
   end  
  
--------  
  
IF (patindex ('%[^0-9]%' , isnull(@loginame,'z')) = 0)  --Is a number.  
   begin  
   select  
             @spidlow   = convert(int, @loginame)  
            ,@spidhigh  = convert(int, @loginame)  
   GOTO LABEL_17PARM1EDITED  
   end  
  
--------  
  
/*RaisError(15007,-1,-1,@loginame)  
select @retcode = 1  
GOTO LABEL_86RETURN  
*/  
  
LABEL_17PARM1EDITED:  
  
  
--------------------  Capture consistent sysprocesses.  -------------------  
  
SELECT  
  
  spid  
 ,status  
 ,sid  
 ,hostname  
 ,program_name  
 ,cmd  
 ,cpu  
 ,physical_io  
 ,blocked  
 ,dbid  
 ,convert(sysname, rtrim(loginame))  
        as loginname  
 ,spid as 'spid_sort'  
  
 ,  substring( convert(varchar,last_batch,111) ,6  ,5 ) + ' '  
  + substring( convert(varchar,last_batch,113) ,13 ,8 )  
       as 'last_batch_char'  
  
      INTO    #tb1_sysprocesses  
      from master.dbo.sysprocesses   (nolock)  
  
  
  
--------Screen out any rows?  
  
IF (@loginame IN ('active'))  
   DELETE #tb1_sysprocesses  
         where   lower(status)  = 'sleeping'  
         and     upper(cmd)    IN (  
                     'AWAITING COMMAND'  
                    ,'MIRROR HANDLER'  
                    ,'LAZY WRITER'  
                    ,'CHECKPOINT SLEEP'  
                    ,'RA MANAGER'  
                                  )  
  
         and     blocked       = 0  
  
  
  
--------Prepare to dynamically optimize column widths.  
  
  
Select  
    @charsidlow     = convert(varchar(85),@sidlow)  
   ,@charsidhigh    = convert(varchar(85),@sidhigh)  
   ,@charspidlow     = convert(varchar,@spidlow)  
   ,@charspidhigh    = convert(varchar,@spidhigh)  
  
  
  
SELECT  
             @charMaxLenLoginName =  
                  convert( varchar  
                          ,isnull( max( datalength(loginname)) ,5)  
                         )  
  
            ,@charMaxLenDBName    =  
                  convert( varchar  
                          ,isnull( max( datalength( rtrim(convert(varchar(128),db_name(dbid))))) ,6)  
                         )  
  
            ,@charMaxLenCPUTime   =  
                  convert( varchar  
                          ,isnull( max( datalength( rtrim(convert(varchar(128),cpu)))) ,7)  
                         )  
  
            ,@charMaxLenDiskIO    =  
                  convert( varchar  
                          ,isnull( max( datalength( rtrim(convert(varchar(128),physical_io)))) ,6)  
                         )  
  
            ,@charMaxLenCommand  =  
                  convert( varchar  
                          ,isnull( max( datalength( rtrim(convert(varchar(128),cmd)))) ,7)  
                         )  
  
            ,@charMaxLenHostName  =  
                  convert( varchar  
                          ,isnull( max( datalength( rtrim(convert(varchar(128),hostname)))) ,8)  
                         )  
  
            ,@charMaxLenProgramName =  
                  convert( varchar  
                          ,isnull( max( datalength( rtrim(convert(varchar(128),program_name)))) ,11)  
                         )  
  
            ,@charMaxLenLastBatch =  
                  convert( varchar  
                          ,isnull( max( datalength( rtrim(convert(varchar(128),last_batch_char)))) ,9)  
                         )  
      from  
             #tb1_sysprocesses  
      where  
--             sid >= @sidlow  
--      and    sid <= @sidhigh  
--      and  
             spid >= @spidlow  
      and    spid <= @spidhigh  
   
IF @loginame is null  
BEGIN        
 --------Output the report.  
    SELECT count(spid) as Sessions,  
  null as databases,  
           sp.loginname as Login  
      into #results  
      from #tb1_sysprocesses sp  
     where spid >=  @charspidlow  
       and spid <= @charspidhigh  
       --and loginname <> 'sa'  
  GROUP BY sp.loginname  
    
 -- Create list of databases to see how many each person is using  
     select count(db) as dbcount,  
  loginname  
      INTO #dbusernames  
      from (select distinct db_name(dbid) as db, loginname from #tb1_sysprocesses) small  
  GROUP BY loginname  
   
 -- Join to database names  
 UPDATE #results  
 SET databases = db.dbcount  
 FROM #results, #dbusernames db  
 WHERE #results.login = db.loginname  
   
 -- Return results  
 SELECT * from #results  
  
END  
IF @loginame is not null --Do the actual process killing  
BEGIN  
 DECLARE kill_cursor SCROLL CURSOR  
  FOR  
    SELECT spid  
      from #tb1_sysprocesses sp  
     where spid >=  @charspidlow  
       and spid <= @charspidhigh  
       and upper(loginname) = upper(@loginame)  
  
 --open the cursor   
 OPEN kill_cursor  
  
 --fetch first variables from cursor  
 FETCH FIRST FROM kill_cursor  
  INTO @current_process  
  
 PRINT 'Killing all processes for user ' + @loginame  
 --While there is no error fetching rows insert data into #data table.  
 WHILE @@FETCH_STATUS = 0  
 BEGIN  
  EXEC ('kill ' + @current_process)  
  Print 'Successfully killed process number ' + convert(varchar,100,@current_process)  
  FETCH NEXT FROM kill_cursor  
   INTO @current_process  
 END  
 PRINT 'All processes for ' + @loginame + ' have been killed'  
  
 CLOSE kill_cursor  
 DEALLOCATE kill_cursor  
  
END  
  
SET nocount on  
  
  
LABEL_86RETURN:  
  
  
if (object_id('tempdb..#tb1_sysprocesses') is not null)  
BEGIN  
 drop table #tb1_sysprocesses  
 if @loginame is null  
 BEGIN    
  DROP TABLE #dbusernames  
  DROP TABLE #results  
 END  
END  
  
  
  
GO


