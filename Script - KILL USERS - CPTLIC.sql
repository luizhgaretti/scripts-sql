--MATA PROCESSOS PRESOS NOS BANCOS
exec sp_killuser [captarmtdb]
exec sp_killuser [captasup]
exec sp_killuser [usuarios]
exec sp_killuser [user]
exec sp_killuser [usuprocs]
exec SP_KILLUSER [CAPTA_VS]
go


--LIMPA A TABELA CPTLIC
DECLARE  @BASE VARCHAR(8000), @SSQL VARCHAR(8000)

DECLARE CBKP CURSOR STATIC FOR 

SELECT 
+ NAME 

FROM MASTER.dbo.sysdatabases   
WHERE name NOT IN ('master', 'msdb','tempdb','model','distribution', 'cep')   
AND NAME NOT LIKE '%TST%'
AND NAME NOT LIKE '%TESTE%'
AND NAME NOT LIKE '%BKP%'
AND NAME NOT LIKE '%BACKUP%'
AND VERSION IS NOT NULL --BASE OFFLINE
AND VERSION <> 0 --BASE OFFLINE

OPEN CBKP
	FETCH NEXT FROM CBKP INTO @BASE
	WHILE  @@Fetch_Status = 0
	BEGIN
		SET @SSQL = 'if exists (select name from ' + @BASE + '.sys.tables where name = ''cptlic'')' + char(10) +
'truncate table ' + @BASE + '..cptlic ' + char(10) --+ 'else print ''''' + char(10)
										
		EXECUTE (@SSQL)
		--PRINT (@SSQL)
	FETCH NEXT FROM CBKP INTO @BASE
	END -- FIM DO WHILE

	CLOSE CBKP
	DEALLOCATE CBKP




