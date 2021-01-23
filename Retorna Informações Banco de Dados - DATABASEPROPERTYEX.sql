/****************************************************************************************
		Utilizando DATABASEPROPERTYEX para retornar configura��es do BD
*****************************************************************************************/

-- Exemplos

-- Retorna Collation
SELECT DATABASEPROPERTYEX('DW', 'Collation');



-- Retorna se Shirink est� habilitado
SELECT DATABASEPROPERTYEX('DW', 'IsAutoShrink');
	-- 1 = Habilitado
	-- 0 = Desabilitado



-- Retorna se o padr�o � NULL ou NOT NULL
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