SELECT 
CONVERT(VARCHAR(MAX),TextData) AS TEXTDATA
--ApplicationName--, 
--Reads,
--Duration--, 
--EndTime 
INTO #DL_TMP
FROM DL
WHERE ApplicationName NOT LIKE '%SQLAGENT%'
AND ApplicationName NOT LIKE '%CUBO%'
AND ApplicationName NOT LIKE '%DW%'
AND ApplicationName NOT LIKE '%.Net SqlClient Data Provider%'
ORDER BY Reads DESC, Duration DESC

SELECT DISTINCT TextData FROM #DL_TMP