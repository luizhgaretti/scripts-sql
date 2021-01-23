/*
  Author: Fabiano Neves Amorim
  E-Mail: famorim@solidq.com
  Empresa: SolidQ
  http://blogs.solidq.com/fabianosqlserver/Home.aspx
  http://www.simple-talk.com/author/fabiano-amorim/
*/

USE master
GO

-- Criar um banco de dados chamado SolidQVirtualConference
IF (SELECT DB_ID('SolidQVirtualConference')) IS NULL
BEGIN
  CREATE DATABASE SolidQVirtualConference
END
GO

USE SolidQVirtualConference
GO

/*
  Date Correlation Optimization
*/

-- Preparando o ambiente
SET NOCOUNT ON;
GO
ALTER DATABASE SolidQVirtualConference SET DATE_CORRELATION_OPTIMIZATION OFF;
GO
IF OBJECT_ID('Itens_DateCorrelation') IS NOT NULL
  DROP TABLE Itens_DateCorrelation
GO
IF OBJECT_ID('Pedidos_DateCorrelation') IS NOT NULL
  DROP TABLE Pedidos_DateCorrelation
GO
CREATE TABLE Pedidos_DateCorrelation(ID_Pedido   Integer Identity(1,1),
                                     Data_Pedido DateTime NOT NULL, -- AS COLUNAS DE DATA NÃO PODEM ACEITAR NULL
                                     Valor       Numeric(18,2),
                                     CONSTRAINT  xpk_Pedidos_DateCorrelation PRIMARY KEY NONCLUSTERED(ID_Pedido))
GO
CREATE TABLE Itens_DateCorrelation(ID_Pedido    Integer,
                                   ID_Produto   Integer,
                                   Data_Entrega DateTime NOT NULL, -- AS COLUNAS DE DATA NÃO PODEM ACEITAR NULL
                                   Quantidade   Integer,
                                   CONSTRAINT xpk_Itens_DateCorrelation PRIMARY KEY (ID_Pedido, ID_Produto))
GO

-- Pelo menos uma das colunas de data, tem que pertencerem a um indice cluster
CREATE CLUSTERED INDEX ix_Data_Pedido ON Pedidos_DateCorrelation(Data_Pedido)
GO
CREATE NONCLUSTERED INDEX ix_Data_Entrega ON Itens_DateCorrelation(Data_Entrega)
GO
-- É Obrigatório existir uma foreign key entre as tabelas que contém as datas correlatas
ALTER TABLE Itens_DateCorrelation ADD CONSTRAINT fk_Itens_DateCorrelation_Pedidos_DateCorrelation FOREIGN KEY(ID_Pedido) REFERENCES Pedidos_DateCorrelation(ID_Pedido)
GO

BEGIN TRAN
GO
DECLARE @i Integer 
SET @i = 0 
WHILE @i < 50000
BEGIN 
  INSERT INTO Pedidos_DateCorrelation(Data_Pedido,Valor) 
  VALUES(CONVERT(VarChar(10),GetDate() - ABS(CheckSum(NEWID()) / 10000000),112), ABS(CheckSum(NEWID()) / 1000000)) 
  SET @i = @i + 1 
END 
GO
COMMIT
GO

INSERT INTO Itens_DateCorrelation(ID_Pedido, ID_Produto, Data_Entrega, Quantidade) 
SELECT ID_Pedido, ABS(CheckSum(NEWID()) / 10000000), CONVERT(VarChar(10),Data_Pedido + ABS(CheckSum(NEWID()) / 100000000),112), ABS(CheckSum(NEWID()) / 10000000) 
FROM Pedidos_DateCorrelation 
GO
INSERT INTO Itens_DateCorrelation(ID_Pedido, ID_Produto, Data_Entrega, Quantidade) 
SELECT ID_Pedido, ABS(CheckSum(NEWID()) / 10000), CONVERT(VarChar(10),Data_Pedido + ABS(CheckSum(NEWID()) / 100000000),112), ABS(CheckSum(NEWID()) / 10000000) 
FROM Pedidos_DateCorrelation 
GO
INSERT INTO Itens_DateCorrelation(ID_Pedido, ID_Produto, Data_Entrega, Quantidade) 
SELECT ID_Pedido, ABS(CheckSum(NEWID()) / 100), CONVERT(VarChar(10),Data_Pedido + ABS(CheckSum(NEWID()) / 100000000),112), ABS(CheckSum(NEWID()) / 10000000) 
FROM Pedidos_DateCorrelation 
GO
INSERT INTO Itens_DateCorrelation(ID_Pedido, ID_Produto, Data_Entrega, Quantidade) 
SELECT ID_Pedido, ABS(CheckSum(NEWID()) / 10), CONVERT(VarChar(10),Data_Pedido + ABS(CheckSum(NEWID()) / 100000000),112), ABS(CheckSum(NEWID()) / 10000000) 
FROM Pedidos_DateCorrelation 
GO

-- Visualizando os dados da tabela
SELECT * 
  FROM Pedidos_DateCorrelation
 WHERE ID_Pedido = 1
SELECT * 
  FROM Itens_DateCorrelation
 WHERE ID_Pedido = 1

/*
  Utilizar a data do pedido visualizado na consulta acima 
  Consulta de teste, verificar o plano de excução
*/
SET STATISTICS IO ON
SELECT Pedidos_DateCorrelation.ID_Pedido, 
       Pedidos_DateCorrelation.Data_Pedido, 
       Itens_DateCorrelation.Data_Entrega, 
       Pedidos_DateCorrelation.Valor
  FROM Pedidos_DateCorrelation
 INNER JOIN Itens_DateCorrelation
    ON Pedidos_DateCorrelation.ID_Pedido = Itens_DateCorrelation.ID_Pedido
 WHERE Pedidos_DateCorrelation.Data_Pedido BETWEEN '20101211' AND '20101215'
OPTION (RECOMPILE)
SET STATISTICS IO OFF
GO

-- Vamos habilitar o DATE_CORRELATION_OPTIMIZATION
ALTER DATABASE SolidQVirtualConference SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
ALTER DATABASE SolidQVirtualConference SET DATE_CORRELATION_OPTIMIZATION ON;
GO
ALTER DATABASE SolidQVirtualConference SET MULTI_USER
GO

-- Rodar a consulta novamente, verificar que foi aplicado um filtro na tabela Itens_DateCorrelation
SET STATISTICS IO ON
SELECT Pedidos_DateCorrelation.ID_Pedido, 
       Pedidos_DateCorrelation.Data_Pedido, 
       Itens_DateCorrelation.Data_Entrega, 
       Pedidos_DateCorrelation.Valor
  FROM Pedidos_DateCorrelation
 INNER JOIN Itens_DateCorrelation
    ON Pedidos_DateCorrelation.ID_Pedido = Itens_DateCorrelation.ID_Pedido
 WHERE Pedidos_DateCorrelation.Data_Pedido BETWEEN '20101211' AND '20101212'
OPTION (RECOMPILE)
SET STATISTICS IO OFF
GO

/*
  Pergunta: Devo continuar explicando o internals/magica?
*/








-- Entendendo a mágica
-- Internamente o SQL Server cria uma view indexada com informações sobre as colunas

-- Vamos verificar o nome da view
SELECT * FROM sys.views
-- WHERE is_date_correlation_view = 1
GO

-- Tentar ver os dados da view...
SELECT * FROM [_MPStats_Sys_4316F928_{A48B42C1-56CA-4826-B560-326219E41F64}_fk_Itens_DateCorrelation_Pedidos_DateCorrelation]
GO

-- Vamos criar outra view para poder efetuar o select nela...
-- Exibe o código
sp_helptext [_MPStats_Sys_4316F928_{A48B42C1-56CA-4826-B560-326219E41F64}_fk_Itens_DateCorrelation_Pedidos_DateCorrelation]

-- Vamos criar outra view com o mesmo código para poder efetuar o select nela
IF OBJECT_ID('vw_Test', 'V') IS NOT NULL
  DROP VIEW [dbo].vw_Test
GO
CREATE VIEW [dbo].vw_Test
WITH SCHEMABINDING 
AS 
SELECT DATEDIFF(day, convert(datetime2, '1900-01-01', 121), LEFT_T.[Data_Pedido])/30 as ParentPID, 
       DATEDIFF(day, convert(datetime2, '1900-01-01', 121), RIGHT_T.[Data_Entrega])/30 as ChildPID, 
       COUNT_BIG(*) AS C   
  FROM [dbo].[Pedidos_DateCorrelation] AS LEFT_T 
  JOIN [dbo].[Itens_DateCorrelation] AS RIGHT_T
    ON LEFT_T.[ID_Pedido] = RIGHT_T.[ID_Pedido] 
 GROUP BY DATEDIFF(day, convert(datetime2, '1900-01-01', 121), LEFT_T.[Data_Pedido])/30, 
          DATEDIFF(day, convert(datetime2, '1900-01-01', 121), RIGHT_T.[Data_Entrega])/30


-- Visualizando os dados da view
SELECT * FROM vw_test
GO

-- Suponha a seguinte consulta
SELECT * 
  FROM Pedidos_DateCorrelation 
 INNER JOIN Itens_DateCorrelation
    ON Pedidos_DateCorrelation.ID_Pedido = Itens_DateCorrelation.ID_Pedido 
 WHERE Pedidos_DateCorrelation.Data_Pedido = '20101203'
/* 
  O filtro da clausula where foi aplicado na coluna Data_Pedido, 
  O SQL precisa identificar quais os valores ele deve informar como 
  predicate na tabela Itens_DateCorrelation.Data_Entrega. 
  Vamos passo a passo: 
*/

-- Vamos na view para ver qual é o maior e menor valor para fazer o calculo reverso
-- O Profiler gera este código quando executamos a consulta
SELECT DISTINCT [ChildPID], [ChildPID] 
  FROM [SolidQVirtualConference].[dbo].vw_Test AS [Tbl1009]
 WHERE [Tbl1009].[ParentPID] = datediff(day,CONVERT(datetime,'1900-01-01 00:00:00.000',121),
                                            CONVERT(datetime,'2010-12-03 00:00:00.000',121)) / (30)
GO

-- Com os valores de 1345 e 1346 em mãos o SQL aplica a regra inversa 
-- para poder obter os valores do filtro por Data_Entrega.
SELECT CONVERT(DateTime, '19000101') + (1350 * 30)
SELECT CONVERT(DateTime, '19000101') + ((1351  + 1) * 30)

-- Traduzindo, a partir de 1900-01-01 some (1350 * 30), 
-- neste caso teremos o valor de 2010-11-20 como valor mínimo

-- Feito, com estes dados ele pode incluir o filtro na coluna data_entrega.

SELECT * 
  FROM Pedidos_DateCorrelation 
 INNER JOIN Itens_DateCorrelation
    ON Pedidos_DateCorrelation.ID_Pedido = Itens_DateCorrelation.ID_Pedido 
 WHERE Pedidos_DateCorrelation.Data_Pedido = '20101202'