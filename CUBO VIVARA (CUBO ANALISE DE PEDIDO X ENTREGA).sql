/*
use vivsposlj01

select empdopnums,emps,numes from sljeest where dopes='pedido de compra' and numes=7543
select ndopes from sljope where dopes='pedido de compra'
select * from sljestpe with (nolock) where empsubns='esc' and codigos=76035744

select empdopnums,emps,numes from sljeest where empdopnums='FABBONK(N) INT-ET FAB   13925'
select ndopes from sljope where dopes='BONK(N) INT-ET FAB'
select * from sljestpe with (nolock) where empsubns='fab' and codigos=1335013925

select empdopnums from sljeest where empdopnums='FABBONK(N) PAR-ET FAB    7543'
select empdopnums,codbarras from sljeesti where empdopnums='FABBONK(N) PAR-ET FAB    7543'

select empdopnums,codbarras from sljesti2 where empdopnums='FABBONK(N) PAR-ET FAB    7543'

select empdopnums from sljeesti with (nolock) where codbarras=27553410 and dopes='TRF PRODUTO FABRICA'

SELECT DATAS, EMPDOPNUMS, numes
FROM SLJEEST WITH (NOLOCK)
WHERE DOPES = 'PEDIDO DE COMPRA'
AND NUMES = 14046

select sljeest.empdopnums,sljestpe.codigos,sljestpe.empsubns,sljope.dopes, pai.empdopnums, sljope.ndopes, 
 from sljeest 
left outer join sljestpe on sljestpe.empdopnums=sljeest.empdopnums
left outer join sljope on sljope.ndopes=cast(substring(str(sljestpe.codigos,10),1,4) as int)
left outer join sljeest pai on pai.emps=sljestpe.empsubns and pai.dopes=sljope.dopes and sljeest.numes = pai.numes and pai.numes=cast(substring(str(sljestpe.codigos,10),5,6) as int) 
where sljeest.empdopnums='FABBONK(N) INT-ET FAB   14046'

/**************************************************************************/

SELECT * FROM SLJEESTI
WHERE CODBARRAS = 15170341

SELECT NDOPES FROM SLJOPE WHERE DOPES = 'BONK(N) PAR-ET FAB'

SELECT * FROM  SLJESTPE WHERE CODIGOS BETWEEN 1336000000 AND 1336999999

SELECT * FROM SLJESTPE WHERE EMPDOPNUMS = 'FABF TRF FAB              303'

SELECT * FROM SLJESTPE WHERE EMPDOPNUMS = 'FABTRF PRODUTO FABRICA   297'

SELECT DOPES FROM SLJOPE WHERE NDOPES = 1337

---------------------------------------------------------------------------------------------------------------------------------------------------------------------

/*SUBINDO O NIVEL DAS OPERA합ES PARA ACHAR O DOPES DO SLJEEST*/

--select * from sljeesti with (nolock) where dopes = 'TRF PRODUTO FABRICA'

--NIVEL 4
--PELO CODIGO DE BARRAS, ACHAR O EMPDOPESNUMS DO ESTPE
select * from sljesti2 with (nolock) where codbarras = 16374047

select * from sljeesti with (nolock) where codbarras = 16374047

--NIVEL 3
--COM ESSA OPERA플O, ACHAR A OPERA플O DO SLJOPE
select * from sljestpe with (nolock) where empdopnums = 'FABBONK(N) PAR-ET FAB    2103'

--NIVEL 2
--COM O NDOPES DO SLJOPE, ACHAR A OPERA플O DO SLJEEST
select dopes from sljope where ndopes = 1335

--NIVEL 1
SELECT DOPES, EMPDOPNUMS FROM SLJEEST --WHERE DOPES = 'BONK(N) INT-ET FAB'  
WHERE EMPDOPNUMS = 'FABBONK(N) PAR-ET FAB    2103'
*/

USE vivsposlj01
GO

--PEDIDO DE COMPRA
SELECT DATAS AS DT_PEDIDO_COMPRA, EMPDOPNUMS AS EMPDOPNUMS_PC
--INTO ##TB_PC
FROM SLJEEST WITH (NOLOCK)
WHERE DOPES = 'PEDIDO DE COMPRA'
AND NUMES = 35744

--BONK(N) INT-ET FAB  
SELECT E.empdopnums AS EMPDOPNUMS_BONK_INT, PE.codigos, PE.empsubns, PE.dopes, E2.empdopnums AS EMPDOPNUMS_F, E.DATAS AS DT_BONK_INT
--INTO ##TB_BONK_INT
FROM SLJEEST E WITH (NOLOCK)
--LEFT JOIN SLJEESTI I WITH (NOLOCK) ON E.EMPDOPNUMS = I.EMPDOPNUMS
LEFT JOIN SLJESTPE PE WITH (NOLOCK) ON E.EMPDOPNUMS = PE.EMPDOPNUMS
LEFT JOIN SLJOPE O WITH (NOLOCK) ON O.NDOPES = CAST(substring (STR(PE.CODIGOS,10),1,4) AS INT)
LEFT JOIN SLJEEST E2 WITH (NOLOCK) ON E2.EMPS = PE.EMPSUBNS AND E2.DOPES = O.DOPES AND E2.NUMES = CAST(substring (str(PE.CODIGOS, 10),5,6) AS INT)
--WHERE E.DOPES = 'BONK(N) INT-ET FAB'
WHERE E2.EMPDOPNUMS = 'ESCPEDIDO DE COMPRA     35744' 

--BONK(N) PAR-ET FAB  
SELECT E.empdopnums AS EMPDOPNUMS_BONK_PAR, PE.codigos, PE.empsubns, PE.dopes, 
E2.empdopnums AS EMPDOPNUMS_F, 
case i.codbarras when 0 then i2.codbarras else i.codbarras end as BARRAS,
case i.cpros when null then i2.cpros else i.cpros end as REFERENCIAS,
E.DATAS AS DT_BONK_PAR
--INTO ##TB_BONK_PAR
FROM SLJEEST E WITH(NOLOCK)
LEFT JOIN SLJEESTI I WITH (NOLOCK) ON I.EMPDOPNUMS = E.EMPDOPNUMS --AND I.CODBARRAS <> 0
LEFT JOIN SLJESTI2 I2 WITH (NOLOCK) ON I2.EMPDOPNUMS = E.EMPDOPNUMS AND I.CITENS = I2.CITENS --AND I2.CODBARRAS <> 0
LEFT JOIN SLJESTPE PE WITH(NOLOCK) ON E.EMPDOPNUMS = PE.EMPDOPNUMS
LEFT JOIN SLJOPE O WITH(NOLOCK) ON O.NDOPES = CAST(substring (STR(PE.CODIGOS,10),1,4) AS INT)
LEFT JOIN SLJEEST E2 WITH (NOLOCK) ON E2.EMPS = PE.EMPSUBNS AND E2.DOPES = O.DOPES AND E2.NUMES = CAST(substring (str(PE.CODIGOS, 10),5,6) AS INT)
WHERE E2.EMPDOPNUMS = 'FABBONK(N) INT-ET FAB   14046' 

--TRF PRODUTO FABRICA
SELECT E.empdopnums AS EMPDOPNUMS_TRF, E.DATAS AS DT_TRF,
CASE I.CODBARRAS WHEN 0 THEN I2.CODBARRAS else I.CODBARRAS END AS BARRAS
--INTO ##TB_TRF
FROM SLJEEST E WITH (NOLOCK)
LEFT JOIN SLJEESTI I ON I.EMPDOPNUMS = E.EMPDOPNUMS AND I.CODBARRAS <> 0
LEFT JOIN SLJESTI2 I2 WITH (NOLOCK) ON I2.EMPDOPNUMS = E.EMPDOPNUMS AND I.CITENS = I2.CITENS AND I2.CODBARRAS <> 0
--WHERE E.DOPES = 'TRF PRODUTO FABRICA' 
WHERE I.CODBARRAS = 27553380

/*
SELECT * FROM ##TB_PC
SELECT * FROM ##TB_BONK_INT
SELECT * FROM ##TB_BONK_PAR
SELECT * FROM ##TB_TRF
*/

SELECT 
T1.DT_PEDIDO_COMPRA, 
T1.EMPDOPNUMS_PC, 
T2.DT_BONK_INT, 
T2.EMPDOPNUMS_BONK_INT, 
T3.REFERENCIAS, 
T3.BARRAS, 
T3.EMPDOPNUMS_BONK_PAR, 
T4.DT_TRF, 
T4.EMPDOPNUMS_TRF
FROM ##TB_PC T1
LEFT JOIN ##TB_BONK_INT T2 ON T2.EMPDOPNUMS_F = T1.EMPDOPNUMS_PC
LEFT JOIN ##TB_BONK_PAR T3 ON T3.EMPDOPNUMS_F = T2.EMPDOPNUMS_BONK_INT
LEFT JOIN ##TB_TRF T4 ON T4.BARRAS = T3.BARRAS


DROP TABLE ##TB_PC
DROP TABLE ##TB_BONK_INT
DROP TABLE ##TB_BONK_PAR
DROP TABLE ##TB_TRF