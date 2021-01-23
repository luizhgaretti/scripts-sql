USE TSQL2012;
GO

DECLARE @sqlstring AS VARCHAR(1000);
SET @sqlstring='SELECT empid, lastname FROM HR.employees;'
EXEC(@sqlstring);
GO

----------------
DECLARE @sqlcode AS NVARCHAR(256) = N'SELECT GETDATE() AS dt';
EXEC sys.sp_executesql @statement = @sqlcode;
GO

------------------

DECLARE @sqlstring AS NVARCHAR(1000);
DECLARE @empid AS INT;
SET @sqlstring=N'
	SELECT empid, lastname 
	FROM HR.employees
	WHERE empid=@empid;'
EXEC sys.sp_executesql 
	@statement = @sqlstring,
	@params=N'@empid AS INT',
	@empid = 5;
GO