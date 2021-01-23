USE ROSARIO_ERP
GO

/*
--DROP TABLE SLJCOMPO_TMP

--INSERE SOMENTE OS NÃO REPETIDOS
SELECT
distinct
--RIGHT(NEWID(),20),
'F' AS tipo,
P.CPROS AS cpros,
'GEM' AS cgrus,
ISNULL(C.DESC2_MATS, '')  AS mats,
''  AS cats,
--ISNULL(SUBSTRING(P.[DESC COMPRAS], 1, 40), '')  AS dcompos,
P2.DPROS AS dcompos,
isnull(C.DESC2_QTDS, 0)  AS qtdcvs,
isnull(C.DESC2_QTDS, 0) AS qtds,
P.UNIDADE  AS unicompos,
--isnull(REPLACE(CONVERT(CHAR,convert(NUMERIC(8,3), (REPLACE(C.DESC2_PESO, ',', '')))),'.',''), 0)  AS pesos,
isnull(replace(c.DESC2_PESO, ',','.'),0)  AS pesos,
P.UNIDADE AS cunips,
'RS' AS moeds,
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
INTO SLJCOMPO_TMP
FROM ROSARIO.DBO.PRODUTO_TMP P
JOIN  ROSARIO.DBO.SLJCOMPO_TMP C ON C.CPROS_MATS = P.FILMAT_CODMAT
JOIN ROSARIO_ERP.DBO.SLJPRO P2 ON P2.CPROS = C.DESC2_MATS
WHERE C.DESC2_MATS IS NOT NULL
and C.DESC2_QTDS IS NOT NULL
--AND P.CPROS = 'AN01519'
 --and p.cpros='BR02760' 
 go
 */
 /*************************************************************************************/

INSERT INTO SLJCOMPO 
(
cidchaves,
tipos	,
cpros	,
cgrus	,
mats	,
cats	,
dcompos	,
qtdcvs	,
qtds	,
unicompos	,
pesos	,
cunips	,
moeds	,
obscompos	,
qtscons	,
compos	,
vlrcvs	,
markcvs	,
vlrpvs	,
grupos	,
dscgrp	,
ordems	,
ordts	,
etiqs	
)
SELECT 
RIGHT(NEWID(),20),
tipo,
cpros,
cgrus,
mats,
cats,
dcompos,
qtdcvs,
qtds,
unicompos,
pesos,
cunips,
moeds,
obscompos,
qtscons,
pcompos,
vlrcvs,
markcvs,
vlrpvs,
grupos,
dscgrp,
ordems,
odrts,
ETIQS
FROM SLJCOMPO_TMP

--TRUNCATE TABLE ROSARIO_ERP..SLJCOMPO

--SELECT * FROM SLJCOMPO


