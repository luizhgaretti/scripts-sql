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
  Visualizando Estatísticas
*/

IF EXISTS(SELECT * FROM sys.stats WHERE Name = 'Stats_Quantidade' AND object_id = OBJECT_ID('Itens'))
BEGIN
  DROP STATISTICS Itens.Stats_Quantidade
END
GO
CREATE STATISTICS Stats_Quantidade ON Itens(Quantidade) WITH FULLSCAN
GO

DBCC SHOW_STATISTICS (Itens, Stats_Quantidade) WITH HISTOGRAM
GO
/*  
  RANGE_HI_KEY RANGE_ROWS    EQ_ROWS       DISTINCT_RANGE_ROWS  AVG_RANGE_ROWS
  ------------ ------------- ------------- -------------------- --------------
  100          0             56            0                    1
  104          171           59            3                    57
  107          88            60            2                    44
  111          160           64            3                    53,33333
  118          304           60            6                    50,66667
  123          200           56            4                    50
  131          379           68            7                    54,14286
  134          96            41            2                    48
*/
/*
  Consultando o valor 115 no histograma da estatística Stats_Quantidade
  Nota: OPTION(RECOMPILE) para evitar parametrização
*/
SELECT * FROM Itens
WHERE Quantidade = 115
OPTION(RECOMPILE)
/*
  Estimated number of Rows 50,66667
  O Valor 115 não existe no histograma, ele esta entre as chaves
  107 e 111.
  Para o sinal de igualdade, o SQL Utiliza a média de linhas entre
  o range (coluna AVG_RANGE_ROWS) ou seja, 50,66667
*/


/*
  Consultando os itens com quantidade menor que 107
*/
SELECT * FROM Itens
WHERE Quantidade < 107
OPTION(RECOMPILE)
/*
  Estimated number of Rows 374
  Somar os valores das colunas RANGE_ROWS	e EQ_ROWS
  até chegar na amostra com o valor 107.
  Para a amostra do 107 não podemos somar a coluna EQ_ROWS
  pois estamos consultando valores MENOR QUE 107, ou seja, <= 106
  Por isso não podemos ler a EQ_ROWS, pois ela contem a quantidade 
  de linhas para o valor 107.
  Portanto somamos, 0 + 56 + 171 + 59 + 88 = 374
*/

/*
  Consultando os itens com quantidade menor ou igual a 107
*/
SELECT * FROM Itens
WHERE Quantidade <= 107
OPTION(RECOMPILE)
/*
  Estimated number of Rows 434
  Somar os valores das colunas RANGE_ROWS	e EQ_ROWS
  até chegar na amostra com o valor 107.
  Portanto somamos, 0 + 56 + 171 + 59 + 88 + 60 = 434
*/


/* 
  Manutenção das Estatísticas
  
   Mostrar o efeito de estatísticas desatualizadas
  
  - sp_updatestats
  - UPDATE STATISTICS
    WITH ROWCOUNT = ?, PAGECOUNT = ?, STATS_STREAM = ?
*/

ALTER DATABASE SolidQVirtualConference SET AUTO_UPDATE_STATISTICS OFF WITH NO_WAIT
GO

UPDATE TOP (50) PERCENT Itens SET Quantidade = 999
GO

-- Estimativa incorreta, pois as estatisticas estão desatualizadas
SELECT * FROM Itens
WHERE Quantidade = 999
OPTION (RECOMPILE)
GO

ALTER DATABASE SolidQVirtualConference SET AUTO_UPDATE_STATISTICS ON WITH NO_WAIT
GO

-- Estimativa correta, pois o AUTO_UPDATE_STATISTICS é disparado
-- automaticamente
SELECT * FROM Itens
WHERE Quantidade = 999
OPTION (RECOMPILE)

/*
  Quando um auto update statistics é disparado?
  AUTO_UPDATE_STATISTICS
  RowModCtr
  
  - Se a cardinalidade da tabela é menor que seis e a tabela esta no 
  banco de dados tempdb, auto atualiza a cada seis modificações na tabela

  - Se a cardinalidade da tabela é maior que seis e menor ou igual a 500,
  então atualiza as estatísticas a cada 500 modificações na tabela
  
  - Se a cardinalidade da tabela é maior que 500,
  atualiza as estatísticas quando 500 + 20% da tabela for alterada.
  
  No Profiler visualizar os evento SP:StmtCompleted and SP:StmtStarting
*/


/*
  Simulando um GAP nas 200 amostras do histograma
*/


/*
  Setando a coluna quantidade em 500 grupos de 1 a 500
  com de cem (100) linhas em cada grupo.
*/
;WITH CTE
AS
(
SELECT NTILE(500) OVER(ORDER BY ID_Pedido, ID_Produto) Qtd,
       *
  FROM Itens
)
UPDATE CTE SET Quantidade = Qtd;
GO
-- Deixar um GAP no grupo 444
UPDATE Itens SET Quantidade = -1
WHERE Quantidade = 444
GO

-- Atualizando as estatísticas
UPDATE STATISTICS Itens Stats_Quantidade WITH FULLSCAN
GO
-- Visualizando o GAP do valor 444
DBCC SHOW_STATISTICS (Itens, Stats_Quantidade) WITH HISTOGRAM
GO

/*
  Como o valor 444 não esta no histograma ele usa a média de 
  distribuição dos valores (AVG_RANGE_ROWS) entre o range
  
  Neste caso ele estima que 100 linhas serão retornadas o que é errado
*/
SELECT * FROM Itens
WHERE Quantidade = 444
OPTION(RECOMPILE)
GO


/*
  DROP INDEX ix_Quantidade ON Itens (Quantidade)
  Se eu tiver um índice por Quantidade será 
  que não compensa usar o índice?
*/
CREATE INDEX ix_Quantidade ON Itens (Quantidade)
GO

-- SQL Continua não utilizando o índice
SET STATISTICS IO ON
SELECT * FROM Itens
WHERE Quantidade = 444
OPTION(RECOMPILE)
SET STATISTICS IO OFF

-- Vejamos a quantidade de IOs forçando o SEEK
SET STATISTICS IO ON
SELECT * FROM Itens WITH(FORCESEEK)
WHERE Quantidade = 444
OPTION(RECOMPILE)
SET STATISTICS IO OFF

SET STATISTICS IO ON
SELECT * FROM Itens WITH(index=ix_Quantidade)
WHERE Quantidade = 444
OPTION(RECOMPILE)
SET STATISTICS IO OFF

/*
  Criando estatísticas filtradas para resolver o problema
*/

IF EXISTS(SELECT * FROM sys.stats WHERE Name = 'Stats_Quantidade_0_a_200' AND object_id = OBJECT_ID('Itens'))
  DROP STATISTICS Itens.Stats_Quantidade_0_a_200
IF EXISTS(SELECT * FROM sys.stats WHERE Name = 'Stats_Quantidade_201_a_400' AND object_id = OBJECT_ID('Itens'))
  DROP STATISTICS Itens.Stats_Quantidade_201_a_400
IF EXISTS(SELECT * FROM sys.stats WHERE Name = 'Stats_Quantidade_Maior_401' AND object_id = OBJECT_ID('Itens'))
  DROP STATISTICS Itens.Stats_Quantidade_Maior_401
GO
CREATE STATISTICS Stats_Quantidade_0_a_200 ON Itens(Quantidade)   
 WHERE Quantidade >= 0 AND Quantidade <= 200 WITH FULLSCAN
CREATE STATISTICS Stats_Quantidade_201_a_400 ON Itens(Quantidade) 
 WHERE Quantidade >= 201 AND Quantidade <= 400 WITH FULLSCAN
CREATE STATISTICS Stats_Quantidade_Maior_401 ON Itens(Quantidade) 
 WHERE Quantidade >= 401 WITH FULLSCAN
GO

-- Apenas 51 amostras foram analisadas, e o problema do GAP foi corrigido
DBCC SHOW_STATISTICS (Itens, Stats_Quantidade_Maior_401)
GO

-- Com a estimativa correta o SQL utiliza corretamente o índice
SET STATISTICS IO ON
SELECT * FROM Itens
WHERE Quantidade = 444
OPTION(RECOMPILE)
SET STATISTICS IO OFF