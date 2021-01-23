USE TempDB
SET NOCOUNT ON;
GO

IF OBJECT_ID('Tab1') IS NOT NULL
  DROP TABLE Tab1
GO
CREATE TABLE Tab1 (Col1 Int)
GO

INSERT INTO Tab1 VALUES(5), (5), (3) , (1)
GO

-- RowNumber
-- Returns the sequential number of a row within a partition of a result set
SELECT Col1, 
       ROW_NUMBER() OVER(ORDER BY Col1 DESC) AS "ROW_NUMBER()"
  FROM Tab1
  
-- Rank
-- Returns the rank of each row within the partition of a result set. 
-- The rank of a row is one plus the number of ranks that come before the row in question.
SELECT Col1, 
       RANK() OVER(ORDER BY Col1 DESC) AS "RANK()"
  FROM Tab1

-- Dense_Rank
-- Returns the rank of rows within the partition of a result set, without any gaps in the ranking.
-- The rank of a row is one plus the number of distinct ranks that come before the row in question.
SELECT Col1, 
       DENSE_RANK() OVER(ORDER BY Col1 DESC) AS "DENSE_RANK"
  FROM Tab1

-- NTILE
-- Distributes the rows in an ordered partition into a specified number of groups.
SELECT Col1, 
       NTILE(3) OVER(ORDER BY Col1 DESC) AS "NTILE(3)"
  FROM Tab1

-- NTILE
-- Distributes the rows in an ordered partition into a specified number of groups.
SELECT Col1, 
       NTILE(2) OVER(ORDER BY Col1 DESC) AS "NTILE(2)"
  FROM Tab1

-- LEAD
-- Accesses data from a subsequent row in the same result set
SELECT Col1, 
       LEAD(Col1) OVER(ORDER BY Col1) AS "LEAD()"
  FROM Tab1
  
-- LEAD
-- Accesses data from a subsequent row in the same result set
SELECT Col1, 
       LEAD(Col1, 2) OVER(ORDER BY Col1) AS "LEAD()"
  FROM Tab1

-- LAG
-- Accesses data from a previous row in the same result set
SELECT Col1, 
       LAG(Col1) OVER(ORDER BY Col1) AS "LAG()"
  FROM Tab1

SELECT Col1, 
       LEAD(Col1, -1) OVER(ORDER BY Col1) AS "LEAD() as LAG()"
  FROM Tab1

-- FIRST_VALUE
-- Returns the first value in an ordered set of values
SELECT Col1, 
       FIRST_VALUE(Col1) OVER(ORDER BY Col1) AS "FIRST_VALUE()"
  FROM Tab1

-- LAST_VALUE
-- Returns the last value in an ordered set of values
SELECT Col1, 
       LAST_VALUE(Col1) OVER(ORDER BY Col1) AS "LAST_VALUE()"
  FROM Tab1

-- LAST_VALUE
-- Returns the last value in an ordered set of values
SELECT Col1, 
       LAST_VALUE(Col1) OVER(ORDER BY Col1 ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS "LAST_VALUE()"
  FROM Tab1

-- LAST_VALUE
-- Returns the last value in an ordered set of values
SELECT Col1,
       LAST_VALUE(Col1) OVER(ORDER BY Col1 RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS "LAST_VALUE()"
  FROM Tab1



-- Others

-- PERCENT_RANK
-- Calculates the relative rank of a row within a group of rows
SELECT Col1, 
       PERCENT_RANK() OVER(ORDER BY Col1) AS "PERCENT_RANK()"
  FROM Tab1
  
-- Fake PERCENT_RANK
SELECT Col1, 
       (RANK() OVER(ORDER BY Col1) - 1.) / ((SELECT COUNT(*) FROM Tab1) - 1.) AS "Fake PERCENT_RANK()"
  FROM Tab1

-- CUME_DIST()
-- Calculates the cumulative distribution of a value in a group of values
SELECT Col1, 
       CUME_DIST() OVER(ORDER BY Col1) AS "CUME_DIST()"
  FROM Tab1

-- PERCENTILE_CONT - Calculates a percentile based on a continuous distribution of the column value 
-- PERCENTILE_DISC - Computes a specific percentile for sorted values in an entire rowset or within distinct partitions of a rowset 
SELECT Col1, 
       PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY Col1) OVER () AS MedianCont,
       PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY Col1) OVER () AS MedianDisc
  FROM Tab1