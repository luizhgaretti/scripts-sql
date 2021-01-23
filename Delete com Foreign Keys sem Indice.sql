USE TempDB

/*
DROP TABLE Teste10
DROP TABLE Teste9 
DROP TABLE Teste8 
DROP TABLE Teste7 
DROP TABLE Teste6 
DROP TABLE Teste5 
DROP TABLE Teste4 
DROP TABLE Teste3 
DROP TABLE Teste2 
DROP TABLE Teste1 
DROP TABLE Teste0
*/

-- Vamos criar a tabela Principal, tabela que irá sofrer o DELETE
CREATE TABLE Teste0(ID_Teste0 Int IDENTITY(1,1) PRIMARY KEY,
                    Nome      VarChar(200)      DEFAULT NEWID(),
                    Data      DateTime          DEFAULT GETDATE())

-- Agora vamos criar outras 10 tabelas todas fazendo referencia a tabela TesteA
CREATE TABLE Teste1(ID_Teste1   Int IDENTITY(1,1) PRIMARY KEY,
                    Nome        VarChar(200)      DEFAULT NEWID(),
                    ID_Teste0   Int               REFERENCES Teste0(ID_Teste0))
GO
CREATE TABLE Teste2(ID_Teste2   Int IDENTITY(1,1) PRIMARY KEY,
                    Nome        VarChar(200)      DEFAULT NEWID(),
                    ID_Teste0   Int               REFERENCES Teste0(ID_Teste0))
GO
CREATE TABLE Teste3(ID_Teste3   Int IDENTITY(1,1) PRIMARY KEY,
                    Nome        VarChar(200)      DEFAULT NEWID(),
                    ID_Teste0   Int               REFERENCES Teste0(ID_Teste0))
GO
CREATE TABLE Teste4(ID_Teste4   Int IDENTITY(1,1) PRIMARY KEY,
                    Nome        VarChar(200)      DEFAULT NEWID(),
                    ID_Teste0   Int               REFERENCES Teste0(ID_Teste0))
GO
CREATE TABLE Teste5(ID_Teste5   Int IDENTITY(1,1) PRIMARY KEY,
                    Nome        VarChar(200)      DEFAULT NEWID(),
                    ID_Teste0   Int               REFERENCES Teste0(ID_Teste0))
GO
CREATE TABLE Teste6(ID_Teste6   Int IDENTITY(1,1) PRIMARY KEY,
                    Nome        VarChar(200)      DEFAULT NEWID(),
                    ID_Teste0   Int               REFERENCES Teste0(ID_Teste0))
GO
CREATE TABLE Teste7(ID_Teste7   Int IDENTITY(1,1) PRIMARY KEY,
                    Nome        VarChar(200)      DEFAULT NEWID(),
                    ID_Teste0   Int               REFERENCES Teste0(ID_Teste0))
GO
CREATE TABLE Teste8(ID_Teste8   Int IDENTITY(1,1) PRIMARY KEY,
                    Nome        VarChar(200)      DEFAULT NEWID(),
                    ID_Teste0   Int               REFERENCES Teste0(ID_Teste0))
GO
CREATE TABLE Teste9(ID_Teste9   Int IDENTITY(1,1) PRIMARY KEY,
                    Nome        VarChar(200)      DEFAULT NEWID(),
                    ID_Teste0   Int               REFERENCES Teste0(ID_Teste0))
GO
CREATE TABLE Teste10(ID_Teste10 Int IDENTITY(1,1) PRIMARY KEY,
                    Nome        VarChar(200)      DEFAULT NEWID(),
                    ID_Teste0   Int               REFERENCES Teste0(ID_Teste0))
GO


SET NOCOUNT ON 
DECLARE @I INT, @ID_Teste0 Int
-- Insere 1000 linhas em cada nas tabela
SET @I = 0 
WHILE @I < 100
BEGIN
  INSERT INTO Teste0 DEFAULT VALUES
  SET @ID_Teste0 = @@IDENTITY

  INSERT INTO Teste1 (ID_Teste0) VALUES(@ID_Teste0)
  INSERT INTO Teste2 (ID_Teste0) VALUES(@ID_Teste0)
  INSERT INTO Teste3 (ID_Teste0) VALUES(@ID_Teste0)
  INSERT INTO Teste4 (ID_Teste0) VALUES(@ID_Teste0)
  INSERT INTO Teste5 (ID_Teste0) VALUES(@ID_Teste0)
  INSERT INTO Teste6 (ID_Teste0) VALUES(@ID_Teste0)
  INSERT INTO Teste7 (ID_Teste0) VALUES(@ID_Teste0)
  INSERT INTO Teste8 (ID_Teste0) VALUES(@ID_Teste0)
  INSERT INTO Teste9 (ID_Teste0) VALUES(@ID_Teste0)
  INSERT INTO Teste10(ID_Teste0) VALUES(@ID_Teste0)
  SET @I = @I + 1; 
END
GO

-- Ao tentar efetuar um DELETE na tabela Teste0 o SQL retornar uma mensagem de erro pois existem 
-- tabelas referenciando o valor que está tentando ser apagado.
DELETE FROM Teste0
 WHERE ID_Teste0 = 10

-- Vamos habilitar o SET SHOWPLAN_ALL ON e analisar o execution plan do delete, 
-- repare que o SQL irá fazer um Scan e cada 
-- tabela referenciada para validar se é possível fazer o delete se violar nenhuma foreign key.
SET SHOWPLAN_ALL ON
GO
DELETE FROM Teste0 WHERE ID_Teste0 = 10
GO
SET SHOWPLAN_ALL OFF
/*
DELETE FROM Teste0 WHERE ID_Teste0 = 10

  |--Assert(WHERE:(CASE WHEN NOT [Expr1036] IS NULL THEN (0) ELSE CASE WHEN NOT [Expr1037] IS NULL THEN (1) ELSE CASE WHEN NOT [Expr1038] IS NULL THEN (2) ELSE CASE WHEN NOT [Expr1039] IS NULL THEN (3) ELSE CASE WHEN NOT [Expr1040] IS NULL THEN (4) ELSE CASE WHEN NOT [Expr1041] IS NULL THEN (5) ELSE CASE WHEN NOT [Expr1042] IS NULL THEN (6) ELSE CASE WHEN NOT [Expr1043] IS NULL THEN (7) ELSE CASE WHEN NOT [Expr1044] IS NULL THEN (8) ELSE CASE WHEN NOT [Expr1045] IS NULL THEN (9) ELSE NULL END END END END END END END END END END))
       |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1045] = [PROBE VALUE]))
            |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1044] = [PROBE VALUE]))
            |    |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1043] = [PROBE VALUE]))
            |    |    |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1042] = [PROBE VALUE]))
            |    |    |    |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1041] = [PROBE VALUE]))
            |    |    |    |    |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1040] = [PROBE VALUE]))
            |    |    |    |    |    |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1039] = [PROBE VALUE]))
            |    |    |    |    |    |    |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1038] = [PROBE VALUE]))
            |    |    |    |    |    |    |    |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1037] = [PROBE VALUE]))
            |    |    |    |    |    |    |    |    |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1036] = [PROBE VALUE]))
            |    |    |    |    |    |    |    |    |    |--Clustered Index Delete(OBJECT:([dbo].[Teste0].[PK__Teste0__17EB3F1D]), WHERE:([dbo].[Teste0].[ID_Teste0]=CONVERT_IMPLICIT(int,[@1],0)))
            |    |    |    |    |    |    |    |    |    |--Clustered Index Scan(OBJECT:([dbo].[Teste1].[PK__Teste1__1BBBD001]), WHERE:([dbo].[Teste1].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]))
            |    |    |    |    |    |    |    |    |--Clustered Index Scan(OBJECT:([dbo].[Teste2].[PK__Teste2__1F8C60E5]), WHERE:([dbo].[Teste2].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]))
            |    |    |    |    |    |    |    |--Clustered Index Scan(OBJECT:([dbo].[Teste3].[PK__Teste3__235CF1C9]), WHERE:([dbo].[Teste3].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]))
            |    |    |    |    |    |    |--Clustered Index Scan(OBJECT:([dbo].[Teste4].[PK__Teste4__272D82AD]), WHERE:([dbo].[Teste4].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]))
            |    |    |    |    |    |--Clustered Index Scan(OBJECT:([dbo].[Teste5].[PK__Teste5__2AFE1391]), WHERE:([dbo].[Teste5].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]))
            |    |    |    |    |--Clustered Index Scan(OBJECT:([dbo].[Teste6].[PK__Teste6__2ECEA475]), WHERE:([dbo].[Teste6].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]))
            |    |    |    |--Clustered Index Scan(OBJECT:([dbo].[Teste7].[PK__Teste7__329F3559]), WHERE:([dbo].[Teste7].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]))
            |    |    |--Clustered Index Scan(OBJECT:([dbo].[Teste8].[PK__Teste8__366FC63D]), WHERE:([dbo].[Teste8].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]))
            |    |--Clustered Index Scan(OBJECT:([dbo].[Teste9].[PK__Teste9__3A405721]), WHERE:([dbo].[Teste9].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]))
            |--Clustered Index Scan(OBJECT:([dbo].[Teste10].[PK__Teste10__3E10E805]), WHERE:([dbo].[Teste10].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]))
*/

-- Agora vamos apagar os registros das tabelas referenciadas para não ocorrer o erro.
DELETE FROM Teste1  WHERE ID_Teste0 = 10
DELETE FROM Teste2  WHERE ID_Teste0 = 10
DELETE FROM Teste3  WHERE ID_Teste0 = 10
DELETE FROM Teste4  WHERE ID_Teste0 = 10
DELETE FROM Teste5  WHERE ID_Teste0 = 10
DELETE FROM Teste6  WHERE ID_Teste0 = 10
DELETE FROM Teste7  WHERE ID_Teste0 = 10
DELETE FROM Teste8  WHERE ID_Teste0 = 10
DELETE FROM Teste9  WHERE ID_Teste0 = 10
DELETE FROM Teste10 WHERE ID_Teste0 = 10

-- Executa o DELETE na Teste0 novamente com sucesso.
DELETE FROM Teste0
 WHERE ID_Teste0 = 10

-- Para resolver o problema poderiamos criar indices 
-- nos campos das tabelas com referencia a Teste0
CREATE NONCLUSTERED INDEX IX_ID_Teste0 ON Teste1 (ID_Teste0)
CREATE NONCLUSTERED INDEX IX_ID_Teste0 ON Teste2 (ID_Teste0)
CREATE NONCLUSTERED INDEX IX_ID_Teste0 ON Teste3 (ID_Teste0)
CREATE NONCLUSTERED INDEX IX_ID_Teste0 ON Teste4 (ID_Teste0)
CREATE NONCLUSTERED INDEX IX_ID_Teste0 ON Teste5 (ID_Teste0)
CREATE NONCLUSTERED INDEX IX_ID_Teste0 ON Teste6 (ID_Teste0)
CREATE NONCLUSTERED INDEX IX_ID_Teste0 ON Teste7 (ID_Teste0)
CREATE NONCLUSTERED INDEX IX_ID_Teste0 ON Teste8 (ID_Teste0)
CREATE NONCLUSTERED INDEX IX_ID_Teste0 ON Teste9 (ID_Teste0)
CREATE NONCLUSTERED INDEX IX_ID_Teste0 ON Teste10(ID_Teste0)

-- Vamos analisar novamente o execution plan.
SET SHOWPLAN_ALL ON
GO
DELETE FROM Teste0 WHERE ID_Teste0 = 10
GO
SET SHOWPLAN_ALL OFF
/* Como podemos observar, Varios SEEKS utilizando os indices criados acima.
DELETE FROM Teste0 WHERE ID_Teste0 = 10

  |--Assert(WHERE:(CASE WHEN NOT [Expr1036] IS NULL THEN (0) ELSE CASE WHEN NOT [Expr1037] IS NULL THEN (1) ELSE CASE WHEN NOT [Expr1038] IS NULL THEN (2) ELSE CASE WHEN NOT [Expr1039] IS NULL THEN (3) ELSE CASE WHEN NOT [Expr1040] IS NULL THEN (4) ELSE CASE WHEN NOT [Expr1041] IS NULL THEN (5) ELSE CASE WHEN NOT [Expr1042] IS NULL THEN (6) ELSE CASE WHEN NOT [Expr1043] IS NULL THEN (7) ELSE CASE WHEN NOT [Expr1044] IS NULL THEN (8) ELSE CASE WHEN NOT [Expr1045] IS NULL THEN (9) ELSE NULL END END END END END END END END END END))
       |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1045] = [PROBE VALUE]))
            |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1044] = [PROBE VALUE]))
            |    |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1043] = [PROBE VALUE]))
            |    |    |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1042] = [PROBE VALUE]))
            |    |    |    |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1041] = [PROBE VALUE]))
            |    |    |    |    |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1040] = [PROBE VALUE]))
            |    |    |    |    |    |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1039] = [PROBE VALUE]))
            |    |    |    |    |    |    |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1038] = [PROBE VALUE]))
            |    |    |    |    |    |    |    |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1037] = [PROBE VALUE]))
            |    |    |    |    |    |    |    |    |--Nested Loops(Left Semi Join, OUTER REFERENCES:([dbo].[Teste0].[ID_Teste0]), DEFINE:([Expr1036] = [PROBE VALUE]))
            |    |    |    |    |    |    |    |    |    |--Clustered Index Delete(OBJECT:([dbo].[Teste0].[PK__Teste0__17EB3F1D]), WHERE:([dbo].[Teste0].[ID_Teste0]=CONVERT_IMPLICIT(int,[@1],0)))
            |    |    |    |    |    |    |    |    |    |--Index Seek(OBJECT:([dbo].[Teste1].[IX_ID_Teste0]), SEEK:([dbo].[Teste1].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]) ORDERED FORWARD)
            |    |    |    |    |    |    |    |    |--Index Seek(OBJECT:([dbo].[Teste2].[IX_ID_Teste0]), SEEK:([dbo].[Teste2].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]) ORDERED FORWARD)
            |    |    |    |    |    |    |    |--Index Seek(OBJECT:([dbo].[Teste3].[IX_ID_Teste0]), SEEK:([dbo].[Teste3].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]) ORDERED FORWARD)
            |    |    |    |    |    |    |--Index Seek(OBJECT:([dbo].[Teste4].[IX_ID_Teste0]), SEEK:([dbo].[Teste4].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]) ORDERED FORWARD)
            |    |    |    |    |    |--Index Seek(OBJECT:([dbo].[Teste5].[IX_ID_Teste0]), SEEK:([dbo].[Teste5].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]) ORDERED FORWARD)
            |    |    |    |    |--Index Seek(OBJECT:([dbo].[Teste6].[IX_ID_Teste0]), SEEK:([dbo].[Teste6].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]) ORDERED FORWARD)
            |    |    |    |--Index Seek(OBJECT:([dbo].[Teste7].[IX_ID_Teste0]), SEEK:([dbo].[Teste7].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]) ORDERED FORWARD)
            |    |    |--Index Seek(OBJECT:([dbo].[Teste8].[IX_ID_Teste0]), SEEK:([dbo].[Teste8].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]) ORDERED FORWARD)
            |    |--Index Seek(OBJECT:([dbo].[Teste9].[IX_ID_Teste0]), SEEK:([dbo].[Teste9].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]) ORDERED FORWARD)
            |--Index Seek(OBJECT:([dbo].[Teste10].[IX_ID_Teste0]), SEEK:([dbo].[Teste10].[ID_Teste0]=[dbo].[Teste0].[ID_Teste0]) ORDERED FORWARD)
*/