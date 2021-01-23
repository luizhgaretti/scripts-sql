/*
  Author: Fabiano Neves Amorim
  E-Mail: famorim@solidq.com
  Empresa: SolidQ
  http://blogs.solidq.com/fabianosqlserver/Home.aspx
  http://www.simple-talk.com/author/fabiano-amorim/
*/

USE tempdb
GO

-- Preparando o ambiente
SET NOCOUNT ON;
IF OBJECT_ID('AluguelCarros') IS NOT NULL
  DROP TABLE AluguelCarros
GO
CREATE TABLE AluguelCarros(ID Int NOT NULL IDENTITY(1,1) PRIMARY KEY,
                           TipoCarro VarChar(200),
                           Valor Numeric(18,2),
                           Carro VarChar(200) NOT NULL DEFAULT NEWID())
GO

;WITH TipoCarros
AS
 (
  SELECT * FROM (VALUES(50, 70, 'Economico'), 
                       (71, 90, 'Intermediario'),
                       (91, 120, 'Executivo'),
                       (120, 200, 'Luxo')) AS Tab(MenorValor, MaiorValor, TipoCarro)
 )
INSERT INTO AluguelCarros(TipoCarro, Valor)
SELECT TipoCarro, MenorValor+ ABS(CHECKSUM(NEWID())) % (MaiorValor-MenorValor)
  FROM TipoCarros
GO 1000


-- Consultando os dados da tabela
SELECT * 
  FROM AluguelCarros
GO

/*
  Veriricar todos os carros do tipo Luxo com valor menor que 110 reais
  
  QO estima que 137,5 linhas ser�o retornadas.  
*/
SELECT * 
  FROM AluguelCarros
 WHERE TipoCarro = 'Luxo'
   AND Valor < 60
OPTION (RECOMPILE)
GO

-- Vamos criar um �ndice para ajudar o SQL na estimativa
-- DROP INDEX ix_TipoCarro_Valor ON AluguelCarros 
CREATE INDEX ix_TipoCarro_Valor ON AluguelCarros (TipoCarro, Valor)
GO

-- E agora a estimativa?
-- Continua com 137,5 linhas, e n�o usou o �ndice
SELECT * 
  FROM AluguelCarros
 WHERE TipoCarro = 'Luxo'
   AND Valor < 60
OPTION (RECOMPILE)
GO

-- Como ele chegou nestas 137,5 linhas?
/*
  Como o SQL n�o consegue entender a correla��o entre as colunas
  ele utiliza a densidade das colunas para poder fazer a estimativa.
  
  1 - Calcula a densidade da coluna TipoCarro
  2 - Cria uma estat�stica para a coluna Valor
  3 - Calcula a densidade da coluna Valor
  4 - Densidade do TipoCarro * Densidade do Valor
  5 - Densidade da multiplica��o (passo 4)

  Vamos simular estes passos com o c�digo abaixo
*/

DBCC SHOW_STATISTICS(AluguelCarros, ix_TipoCarro_Valor)
GO
SELECT 1000./4000. -- Densidade = 0.250000

-- Vericar se existe mais alguma estat�stica na tabela
SELECT * 
  FROM sys.stats
 WHERE object_id = object_id('AluguelCarros')
GO

-- Consultar a estat�stica da coluna Valor
DBCC SHOW_STATISTICS(AluguelCarros, _WA_Sys_00000003_49C3F6B7)
GO

SELECT 550./4000. -- Densidade = 0.137500
GO

SELECT 0.250000 * 0.137500 -- Densidade final = 0.034375000000
GO

SELECT 0.034375000000 * 4000.
GO


/*
  1 - Alternativa
  For�ar o uso do �ndice
*/

-- Corrige o problema de fazer o Scan, mas n�o corrige a estimativa
SELECT * 
  FROM AluguelCarros WITH(index=ix_TipoCarro_Valor)
 WHERE TipoCarro = 'Luxo'
   AND Valor < 60
OPTION (RECOMPILE)
GO

/*
  2 - Alternativa
  Criar um �ndice coberto
*/

CREATE INDEX ix_Covered_Index ON AluguelCarros(TipoCarro, Valor) INCLUDE(Carro)
GO
-- Continua corrigindo o problema de fazer o Scan, mas sem corrigir a estimativa
SELECT * 
  FROM AluguelCarros
 WHERE TipoCarro = 'Luxo'
   AND Valor < 60
OPTION (RECOMPILE)
GO

DROP INDEX ix_Covered_Index ON AluguelCarros
GO

/*
  3 - Alternativa
  Filtered Statistics
*/

CREATE STATISTICS ix_AluguelCarros_Economico ON AluguelCarros(Valor) 
 WHERE TipoCarro = 'Economico'
GO
CREATE STATISTICS ix_AluguelCarros_Intermediario ON AluguelCarros(Valor) 
 WHERE TipoCarro = 'Intermediario'
GO
CREATE STATISTICS ix_AluguelCarros_Executivo ON AluguelCarros(Valor) 
 WHERE TipoCarro = 'Executivo'
GO
CREATE STATISTICS ix_AluguelCarros_Luxo ON AluguelCarros(Valor) 
 WHERE TipoCarro = 'Luxo'
GO
-- Criar uma estat�sticas para cobrir novas categorias
CREATE STATISTICS ix_AluguelCarros_Outros ON AluguelCarros(Valor) 
 WHERE TipoCarro <> 'Luxo' 
   AND TipoCarro <> 'Executivo' 
   AND TipoCarro <> 'Intermediario'
   AND TipoCarro <> 'Economico'
GO

-- Consulta utilizando o �ndice corretamente
SELECT * 
  FROM AluguelCarros
 WHERE TipoCarro = 'Luxo'
   AND Valor < 60
OPTION (RECOMPILE)
GO