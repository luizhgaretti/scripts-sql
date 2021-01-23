use DBAlwaysOn01 
go
DECLARE @cont int =2

IF NOT EXISTS(SELECT name from sys.tables WHERE name='tab1') 
	CREATE TABLE tab1 (
	col1 int identity(1,1), 
	col2 varchar (100),
	data_hora datetime DEFAULT GETDATE())

WHILE @cont >0
BEGIN
	insert into tab1 (col2) values ('Inserindo registro ' + CAST(@cont as char(1)) + ' no '+@@SERVERNAME)
	SET @cont = @cont -1
END
go
select * from sys.tables
go
select * from tab1 order by col1 desc

/*

drop table tab1


*/

 