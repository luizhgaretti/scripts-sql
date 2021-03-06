USE [master]
GO
/****** Object:  StoredProcedure [dbo].[sp_exclui_arq_backups]    Script Date: 12/17/2012 16:24:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[sp_exclui_arq_backups] 
--with ENCRYPTION 
as
begin
  DECLARE @name_backup_anterior VARCHAR (255)
  DECLARE @cmd_text VARCHAR (1000)
  DECLARE @namedatabase VARCHAR (255)
  DECLARE @error_message VARCHAR (8000)
  DECLARE @to VARCHAR (8000)
  DECLARE @from VARCHAR (8000)
  DECLARE @assunto VARCHAR (8000)


  SET @error_message = ''
  SET @to = 'dba@localcred.com.br'
  SET @from = 'dba@localcred.com.br'
  SET @assunto = ''

  DECLARE c_databases CURSOR LOCAL FOR SELECT name   
                                       FROM MASTER.dbo.sysdatabases 
                                       WHERE FILENAME like 'E:\SQL_DATA%'
                                       ORDER BY 1

  OPEN c_databases FETCH NEXT FROM c_databases INTO @namedatabase

  WHILE @@fetch_status = 0
  BEGIN

    BEGIN TRY

      SELECT @name_backup_anterior = @namedatabase + '_backup_*.*'
      SELECT @cmd_text = 'del G:\Backups\'+@namedatabase+'\'+ @name_backup_anterior 
      EXEC xp_cmdshell @cmd_text

    END TRY
    BEGIN CATCH 
      SELECT @error_message = 'Erro na Exclusão do arquivo de backup da base: ' + @namedatabase
      SELECT @assunto ='Erro na Exclusão do arquivo de backup da base: ' + @namedatabase
      EXEC MASTER.dbo.sp_SQLNotify 
           @to,
           @from,
           @assunto,
           @error_message
    END CATCH
    FETCH NEXT FROM c_databases INTO @namedatabase
  END
  CLOSE c_databases
  DEALLOCATE c_databases
END