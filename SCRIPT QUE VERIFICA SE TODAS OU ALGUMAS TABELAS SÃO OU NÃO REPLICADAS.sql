SELECT 
UPPER(T.NAME) AS [TABLE NAME],
case 
		when 
			A.NAME IS NULL 
				then 'TABELA NÃO É REPLICADA' 
				else 'TABELA REPLICADA' 
	end AS [REPLICADA / NÃO REPLICADA]
FROM SYS.TABLES T
LEFT JOIN SYSMERGEARTICLES A ON A.OBJID = T.OBJECT_ID
WHERE T.NAME IN 
('sljfpag',
'sljemp2')
ORDER BY 2

/*********************************************************************/

--OU

/*
select 
UPPER(name) AS [TABLE NAME],
	case 
		when 
			is_merge_published = 0 
				then 'TABELA NÃO É REPLICADA' 
				else 'TABELA REPLICADA' 
	end AS [REPLICADA / NÃO REPLICADA]
from sys.tables
where name IN 
('sljfpag',
'sljemp2')
ORDER BY 2
*/
