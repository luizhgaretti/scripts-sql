SELECT 
ti_pro.class1	AS	cgrus	,
ti_pro.codncm	AS	clfiscals	,
REPLACE(ti_pro.refpro, '.', '')	AS	cpros	,
ti_pro.unidad	AS	cunis	,
tt_pxf.precom	AS	custofs	,
ti_pro.desmat	AS	dpros	,
ti_pro.class2	AS	linhas	,
tt_pxf.precom	AS	pcuss	,
tt_pre.precov	AS	pvens	,
tt_pre.precov	AS	pvideals	,
ti_pro.class3	AS	sgrus
FROM TT_PRO
JOIN TI_PRO ON TT_PRO.REFBAS = TI_PRO.REFBAS 
LEFT JOIN  TT_PRE ON TT_PRE.FILMAT+TT_PRE.CODMAT = TT_PRE.FILMAT+TT_PRE.CODMAT AND TT_PRE.FILMAT+TT_PRE.CODMAT = TT_PRO.FILMAT+TT_PRO.CODMAT 
LEFT JOIN TT_PXF ON TT_PRE.FILMAT+TT_PRE.CODMAT = TT_PXF.FILMAT+TT_PXF.CODMAT

