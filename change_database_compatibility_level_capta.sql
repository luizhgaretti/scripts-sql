--http://www.sqlservercentral.com/scripts/Compatibility+level/96055/
--Change database compatability level of all databases

DECLARE @Non2012Databases TABLE(
row_id INT IDENTITY(1,1) ,
database_name VARCHAR(MAX) 
);
DECLARE @Compatibility_Level_Master VARCHAR(100);
SET @Compatibility_Level_Master = (select compatibility_level from sys.databases where name = 'master');

INSERT INTO @Non2012Databases(database_name)
SELECT name FROM sys.databases 
WHERE compatibility_level != @Compatibility_Level_Master
 --Skip Read Only Databases
 AND is_read_only = 0 ;


DECLARE @databaseName NVARCHAR(255);
DECLARE @currentCompatibilityLevel VARCHAR(100);
DECLARE @counter INT = (SELECT COUNT(1) FROM @Non2012Databases );

 
WHILE (@counter > 0 ) 
BEGIN 

       SELECT @databaseName = database_name FROM @Non2012Databases
       WHERE row_id = @COUNTER;

       SELECT @currentCompatibilityLevel = compatibility_level
       FROM sys.databases WHERE name = @DATABASENAME;

       -- CHANGE DATABASE COMPATIBILITY
       EXECUTE sp_dbcmptlevel @DATABASENAME , @Compatibility_Level_Master;

       PRINT  @DATABASENAME + ' compatability level changed to ' + @Compatibility_Level_Master + ' from ' + @currentCompatibilityLevel ;

       SET @COUNTER -= 1;

END

GO
