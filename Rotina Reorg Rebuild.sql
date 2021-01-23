/*
Regra
- Seleciona somente os indices com fragmentação maior que 20%
	- Dentre os selecionados...
		-- Frag >= 30% = Rebuild
		-- Else Reorganize
*/


USE master
GO

DECLARE @Loop	INT, 
		@Qt		INT,
		@Banco	VARCHAR(50)

SELECT
	ROW_NUMBER() OVER(ORDER BY name) Seq,
	Name AS Banco
INTO #Databases
FROM sys.databases
WHERE name NOT IN ('master')  
AND state = 0
AND is_read_only = 0 
AND compatibility_level > 80
ORDER BY Banco

SET @Loop = 1
SET @Qt = (SELECT COUNT(1) FROM #Databases)

WHILE @Loop <= @Qt
BEGIN
	SET @Banco = (SELECT Banco FROM #Databases WHERE Seq = @Loop);
	EXEC(	'USE ' + @Banco +
			'PRINT ''Database em uso: '' + db_name();

			SELECT
				ROW_NUMBER() OVER(ORDER BY p.object_id, p.index_id) AS SEQ,
				t.name AS Tabela,
				h.name AS Esquema,
				i.name AS Indice,
				p.avg_fragmentation_in_percent AS Frag
			INTO #Consulta
			FROM
				sys.dm_db_index_physical_stats(DB_ID(),null,null,null,null) P
			INNER JOIN sys.indexes I
				ON (P.object_id = I.object_id and p.index_id = i.index_id)
			INNER JOIN sys.tables T
				ON (P.object_id = T.object_id)
			INNER JOIN sys.schemas H
				ON (T.schema_id = H.schema_id)
			WHERE p.avg_fragmentation_in_percent > 10.0
			--AND p.page_count > 50
			ORDER BY Esquema, Tabela

			DECLARE @Loop INT
			SET @Loop = 1

			DECLARE	@Total INT
			SET @Total = (SELECT COUNT(*) FROM #Consulta)

			DECLARE	@Comando VARCHAR(500)

			DECLARE	@FILLFACTOR VARCHAR(3) 
			SET @FILLFACTOR = 80

			WHILE @Loop <= @Total
			BEGIN
				SELECT
					@Comando = ''ALTER INDEX '' + Indice + '' ON '' + Esquema + ''.'' + Tabela +
					(CASE WHEN 
						Frag >= 20.0 THEN '' REBUILD WITH (FILLFACTOR = '' + @FILLFACTOR + '', PAD_INDEX = ON, SORT_IN_TEMPDB = ON)'' 
					ELSE 
						'' REORGANIZE'' END)
				FROM #Consulta
				WHERE Seq = @Loop;

				EXEC(@Comando);
				SET @Loop = @Loop + 1;
			END;	
			
			PRINT DB_NAME() + '' Qtde de índices afetados: '' + CONVERT(VARCHAR(5),@Total);
			PRINT ''-----------------------------------'';
			DROP TABLE #Consulta;');

	SET @Loop = @Loop + 1;
END
GO

DROP TABLE #Databases;
GO