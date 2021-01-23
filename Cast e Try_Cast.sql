-- ==============================================================
-- CAST e TRY_CAST
-- ==============================================================
DECLARE @data1 datetime = getdate()

select CAST(@data1 as varchar)

select TRY_CAST(@data1 as varchar)

-------------------------------------------------------------
DECLARE @text1 CHAR(5) = 'SDASD'

--select CAST(@text1 as INT)

select TRY_CAST(@text1 as INT)