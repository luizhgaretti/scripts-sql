			DECLARE @NOME_CLI nvarchar(255)
			SET @NOME_CLI='CAPTA'
			set dateformat ymd
			DECLARE @COUNT INT,@INICIO INT
			DECLARE @bkpfile nvarchar(255),@DB nvarchar(255),@desc nvarchar(255),@LogFile nvarchar(255),@Name nvarchar(255),@mnam nvarchar(255),@bkpdir nvarchar(55)
			SET @bkpdir='e:\databases\backup\'

			USE TEMPDB
			IF EXISTS(SELECT * FROM TEMPDB..SYSOBJECTS WHERE NAME LIKE '%BANCOS')
			BEGIN
				DROP TABLE ##BANCOS
			END

			SELECT NAME,DBID INTO ##BANCOS FROM MASTER..SYSDATABASES  where name not in('tempdb','cep','model') AND status & 512 = 0 ORDER BY DBID
			SET @INICIO=1
			SET @COUNT=(SELECT MAX(DBID) FROM ##BANCOS)
			WHILE(@INICIO<=@COUNT)
			BEGIN
				IF EXISTS(SELECT * FROM ##BANCOS WHERE DBID=@INICIO)
				BEGIN
					SET @DB=(SELECT NAME FROM ##BANCOS WHERE DBID=@INICIO)
					IF(@DB='MODEL' OR @DB='TEMPDB')
					BEGIN
						PRINT 'TEMPDB/MODEL'
					END
					ELSE
					BEGIN
						SET @Name=@DB+'(Bkp Diário)'
						SET @mnam=@DB+'_Dump' 
						SET @bkpfile=@bkpdir+@DB+'_Full.bak'	
						SET @desc='Bkp '+ltrim(rtrim(CONVERT(nvarchar(255),GETDATE())))

						BACKUP DATABASE @DB TO DISK=@bkpfile WITH INIT,NAME=@Name,DESCRIPTION=@desc ,
						MEDIANAME=@mnam,MEDIADESCRIPTION=@desc,STATS=3
				
						DECLARE @VERSAO nvarchar(255),@HOJE nvarchar(255),@COD_SRV nvarchar(255),@EXECUTAR nvarchar(4000),@CONS nvarchar(4000),@FIS_ARQ nvarchar(4000)
						DECLARE @TIPO CHAR(3)
						DECLARE @TAM decimal(10,1)
						DECLARE @FILE INT
						SET @VERSAO=CASE	WHEN @@VERSION LIKE '%EXPRESS%' THEN 'EXPRESS'
									ELSE 'FULL' END
						SET @HOJE=ltrim(rtrim(CONVERT(nvarchar(255),GETDATE())))
						IF EXISTS(SELECT * FROM TEMPDB..SYSOBJECTS WHERE NAME='##inf_num_files')
						BEGIN
							drop table ##inf_num_files
						END
						Create Table ##inf_num_files(num int)
						insert into ##inf_num_files(num)
						exec('SELECT COUNT(*) FROM '+@db+'..SYSFILES')
						SET @FILE=(select num from ##inf_num_files)
						WHILE @FILE>0	
						BEGIN
							IF EXISTS(SELECT * FROM TEMPDB.DBO.SYSOBJECTS WHERE NAME = '##INFO_DTFILE')
							BEGIN
								drop table ##INFO_DTFILE
							END
							Create Table ##INFO_DTFILE(Filename nvarchar(255),tamanho decimal(10,1))
							INSERT into ##INFO_DTFILE(filename,tamanho)
							EXEC('SELECT FILENAME,CONVERT(decimal(10,1),SIZE)*8/1024 FROM '+@DB+'..SYSFILES WHERE FILEID='+@FILE)
							SET @FIS_ARQ =(SELECT FILENAME FROM ##INFO_DTFILE)
							SET @TAM=(SELECT TAMANHO FROM ##INFO_DTFILE)
							SET @TIPO=(CASE WHEN @FIS_ARQ LIKE '%LOG%' THEN 'LOG'
									WHEN @FIS_ARQ LIKE '%MDF%' THEN 'DAT'
									ELSE '_?_' END)
							SET @COD_SRV=@NOME_CLI+'_'+@@SERVERNAME+'_'+@VERSAO
							SET @CONS='EXEC USP_INSERE_SERVER '
							SET @CONS=@CONS+''''+@NOME_CLI+''','+''''+CONVERT(nvarchar(255),@COD_SRV)+''','+''''+@@SERVERNAME+''','+''''+@VERSAO+''','+''''+ @DB+''','
							SET @CONS=@CONS+''''+@TIPO+''','+''+ltrim(rtrim(CONVERT(nvarchar(255),@TAM)))+','+''''+@FIS_ARQ+''','+''''+@bkpfile+''','+''''+ @HOJE+''','
							SET @CONS=@CONS+' 1'
							SET @EXECUTAR='osql -S200.158.216.85 -d MONITORDBA -Q "'+@CONS+'" -UMonitorDBA -PMonitorDBA'
							EXEC master..XP_CMDSHELL @EXECUTAR
							SET @FILE=@FILE-1
						END
					END
				END
				SET @INICIO=@INICIO+1
			END
			
