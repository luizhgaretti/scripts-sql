declare @aux varchar(10)
set @aux = '12345678'
Select REPLICATE('0', 9 - LEN(@aux)) + @aux

replica (no caso o caracter 0) até prencher um total de 9 caracters