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
  Eager Spool - Halloween Problem
*/
SET NOCOUNT ON
IF OBJECT_ID('Funcionarios') IS NOT NULL
  DROP TABLE Funcionarios
GO
CREATE TABLE Funcionarios(ID      Int IDENTITY(1,1) PRIMARY KEY,
                          Nome    Char(7000),
                          Salario Numeric(18,2));
GO
-- Inserir 4 registros para alocar 4 páginas
INSERT INTO Funcionarios(Nome, Salario)
VALUES('Fabiano', 1900),('Felipe',2050),('Nilton', 2070),('Diego', 2090)
GO
CREATE NONCLUSTERED INDEX ix_Salario ON Funcionarios(Salario)
GO

-- Consultar os dados da tabela
SELECT * FROM Funcionarios

-- Aumento do salário em 10%
-- Utiliza o operador Eager Spool
UPDATE Funcionarios SET Salario = Salario * 1.1
  FROM Funcionarios WITH(index=ix_Salario)
 WHERE Salario < 3000
GO

/*
  Lazy Spool
*/
-- Preparando o ambiente
IF OBJECT_ID('Pedidos_LazySpool') IS NOT NULL
  DROP TABLE Pedidos_LazySpool
GO
CREATE TABLE Pedidos_LazySpool (ID         Integer IDENTITY(1,1) PRIMARY KEY,
                     Cliente    Integer NOT NULL,
                     Vendedor   VarChar(30) NOT NULL,
                     Quantidade SmallInt NOT NULL,
                     Valor      Numeric(18,2) NOT NULL,
                     Data       DateTime NOT NULL)
GO
DECLARE @i SmallInt
  SET @i = 0
WHILE @i < 50
BEGIN
  INSERT INTO Pedidos_LazySpool(Cliente, Vendedor, Quantidade, Valor, Data)
  VALUES(ABS(CheckSUM(NEWID()) / 100000000),
         'Fabiano',
         ABS(CheckSUM(NEWID()) / 10000000),
         ABS(CONVERT(Numeric(18,2), 
         (CheckSUM(NEWID()) / 1000000.5))),
         GETDATE() - (CheckSUM(NEWID()) / 1000000)),
         
         (ABS(CheckSUM(NEWID()) / 100000000),
         'Neves',
         ABS(CheckSUM(NEWID()) / 10000000),
         ABS(CONVERT(Numeric(18,2), 
         (CheckSUM(NEWID()) / 1000000.5))),
         GETDATE() - (CheckSUM(NEWID()) / 1000000)),
         
         (ABS(CheckSUM(NEWID()) / 100000000),
         'Amorim',
         ABS(CheckSUM(NEWID()) / 10000000),
         ABS(CONVERT(Numeric(18,2), 
         (CheckSUM(NEWID()) / 1000000.5))),
         GETDATE() - (CheckSUM(NEWID()) / 1000000))
  SET @i = @i + 1
END
GO 

-- Visualizando os dados
SELECT * FROM Pedidos_LazySpool

/*
  Consulta para selecionar todas as compras de um cliente
  com valor menor que a média de compras do mesmo cliente
*/
SELECT Ped1.Cliente, Ped1.Valor
  FROM Pedidos_LazySpool Ped1
 WHERE Ped1.Valor < (SELECT AVG(Ped2.Valor)
                       FROM Pedidos_LazySpool Ped2
                      WHERE Ped2.Cliente = Ped1.Cliente)
OPTION (MAXDOP 1, RECOMPILE)
GO

CREATE INDEX ix_Cliente_Include_Valor ON Pedidos_LazySpool(Cliente) INCLUDE(Valor)
GO

-- Mesmo plano, porém agora sem o Operador de Sort
SELECT Ped1.Cliente, Ped1.Valor
  FROM Pedidos_LazySpool Ped1
 WHERE Ped1.Valor < (SELECT AVG(Ped2.Valor)
                       FROM Pedidos_LazySpool Ped2
                      WHERE Ped2.Cliente = Ped1.Cliente)
OPTION (MAXDOP 1, RECOMPILE)