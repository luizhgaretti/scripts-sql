/*
  Sr.Nimbus - OnDemand
  http://www.srnimbus.com.br
  fabiano.amorim@snimbus.com.br
*/

use NorthWind
GO

-- Criando tabelas para testes
IF OBJECT_ID('T1') IS NOT NULL
  DROP TABLE T1
IF OBJECT_ID('T2') IS NOT NULL
  DROP TABLE T2
GO
CREATE TABLE T1 (ID Int)
CREATE TABLE T2 (ID Int)
GO
INSERT INTO T1 VALUES(1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15)
INSERT INTO T2 VALUES(6),(7),(8),(9),(10)
GO
CREATE STATISTICS Stats_T1 ON T1 (ID) WITH FULLSCAN
CREATE STATISTICS Stats_T2 ON T2 (ID) WITH FULLSCAN
GO


-- Visualizando os histogramas
DBCC SHOW_STATISTICS (T1, Stats_T1) WITH HISTOGRAM
GO
DBCC SHOW_STATISTICS (T2, Stats_T2) WITH HISTOGRAM
GO

-- Estima 5 linhas
SELECT * FROM T1
 INNER JOIN T2
    ON T1.ID = T2.ID
OPTION(RECOMPILE, QueryTraceON 2312) -- TF 2312 habilita o novo cardinality estimator
GO

-- Com o CE antigo, estimativa não é tão precisa
SELECT * FROM T1
 INNER JOIN T2
    ON T1.ID = T2.ID
OPTION(RECOMPILE, QueryTraceON 9481) -- TF 9481 desabilita o novo cardinatlity estimator
GO