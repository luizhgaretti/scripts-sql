
--IF

DECLARE @var1 AS INT, @var2 AS INT;
SET @var1 = 1;
SET @var2 = 2;
IF @var1 = @var2
PRINT 'Variaveis iguais';
ELSE
PRINT 'Variaveis diferentes';
GO


--WHILE

SET NOCOUNT ON;
DECLARE @count AS INT = 1;
WHILE @count <= 10
BEGIN
PRINT CAST(@count AS NVARCHAR);
SET @count += 1;
END;


------


GO
SET NOCOUNT ON;
DECLARE @count AS INT = 1;
WHILE @count <= 100
BEGIN
IF @count = 10
BREAK;
IF @count = 5
BEGIN
SET @count += 2;
CONTINUE;
END
PRINT CAST(@count AS NVARCHAR);
SET @count += 1;
END;


---------

DECLARE @categoryid AS INT;
SET @categoryid = (SELECT MIN(categoryid) FROM Production.Categories);
WHILE @categoryid IS NOT NULL
BEGIN
PRINT CAST(@categoryid AS NVARCHAR);
SET @categoryid = (SELECT MIN(categoryid) FROM Production.Categories
WHERE categoryid > @categoryid);
END;
GO

/*************************
--- GO TO ---
*************************/
PRINT 'First PRINT statement';
GOTO MyLabel;
PRINT 'Second PRINT statement';
MyLabel:
PRINT 'End';






