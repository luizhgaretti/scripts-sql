USE ROSARIO
GO
INSERT INTO ROSARIO_ERP..SLJCOMPO_RR (tipo,	cpros,	cgrus,	mats,	cats,	dcompos,	qtdcvs,	qtds,	unicompos,	pesos,	cunips,	moeds,	obscompos,	qtscons,	pcompos,	vlrcvs,	markcvs,	vlrpvs,	grupos,	dscgrp,	ordems,	odrts,	ETIQS)
SELECT
'F' AS tipo,
ISNULL(P.GRUPO+REFBAS, '') AS cpros,
'GEM' AS cgrus,
ISNULL(C.DESC2_MATS, '')  AS mats,
''  AS cats,
--ISNULL(SUBSTRING(P.[DESC COMPRAS], 1, 40), '')  AS dcompos,
'' AS dcompos,
isnull(REPLACE(CONVERT(CHAR,convert(NUMERIC(8,3), C.DESC2_QTDS)), '.', ''), 0)  AS qtdcvs,
isnull(REPLACE(CONVERT(CHAR,convert(NUMERIC(8,3), C.DESC2_QTDS)), '.', ''), 0) AS qtds,
'' AS unicompos,
--isnull(REPLACE(CONVERT(CHAR,convert(NUMERIC(8,3), (REPLACE(C.DESC2_PESO, ',', '')))),'.',''), 0)  AS pesos,
ISNULL(REPLACE(convert(NUMERIC(8,3), replace(DESC2_PESO, ',', '.')), '.', ''), 0)  AS pesos,
'' AS cunips,
'' AS moeds,
'' AS obscompos,
'0' AS qtscons,
--ISNULL(CONVERT(NUMERIC(11,3), ''), '') AS pcompos,
'0' AS pcompos,
--ISNULL(CONVERT(NUMERIC(11,2), ''), '') AS vlrcvs,
'0' AS vlrcvs,
--ISNULL(CONVERT(NUMERIC(9,6), ''), '') AS markcvs,
'0' AS markcvs,
--ISNULL(CONVERT(NUMERIC(11,2), ''), '') AS vlrpvs,
'0' AS vlrpvs,
'' AS grupos,
''  AS dscgrp,
'0'  AS ordems,
'0'  AS odrts,
'' AS ETIQS
FROM PRODUTO_TMP P
JOIN SLJCOMPO_TMP C ON C.CPROS_MATS = P.FILMAT_CODMAT
WHERE C.DESC2_MATS IS NOT NULL
and C.DESC2_QTDS IS NOT NULL
--and P.GRUPO+REFBAS = 'AN0101030832'

--SELECT * FROM ROSARIO_ERP.DBO.SLJCOMPO_RR

--TRUNCATE TABLE ROSARIO_ERP.DBO.SLJCOMPO_RR