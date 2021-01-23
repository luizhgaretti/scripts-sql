/*
  Author: Fabiano Neves Amorim
  E-Mail: famorim@solidq.com
  Empresa: SolidQ
  http://blogs.solidq.com/fabianosqlserver/Home.aspx
  http://www.simple-talk.com/author/fabiano-amorim/
*/

USE SolidQVirtualConference
GO
/*
  Sort
*/

-- ALTER TABLE ProdutosBig DROP COLUMN ColTest
-- Consulta simples para mostrar o Sort por Col1
SELECT * FROM ProdutosBig
 ORDER BY Col1
OPTION (MAXDOP 1)

/*
  Memory Grant e Sorts
*/

-- ALTER TABLE ProdutosBig DROP COLUMN ColTest
ALTER TABLE ProdutosBig ADD ColTest Char(2000) NULL
GO
/*
  2716 = Bom
  2717 = Ruim
  
  Achar o valor(intervalo) onde a consulta começa a ficar ruim
  Comparar os planos  
*/

SELECT *
  FROM ProdutosBig
 WHERE ID_Produto BETWEEN 1 AND 2000 -- 2500, 2600, 2700, 2800
 ORDER BY ColTest

/*
  Quanto de memória foi alocada?
*/
WHILE 1=1
BEGIN
  DECLARE @Str VarChar(200)
  SELECT @Str = Descricao
    FROM ProdutosBig
   WHERE ID_Produto BETWEEN 1 AND 2717 -- 2500, 2600, 2700, 2800
   ORDER BY ColTest
END
GO

-- Rodar em outra sessão
SELECT session_id,
       granted_memory_kb,
       granted_memory_kb / 1024 AS granted_memory_mb,
       used_memory_kb,
       used_memory_kb / 1024 AS used_memory_mb,
       ideal_memory_kb,
       ideal_memory_kb / 1024 AS ideal_memory_mb
  FROM sys.dm_exec_query_memory_grants
 WHERE session_id <> @@SPID
GO

/*
  A quantidade de memória alocada para a consulta não foi o suficiente
  Como influenciar na quandidade de memória alocada para a consulta?
*/

-- Alternativa 1

-- Alterar a quantidade de memória mínima por consulta para 8mb
-- Configuração default é de 1024

exec sys.sp_configure N'min memory per query (KB)', N'8192'
go
reconfigure with override
go
SET STATISTICS TIME ON
DECLARE @Str VarChar(200)
SELECT @Str = Descricao
  FROM ProdutosBig
 WHERE ID_Produto BETWEEN 1 AND 2717
 ORDER BY ColTest
SET STATISTICS TIME OFF
GO
-- 8 mb não é o suficiente, vamos aumentar para 10mb. SELECT 10 * 1024
exec sys.sp_configure N'min memory per query (KB)', N'10240'
go
reconfigure with override
go
SET STATISTICS TIME ON
DECLARE @Str VarChar(200)
SELECT @Str = Descricao
  FROM ProdutosBig
 WHERE ID_Produto BETWEEN 1 AND 2717
 ORDER BY ColTest
SET STATISTICS TIME OFF
GO

-- Voltar o padrão
exec sys.sp_configure N'min memory per query (KB)', N'1024'
go
reconfigure with override
go


-- Alternativa 2
-- Alterar a consulta para aumentar o tamanho da linha
-- Analisar o plano, verificar o valor de row size do compute scalar
SELECT *
  FROM ProdutosBig
 WHERE ID_Produto BETWEEN 1 AND 2717 -- 2500, 2600, 2700, 2800
 ORDER BY CONVERT(VarChar(8000), ColTest)
GO

-- Verificar o grant de memória que foi efetuado
WHILE 1=1
BEGIN
  DECLARE @Str VarChar(200)
  SELECT @Str = Descricao
    FROM ProdutosBig
   WHERE ID_Produto BETWEEN 1 AND 2717 -- 2500, 2600, 2700, 2800
   ORDER BY CONVERT(VarChar(8000), ColTest)
END
GO

/*
  TOP 100 vs TOP 101
*/
-- Roda em 1 segundo
SELECT TOP 100 *
  FROM ProdutosBig
 ORDER BY Col1
OPTION (MAXDOP 1, RECOMPILE)
GO
-- Roda em 25 segundos
SELECT TOP 101 *
  FROM ProdutosBig
 ORDER BY Col1
OPTION (MAXDOP 1, RECOMPILE)
GO

-- Pergunta: Se as consultas tem o mesmo plano e custo, 
-- porque tamanha diferença no tempo?














-- Resposta: Algorítmo de Sort é diferente para valores 
-- maiores que 100.
-- E o algorítmo que ordena os valores maiores que 100 
-- escreve os dados no tempdb

-- Alternativa 1
SELECT Tab1.*, ProdutosBig.ColTest
  FROM ProdutosBig
 INNER JOIN (SELECT TOP 101 ID_Produto, Descricao, Col1 
               FROM ProdutosBig
              ORDER BY Col1) AS Tab1
    ON ProdutosBig.ID_Produto = Tab1.ID_Produto
 ORDER BY Tab1.Col1
OPTION (MAXDOP 1, RECOMPILE)
GO