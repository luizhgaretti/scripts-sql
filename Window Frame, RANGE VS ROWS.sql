-- FRAME, RANGE VS ROW
-- Understanding the diference
USE tempdb
GO
IF OBJECT_ID('tempdb.dbo.#TMP')  IS NOT NULL
  DROP TABLE #TMP
GO
CREATE TABLE #TMP (ID Int, Col1 Char(1), Col2 Int)
GO

INSERT INTO #TMP VALUES(1,'A', 5), (2, 'A', 5), (3, 'B', 5), (4, 'C', 5), (5, 'D', 5)
GO
SELECT * FROM #TMP

-- ROWS it's managed by the physical position of the row, independent whether the values of the columns specified in the 
-- order by clause repeat or not
-- If RANGE is specified and the data in the rows duplicate it is considered as ONE range, like a distinct of the rows
SELECT *,
       SUM(Col2) OVER(ORDER BY Col1 RANGE UNBOUNDED PRECEDING) "Range",
       SUM(Col2) OVER(ORDER BY Col1 ROWS UNBOUNDED PRECEDING) "Rows"
  FROM #TMP