--DE INICIO, EU IMPORTEI AS TABELAS DO FOX PARA O EXCEL E IMPORTEI O EXCEL PARA O BANCO DE DADOS E FIZ A COMPARACAO ATE FAZER O LINKED SERVER COM O ARQUIVO DBF

--INSERT TABELAS EXCEDENTES
SELECT +' SELECT * INTO DL_Livros_Tabelas_Excedentes..' + NAME + ' FROM [172.40.8.7].VIVSPOSLJ01.DBO.' + NAME 
FROM [172.40.8.7].VIVSPOSLJ01.SYS.sysobjects
	WHERE TYPE = 'U' AND TYPE <> 'S'
		AND NAME  COLLATE SQL_Latin1_General_CP1_CI_AS NOT IN (SELECT NAME FROM VARQUIVOS_FOX..FOX)

--DROP TABELAS EXCEDENTES
SELECT +' DROP TABLE [172.40.8.7].VIVSPOSLJ01.DBO.' + NAME 
FROM [172.40.8.7].VIVSPOSLJ01.SYS.sysobjects
	WHERE TYPE = 'U' AND TYPE <> 'S'
		AND NAME  COLLATE SQL_Latin1_General_CP1_CI_AS NOT IN (SELECT NAME FROM VARQUIVOS_FOX..FOX)