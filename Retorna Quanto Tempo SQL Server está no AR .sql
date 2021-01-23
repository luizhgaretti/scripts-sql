USE [master]
-- determines when tempdb was created (done at startup)
DECLARE @starttime datetime
SET @starttime = (SELECT crdate FROM sysdatabases WHERE name = 'tempdb' )

-- determines the current time
DECLARE @currenttime datetime
SET @currenttime = GETDATE()

-- declares variables for days, hours and minutes
DECLARE @difference_dd int
DECLARE @difference_hh int
DECLARE @difference_mi int

-- determines how many minutes have passed since tempdb was created
SET @difference_mi = (SELECT DATEDIFF(mi, @starttime, @currenttime))

-- determines the number of days since tempdb was created
SET @difference_dd = (@difference_mi/60/24)

-- retracts the days from the minutes
SET @difference_mi = @difference_mi - (@difference_dd*60)*24

-- determines the number of hours since tempdb was created (not counting the used days)
SET @difference_hh = (@difference_mi/60)

-- retracts the hours from the minuts
SET @difference_mi = @difference_mi - (@difference_hh*60)

PRINT 'Time since SQL Server service was started: ' + CONVERT(varchar, @difference_dd) + ' days ' +  CONVERT(varchar, @difference_hh) + ' hours ' + CONVERT(varchar, @difference_mi) + ' minutes.'  