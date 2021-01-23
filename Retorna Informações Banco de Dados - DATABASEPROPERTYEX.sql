/****************************************************************************************
		Utilizando DATABASEPROPERTYEX para retornar configurações do BD
*****************************************************************************************/

-- Exemplos

-- Retorna Collation
SELECT DATABASEPROPERTYEX('DW', 'Collation');



-- Retorna se Shirink está habilitado
SELECT DATABASEPROPERTYEX('DW', 'IsAutoShrink');
	-- 1 = Habilitado
	-- 0 = Desabilitado



-- Retorna se o padrão é NULL ou NOT NULL
SELECT DATABASEPROPERTYEX('DW', 'IsAnsiNullDefault');



-- Retorna Recovery Model
Select DatabasePropertyEx('DB_FullText','Recovery') 
GO



/* =====================================================
		Possiveis Propriedades a serem retornadas.
=====================================================*/
--Collation
--ComparisonStyle
--IsAnsiNullDefault
--IsAnsiNullsEnabled
--vIsAnsiPaddingEnabled
--IsAnsiWarningsEnabled
--IsArithmeticAbortEnabled
--IsAutoClose
--IsAutoCreateStatistics
--IsAutoShrink
--IsAutoUpdateStatistics
--IsCloseCursorsOnCommitEnabled
--IsFulltextEnabled
--IsInStandBy
--IsLocalCursorsDefault
--IsMergePublished
--IsNullConcat
--IsNumericRoundAbortEnabled
--IsParameterizationForced
--IsQuotedIdentifiersEnabled
--IsPublished
--IsRecursiveTriggersEnabled
--IsSubscribed
--IsSyncWithBackup
--IsTornPageDetectionEnabled
--LCID
--Recovery
--SQLSortOrder
--Status
--Updateability
--UserAccess 
--Version