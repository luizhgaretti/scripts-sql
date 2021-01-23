USE ROSARIO
GO

INSERT INTO ROSARIO_ERP..SLJPRO_RR (tipo ,	kardex ,	Cpros ,	Dpros ,	Cunis ,	Clfiscals ,	Origmercs ,	Sittricms ,	Aliqipis ,	Icms ,	cunips ,	mercs ,	cgrus ,	sgrus ,	cproeqs ,	ifors ,	reffs ,	colecoes ,	pcuss ,	moecs ,	custofs ,	moecusfs ,	pvideals ,	pidealcvs ,	moedas ,	custocvs ,	pvens ,	moevs ,	markcvs ,	markupa ,	pesoms ,	pesobris ,	pesopdrs ,	pesometal ,	dtincs ,	datas ,	cclass ,	situas ,	fabrproprs ,	linhas ,	margems ,	tipoinvs ,	codfinp ,	usuincs ,	dpro2s ,	dpro3s ,	matprincs ,	idecpros ,	tptribs ,	emcoms ,	codcors ,	ccodseg ,	cbars)
SELECT 
'7' as tipo,
'' as kardex,
--isnull(SUBSTRING(REPLACE(GRUPO+REFBAS, '.', ''),1,14), '')	AS	cpros	,
--CASE GRUPO WHEN  'DEC' THEN isnull(SUBSTRING(REPLACE(REFBAS, '.', ''),1,14), '') ELSE  isnull(SUBSTRING(REPLACE(GRUPO+REFBAS, '.', ''),1,14), '')	END AS	cpros,
CPROS AS CPROS,
isnull(SUBSTRING(DESMAT,1,80), '') AS	dpros	,
isnull(UNIDADE, '')	AS	cunis	,
 '' 	AS	clfiscals	,
'' as Origmercs,
'' as Sittricms,
'0' as Aliqipis,
'0' as Icms,
'' as cunips,
ISNULL(SUBSTRING(G_GRUPO,1,3),'') as mercs,
isnull(substring(GRUPO, 1, 3), '')	AS	cgrus	,
isnull(SGRUS, '')	AS	sgrus,
'' as cproeqs,
CASE WHEN DEPART = 5 THEN 'MB' ELSE '' END as ifors,
ISNULL(SUBSTRING(CODEAN,1,20), '') as reffs,
'' as colecoes,
isnull(REPLACE(CONVERT(CHAR,convert(NUMERIC(11,3),pcuss)), '.', ''), 0) AS	pcuss	,
ISNULL(CODMOE, '') as moecs,
isnull(REPLACE(CONVERT(CHAR,convert(NUMERIC(11,3),custofs)), '.',''), 0) AS	custofs	,
ISNULL(CODMOE, '') as moecusfs,
isnull(REPLACE(CONVERT(CHAR,convert(numeric(11,2),PRECOV)),'.',''), 0)	AS	pvideals	,
'0' as pidealcvs,
ISNULL(CODMOE, '') as moedas,
'0' as custocvs,
isnull(REPLACE(CONVERT(CHAR,convert(NUMERIC(11,2),PRECOV)), '.', ''), 0)	AS	pvens	,
ISNULL(CODMOE, '') as	moevs ,
'0' as	markcvs ,
'0' as	markupa ,
'0' as	pesoms ,
'0' as	pesobris ,
'0' as	pesopdrs ,
'0' as	pesometal ,
'' as	dtincs ,
'' as	datas ,
'' as	cclass ,
'1' as	situas ,
'0' as	fabrproprs ,
--isnull(substring(CLASS2, 1, 10), '')	AS	linhas	,
'' AS	linhas,
'0' as 	margems ,
'0' as 	tipoinvs ,
CASE CLASS4 WHEN  3 THEN 'M' WHEN 4 THEN 'F' ELSE '' END as 	codfinp ,
'' as 	usuincs ,
ISNULL(REFBAS,'') as 	dpro2s ,
ISNULL(SUBSTRING(DESC_COMPLETA, 1,100),'') as 	dpro3s ,
'' as 	matprincs ,
'' as 	idecpros ,
'' as 	tptribs ,
'0' as 	emcoms ,
CASE CLASS3 WHEN 'OURO AMARELO' THEN 'AM' WHEN 'OURO MISTO' THEN 'MI' WHEN 'OURO BRANCO' THEN 'BR' ELSE '' END  as 	codcors ,
'' as 	ccodseg ,
'' as 	cbars 
 FROM PRODUTO_TMP 

 --WHERE GRUPO = 'DEC'  OR GRUPO = 'PI'


 --select * from ROSARIO_ERP..SLJPRO_RR


--truncate table ROSARIO_ERP..SLJPRO_RR