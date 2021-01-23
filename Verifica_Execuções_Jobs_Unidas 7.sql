USE [master]
GO
/****** Object:  StoredProcedure [dbo].[VERIFICA_BASES_SEM_BACKUP]    Script Date: 06/12/2013 09:35:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 ALTER PROCEDURE [dbo].[usp.verifica.bases_sem_backup] (@TAMANHO_BASE INT,@CAMINHO_BACKUP VARCHAR(200) = NULL)
AS
/*
É Necessário colocar ao menos o parametro do tamanho da base, para que seja feito o backup ou não
O caminho do backup se não for colocado nenhum parametro será buscado da tabela uoldiveodb.backupconfig.....

*/
SET NOCOUNT ON
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
EXEC uoldiveodb.[dbo].[usp_zabbix_backup_base_dados_sem_backup_full_ultimas_24_horas]

IF(SELECT RESULTADO FROM #RESULTADO) = 1 -- Se o resultado da proc.....
BEGIN
IF ( @ver = '8' ) -- SE O SQL FOR O 2000....
INSERT INTO #BACKUP       --Insere os nomes das bases que estão sem backup e insere a data do ultimo backup....
   select  *
                   from  
                     (select     bacs.database_name as banco,
                                 max(bacs.backup_finish_date) as dt_backup
                      from       msdb.dbo.backupmediafamily as bacm
                      inner join msdb.dbo.backupset as bacs
                      on         bacm.media_set_id = bacs.media_set_id 
                      inner join master.dbo.sysdatabases as d
                     on         d.dbid = db_id(bacs.database_name)
                      where      bacs.[type] = 'D'
                      and   convert(varchar(30),databasepropertyex(d.name,'Status')) = 'ONLINE' 
                          and   databasepropertyex(d.name,'IsInStandBy') = 0 
                          and   convert(varchar(30),databasepropertyex(d.name,'Updateability')) = 'READ_WRITE'
                      and   d.name not in('tempdb','model')
                      group by   bacs.database_name) consulta
                   where dt_backup < (select getdate() -1)

                        
INSERT INTO #BACKUP       --Insere os nomes das bases que estão sem backup e insere a data do ultimo backup....
select  *
                   from  
                     (select     bacs.database_name as banco,
                                 max(bacs.backup_finish_date) as dt_backup
                      from       msdb.dbo.backupmediafamily as bacm
                      inner join msdb.dbo.backupset as bacs
                      on         bacm.media_set_id = bacs.media_set_id 
                      inner join master.sys.databases as d
                      on         d.database_id = db_id(bacs.database_name)
                      where      bacs.[type] = 'D'
                      and   d.state_desc = 'ONLINE'
                      and   d.name not in('tempdb','model','Northwind','pubs')
              and   d.is_read_only<>1
              and   d.is_in_standby<>1
                      group by   bacs.database_name) consulta
                   where dt_backup < (select getdate() -1)
--SELECT * FROM #BACKUP



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
DECLARE @RESULT INT
TRUNCATE TABLE #RESULTADO
SET @USA_BASE = 'USE ' +@namedatabase
SET @USA_BASE = @USA_BASE + '
  INSERT INTO #RESULTADO
 SELECT SUM(SIZE * 8)/1024 from sysfiles where fileid =1' 
EXEC (@USA_BASE)


IF (SELECT * FROM #RESULTADO)  < @TAMANHO_DA_BASE
	BEGIN
	IF @CAMINHO_BACKUP IS NULL -- Se não for passado o caminho para a realização do backup....
		BEGIN
			SET @COMANDO ='USE ' + @namedatabase + '
			BACKUP DATABASE [' +@namedatabase + '] TO  DISK = N''' 
			SET @CAMINHO =  (SELECT backup_full_path FROM uoldiveodb.[dbo].[uoldiveo_backup_config] WHERE @NAMEDATABASE = DATABASE_NAME)
			SET @CAMINHO = @CAMINHO + @namedatabase + '_BACKUP_' + replace(convert(varchar(20),getdate(), 102), '.', '') + '.bak' + CHAR(39) + '
			'
			SET @COMANDO = @COMANDO + @CAMINHO
			PRINT (@COMANDO)
			--PRINT @CAMINHO
			--EXEC (@COMANDO)
			PRINT 'BACKUP DA BASE ' +@NAMEDATABASE + ' REALIZADO COM SUCESSO...'
		END	

	

	IF @CAMINHO_BACKUP IS NOT NULL -- se for passado o caminho...
	BEGIN
	  	SET @COMANDO ='USE ' + @namedatabase + '
			BACKUP DATABASE [' +@namedatabase + '] TO  DISK = N''' 
			SET @CAMINHO = @CAMINHO_BACKUP
			SET @CAMINHO = @CAMINHO + @namedatabase + '_BACKUP_' + replace(convert(varchar(20),getdate(), 102), '.', '') + '.bak' + CHAR(39) + '
			'
			SET @COMANDO = @COMANDO + @CAMINHO
			PRINT (@COMANDO)
			--EXEC (@COMANDO)
			PRINT 'BACKUP DA BASE ' +@NAMEDATABASE + ' REALIZADO COM SUCESSO...'
			TRUNCATE TABLE #RESULTADO
			END


	END
ELSE 
SET @RESULT = (SELECT * FROM #RESULTADO)
SELECT  'O BANCO ['+@NAMEDATABASE+'] É MUITO GRANDE PARA FAZER O BACKUP AGORA... POR FAVOR ESPERAR ATÉ A PROXIMA EXECUÇÃO DA ROTINA DE BACKUP' 
--SELECT * FROM #RESULTADO
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

DROP TABLE #BACKUP 
DROP TABLE #RESULTADO

SET NOCOUNT OFF

