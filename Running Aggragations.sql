-- Running Aggregations
USE tempdb
SET NOCOUNT ON;
GO
IF OBJECT_ID('TestRunningTotals') IS NOT NULL
  DROP TABLE TestRunningTotals
GO
CREATE TABLE TestRunningTotals (ID         Integer IDENTITY(1,1) PRIMARY KEY,
                                ID_Account Integer, 
                                ColDate    Date,
                                ColValue   Float)
GO
-- inserting some garbage data (almost 33 seconds to run)
INSERT INTO TestRunningTotals(ID_Account, ColDate, ColValue)
SELECT TOP 2000000
       ABS((CHECKSUM(NEWID()) /10000000)), 
       CONVERT(Date, GetDate() - (CHECKSUM(NEWID()) /1000000)), 
       (CHECKSUM(NEWID()) /10000000.)
FROM master.sys.columns AS c,
     master.sys.columns AS c2,
     master.sys.columns AS c3
GO
;WITH CTE1
AS
(
  SELECT ColDate, ROW_NUMBER() OVER(PARTITION BY ID_Account, ColDate ORDER BY ColDate) rn
    FROM TestRunningTotals
)
-- Removing duplicated dates
DELETE FROM CTE1
WHERE rn > 1
GO
CREATE UNIQUE INDEX ix ON TestRunningTotals (ID_Account, ColDate) INCLUDE(ColValue)
GO

-- Counting the number of rows
SELECT COUNT(*) FROM TestRunningTotals
GO

-- Monitor using profiler or set statistics io on
-- open script file to see procedure codes or use debug


-- Solution 1 -- SubQuery
-- PageReads: 43290
-- Duration: 1702
CHECKPOINT
DBCC DROPCLEANBUFFERS
DBCC FREEPROCCACHE
GO
DECLARE @i Int = ABS(CHECKSUM(NEWID()) / 10000000)
EXEC st_RunningAggregations_Solution1 @ID_Account = @i
GO

-- Solution 2 -- Cursor
-- PageReads: 23702
-- Duration: 637
CHECKPOINT
DBCC DROPCLEANBUFFERS
DBCC FREEPROCCACHE
GO
DECLARE @i Int = ABS(CHECKSUM(NEWID()) / 10000000)
EXEC st_RunningAggregations_Solution2 @ID_Account = @i
GO

-- Solution 3 - UPDATE with variable, trusting on cluster key order (not allways safe)
-- PageReads: 462
-- Duration: 395
CHECKPOINT
DBCC DROPCLEANBUFFERS
DBCC FREEPROCCACHE
GO
DECLARE @i Int = ABS(CHECKSUM(NEWID()) / 10000000)
EXEC st_RunningAggregations_Solution3 @ID_Account = @i
GO

-- Solution 4 - sp_executeSQL+DML+DDL+CTE+TOP+ORDERBY+UPDATE+OUTUPT+VARIABLE, 
-- Crazy and fun stuff from Paul White :-) (not safe)
-- PageReads: 42777
-- Duration: 2660
CHECKPOINT
DBCC DROPCLEANBUFFERS
DBCC FREEPROCCACHE
GO
DECLARE @i Int = ABS(CHECKSUM(NEWID()) / 10000000)
EXEC st_RunningAggregations_Solution4 @ID_Account = @i
GO

-- Solution 5 - SQL Serer 2012, OVER clause with ORDER BY, Disk-Based worktable
-- PageReads: 31210
-- Duration: 347
CHECKPOINT
DBCC DROPCLEANBUFFERS
DBCC FREEPROCCACHE
GO
DECLARE @i Int = ABS(CHECKSUM(NEWID()) / 10000000)
EXEC st_RunningAggregations_Solution5 @ID_Account = @i
GO

-- Solution 6 - SQL Serer 2012, OVER clause with ORDER BY, In-Memory worktable
-- PageReads: 22 YES I ONLY 22 reads :-)
-- Duration: 234
CHECKPOINT
DBCC DROPCLEANBUFFERS
DBCC FREEPROCCACHE
GO
DECLARE @i Int = ABS(CHECKSUM(NEWID()) / 10000000)
EXEC st_RunningAggregations_Solution6 @ID_Account = @i
GO

-- Performance difference
-- 1 - Check Reads on Profiler
-- 2 - Then look at the Reads using SET STATISTICS IO
-- 3 - Optionaly look at the xEvent warning

-- RANGE
-- 14 seconds
SELECT ID_Account, 
       ColDate, 
       ColValue,
       SUM(ColValue) OVER(PARTITION BY ID_Account
                              ORDER BY ColDate
                              RANGE UNBOUNDED PRECEDING) AS RunningTotal
  FROM TestRunningTotals
 ORDER BY ID_Account, ColDate
GO
-- ROWS
-- 9 seconds
SELECT ID_Account,
       ColDate,
       ColValue,
       SUM(ColValue) OVER(PARTITION BY ID_Account
                              ORDER BY ColDate
                               ROWS UNBOUNDED PRECEDING) AS RunningTotal
  FROM TestRunningTotals
 ORDER BY ID_Account, ColDate
GO