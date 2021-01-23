-- ==============================================================
-- CONVERT e TRY_CONVERT
-- ==============================================================


DECLARE @text2 CHAR(5) = 'SDASD'

--select Convert(INT,@text2)

select TRY_CONVERT(INT, @text2) 
