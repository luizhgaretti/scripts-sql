INSERT INTO ROSARIO_ERP..SLJPRO_RR (tipo ,	kardex ,	Cpros ,	Dpros ,	Cunis ,	Clfiscals ,	Origmercs ,	Sittricms ,	Aliqipis ,	Icms ,	cunips ,	mercs ,	cgrus ,	sgrus ,	cproeqs ,	ifors ,	reffs ,	colecoes ,	pcuss ,	moecs ,	custofs ,	moecusfs ,	pvideals ,	pidealcvs ,	moedas ,	custocvs ,	pvens ,	moevs ,	markcvs ,	markupa ,	pesoms ,	pesobris ,	pesopdrs ,	pesometal ,	dtincs ,	datas ,	cclass ,	situas ,	fabrproprs ,	linhas ,	margems ,	tipoinvs ,	codfinp ,	usuincs ,	dpro2s ,	dpro3s ,	matprincs ,	idecpros ,	tptribs ,	emcoms ,	codcors ,	ccodseg ,	cbars)
SELECT 
'7' as tipo,
'' as kardex,
isnull(REPLACE(substring(ti_pro.refpro, 1, 14), '.', ''), '')	AS	cpros	,
isnull(ti_pro.desmat, '') AS	dpros	,
isnull(ti_pro.unidad, '')	AS	cunis	,
isnull(ti_pro.codncm, '')	AS	clfiscals	,
'' as Origmercs,
'' as Sittricms,
'0' as Aliqipis,
'0' as Icms,
'' as cunips,
'' as mercs,
isnull(substring(ti_pro.class1, 1, 3), '')	AS	cgrus	,
isnull(substring(ti_pro.class3, 1, 6), '')	AS	sgrus,
'' as cproeqs,
'' as ifors,
'' as reffs,
'' as colecoes,
isnull(REPLACE(CONVERT(CHAR,convert(NUMERIC(11,3),tt_pxf.precom)), '.', ''), 0) AS	pcuss	,
'' as moecs,
isnull(REPLACE(CONVERT(CHAR,convert(NUMERIC(11,3),tt_pxf.precom)), '.',''), 0) AS	custofs	,
--tt_pxf.precom,
'' as moecusfs,
isnull(REPLACE(CONVERT(CHAR,convert(numeric(11,2),tt_pre.precov)),'.',''), 0)	AS	pvideals	,
--tt_pre.precov	,
'0' as pidealcvs,
'' as moedas,
'0' as custocvs,
isnull(REPLACE(CONVERT(CHAR,convert(NUMERIC(11,2),tt_pre.precov)), '.', ''), 0)	AS	pvens	,
'' as	moevs ,
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
isnull(substring(ti_pro.class2, 1, 10), '')	AS	linhas	,
'0' as 	margems ,
'0' as 	tipoinvs ,
'' as 	codfinp ,
'' as 	usuincs ,
'' as 	dpro2s ,
'' as 	dpro3s ,
'' as 	matprincs ,
'' as 	idecpros ,
'' as 	tptribs ,
'0' as 	emcoms ,
'' as 	codcors ,
'' as 	ccodseg ,
'' as 	cbars 
FROM TT_PRO
JOIN TI_PRO ON TT_PRO.REFBAS = TI_PRO.REFBAS 
LEFT JOIN  TT_PRE ON TT_PRE.FILMAT+TT_PRE.CODMAT = TT_PRE.FILMAT+TT_PRE.CODMAT AND TT_PRE.FILMAT+TT_PRE.CODMAT = TT_PRO.FILMAT+TT_PRO.CODMAT 
LEFT JOIN TT_PXF ON TT_PRE.FILMAT+TT_PRE.CODMAT = TT_PXF.FILMAT+TT_PXF.CODMAT
--where ti_pro.refpro  in ('0101080027' ,  '0101090012', '0101080022', '0101010166')
 




--select * from ROSARIO_ERP..SLJPRO_RR


--truncate table ROSARIO_ERP..SLJPRO_RR