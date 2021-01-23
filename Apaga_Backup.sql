
--exec Apaga_Backup_log
create procedure Apaga_Backup_log with encryption 
as
Begin

declare @dia varchar(100)
declare @apagar varchar(20)
SELECT @apagar = convert(varchar(20),getdate()-2,112) 
--PRINT @apagar
--SET @dia  = 'master..xp_cmdshell ''dir V:\MSSQL\BACKUP\*' + @apagar + '*.bak /S/Q'''
SET @dia  = 'master..xp_cmdshell ''del C:\Backup\Log\*.trn /S/Q'''
PRINT @dia
EXEC (@dia)

End
go


----------------------------------------------------------------------------------------------

--exec Apaga_Backup_dif 
create procedure Apaga_Backup_dif with encryption 
as
Begin

declare @dia varchar(100)
declare @apagar varchar(20)
SELECT @apagar = convert(varchar(20),getdate()-2,112) 
--PRINT @apagar
SET @dia  = 'master..xp_cmdshell ''dir V:\MSSQL\BACKUP\*' + @apagar + '*.bak /S/Q'''
--SET @dia  = 'master..xp_cmdshell ''del E:\bkp_sql\dif\*.dif /S/Q'''
--PRINT @dia
EXEC (@dia)

End
go