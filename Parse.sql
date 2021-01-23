-- ============================================================
-- PARSE
-- ============================================================
SELECT PARSE('13/12/2013' AS datetime2 USING 'en-US') AS Result;


SELECT PARSE('13/12/2013' AS datetime2 USING 'pt-BR') AS Result;


SELECT TRY_PARSE('13/12/2013' AS datetime2 USING 'en-US') AS Result;


SELECT TRY_PARSE('13/12/2013' AS datetime2 USING 'pt-BR') AS Result;