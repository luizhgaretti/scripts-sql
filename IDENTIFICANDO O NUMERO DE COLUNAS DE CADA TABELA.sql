SELECT O.NAME AS TABELAS, count(C.NAME) AS [NUMERO DE COLUNAS]
FROM sysobjects O, syscolumns C
WHERE O.id = C.id
--AND O.name = 'SLJPRO'
AND O.type = 'U'
GROUP BY O.name
HAVING COUNT(C.name) > 246