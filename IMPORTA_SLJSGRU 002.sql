USE rosario_local
GO

--SELECT CGRUS, codigos, descricaos, cidchaves, cgrucods, nfaixainis, nfaixafins, ntipojoals FROM SLJSGRU
BEGIN TRAN

INSERT INTO SLJSGRU ( CGRUS, codigos, descricaos, cidchaves, cgrucods, nfaixainis, nfaixafins, ntipojoals)
SELECT B.CGRUS AS CGRUS, A.[CODIGO CAPTA] AS CODIGOS, A.CLASS21 AS DESCRICAOS, 
RIGHT(NEWID(),20) AS CIDCHAVES, B.CGRUS+A.[CODIGO CAPTA] AS cgrucods, 0 AS nfaixainis, 0 AS nfaixafins, 0 AS ntipojoals
FROM IMPORT_SUBGRUPOS A
JOIN sljgru B ON B.mercs = A.MERCS

COMMIT

--APAGAR TUDO MENOS GRUS = ‘GEM’
BEGIN TRAN

DELETE FROM SLJSGRU
WHERE CGRUS <> 'GEM'

COMMIT
