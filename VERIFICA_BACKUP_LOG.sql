USE [uoldiveodb]
GO
/*Feito por André Nakazima */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[usp.verifica.bases_sem_backup_de_log] (@TAMANHO_BASE INT,@CAMINHO_BACKUP VARCHAR(200) = NULL)
AS
SET NOCOUNT ON
/*
É Necessário colocar ao menos o parametro do tamanho da base, para que seja feito o backup ou não
O caminho do backup se não for colocado nenhum parametro será buscado da tabela uoldiveodb.backupconfig.....

*/
DECLARE @ver nvarchar(128) 
set @ver = CAST(serverproperty('ProductVersion') AS nvarchar)
SET @ver = SUBSTRING(@ver, 1, CHARINDEX('.', @ver) - 1) -- Verifica a versão do SQL.......
CREATE TABLE #RESULTADO (
RESULTADO INT
)

CREATE TABLE #BACKUP(
NAME VARCHAR (50),
DATA DATETIME2
)

INSERT INTO #RESULTADO -- Insere o resultado da Procedure de monitoramento.
EXEC uoldiveodb.DBO.usp_zabbix_backup_base_dados_recovery_full_sem_backup_log_ultimas_6_horas

IF(SELECT RESULTADO FROM #RESULTADO) = 1 -- Se o resultado da proc.....
BEGIN
IF ( @ver = '8' ) -- SE O SQL FOR O 2000....
INSERT INTO #BACKUP       --Insere os nomes das bases que estão sem backup e insere a data do ultimo backup....
 select  *
		      from  
			 (select d.name,d.crdate    
              from 
              master.dbo.sysdatabases as d 
              where d.name not in('tempdb','msdb','master','model','corpore','uoldiveodb')
              and   convert(varchar(30),databasepropertyex(d.name,'Status')) = 'ONLINE' 
              and   databasepropertyex(d.name,'IsInStandBy') = 0 
              and   convert(varchar(30),databasepropertyex(d.name,'Updateability')) = 'READ_WRITE'
              and   convert(varchar(30),databasepropertyex(d.name,'Recovery'))='FULL'
              and   d.name not in(select distinct database_name  from msdb.dbo.backupset where [type]='L'
                                  and backup_start_date between dateadd(hh, -6, getdate()) and getdate()))consulta
                        
INSERT INTO #BACKUP       --Insere os nomes das bases que estão sem backup e insere a data do ultimo backup....
select  *
		      from  
			 (select d.name,d.create_date      
              from  master.sys.databases as d 
              where d.name not in('tempdb','msdb','master','model','Northwind','pubs')
              and   d.state_desc = 'ONLINE'
              and   d.is_read_only<>1
              and   d.is_in_standby<>1
              and   d.recovery_model_desc='FULL'
              and   d.name not in(select distinct database_name  from msdb.dbo.backupset where [type]='L'
                                  and backup_start_date between dateadd(hh, -6, getdate()) and getdate()))consulta

SELECT * FROM #BACKUP



-- Declarando a variavel
DECLARE @namedatabase VARCHAR (4000)
DECLARE @COMANDO VARCHAR (4000)
DECLARE @CAMINHO VARCHAR(1000)
DECLARE @TAMANHO_BANCO VARCHAR (500)
DECLARE @TAMANHO_DA_BASE INT
SET @TAMANHO_DA_BASE = @TAMANHO_BASE 
-- Declarando o Cursor
DECLARE CUR_DATABASES CURSOR LOCAL FOR

 -- Faz o Select nas bases que estão sem backup....
    SELECT NAME 
		FROM #BACKUP
		WHERE name NOT IN('TESTE','MASTER','tempdb','MSDB','MODEL','REPORTSERVER','ReportServerTempDB')

-- Abre o cursor  
OPEN CUR_DATABASES 
-- Le a proxima linha

FETCH NEXT FROM CUR_DATABASES INTO @namedatabase
-- Enquanto tiver a proxima linha continua....
WHILE @@FETCH_STATUS = 0

BEGIN
DECLARE @USA_BASE VARCHAR (400) 
DECLARE @@TESTE INT
TRUNCATE TABLE #RESULTADO
SET @USA_BASE = 'USE ' +@namedatabase
SET @USA_BASE = @USA_BASE + '
  INSERT INTO #RESULTADO
 SELECT SUM(SIZE * 8)/1024 from sysfiles where fileid =2' 
EXEC (@USA_BASE)


IF (SELECT * FROM #RESULTADO)  < @TAMANHO_DA_BASE
	BEGIN
	IF @CAMINHO_BACKUP IS NULL -- Se não for passado o caminho para a realização do backup....
		BEGIN
			SET @COMANDO ='USE ' + @namedatabase + '
			BACKUP LOG [' +@namedatabase + '] TO  DISK = N''' 
			SET @CAMINHO =  (SELECT backup_full_path FROM uoldiveodb.[dbo].[uoldiveo_backup_config] WHERE @NAMEDATABASE = DATABASE_NAME)
			SET @CAMINHO = @CAMINHO + @namedatabase + '_BACKUP_' + replace(convert(varchar(20),getdate(), 102), '.', '') + '.ltr' + CHAR(39) + '
			'
			SET @COMANDO = @COMANDO + @CAMINHO
			PRINT (@COMANDO)
			--PRINT @CAMINHO
			EXEC (@COMANDO)
			PRINT 'BACKUP DE LOG ' +@NAMEDATABASE + ' REALIZADO COM SUCESSO...'
		END	


	

	IF @CAMINHO_BACKUP IS NOT NULL -- se for passado o caminho...
	BEGIN
	  	SET @COMANDO ='USE ' + @namedatabase + '
			BACKUP LOG [' +@namedatabase + '] TO  DISK = N''' 
			SET @CAMINHO = @CAMINHO_BACKUP
			SET @CAMINHO = @CAMINHO + @namedatabase + '_BACKUP_' + replace(convert(varchar(20),getdate(), 102), '.', '') + '.ltr' + CHAR(39) + '
			'
			SET @COMANDO = @COMANDO + @CAMINHO
			PRINT (@COMANDO)
			--EXEC (@COMANDO)
			PRINT 'BACKUP DE LOG ' +@NAMEDATABASE + ' REALIZADO COM SUCESSO...'
			SET @COMANDO = 'USE '+@namedatabase+ 'DBCC SHRINKFILE(2,0)'
			PRINT (@COMANDO)
			--EXEC (@COMANDO)
			TRUNCATE TABLE #RESULTADO
			END


	END
ELSE 
SELECT 'A base ['+@namedatabase +'] é maior que o valor estipulado no parametro...favor aguardar até a proxima execução da rotina de backup'

TRUNCATE TABLE #RESULTADO
-- Lendo a próxima linha
FETCH NEXT FROM CUR_DATABASES INTO @namedatabase
END

-- Fechando Cursor para leitura
CLOSE CUR_DATABASES

-- Desalocando o cursor
DEALLOCATE CUR_DATABASES

END

ELSE 

SELECT 'TODOS OS BACKUPS ESTÃO OK'
/*Desenvolvido por André Nakazima*/
DROP TABLE #BACKUP 
DROP TABLE #RESULTADO

SET NOCOUNT OFF

