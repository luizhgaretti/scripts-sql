-- Criando a Tabela Orders com base no Select da Jun��o de SysColumns
SELECT TOP 10000
 OrderID = IDENTITY(INT,1,1),
 OrderAmt = CAST(ABS(CHECKSUM(NEWID()))%10000 /100.0 AS MONEY),
 OrderDate = CAST(RAND(CHECKSUM(NEWID()))*3653.0+36524.0 AS DATETIME)
INTO dbo.Orders
FROM Master.dbo.SysColumns t1,
Master.dbo.SysColumns t2
go

-- Criando a Tabela OrderDetail --
CREATE TABLE OrderDetail
(OrderID int NOT NULL,
 OrderDetailID int NOT NULL,
 PartAmt money NULL,
 PartID int NULL)

-- Inserindo os Dados em OrderDetail --
Insert Into OrderDetail (OrderID, OrderDetailID, PartAmt, PartID)
Select OrderID,
 OrderDetailID = 1,
 PartAmt = OrderAmt / 2,
 PartID = ABS(CHECKSUM(NEWID()))%1000+1
FROM Orders

-- Consultando os dados --
Select O.OrderId, 
           OD.OrderDetailID, 
           O.OrderAmt, 
           OD.PartAmt, 
           OD.PartID, 
           O.OrderDate
From Orders O Inner Join OrderDetail OD
                            On O.OrderID = OD.OrderID

-- For�ando o Uso do Nested Loop com Op��o Loop Join --
Select O.OrderId, 
           OD.OrderDetailID, 
           O.OrderAmt, 
           OD.PartAmt, 
           OD.PartID, 
           O.OrderDate
From Orders O Inner Join OrderDetail OD
                            On O.OrderID = OD.OrderID
-- This is a hash match for this example
Option (loop join) --force a loop join

-- Adicionando Chaves Prim�rias --
ALTER TABLE dbo.Orders
ADD PRIMARY KEY CLUSTERED (OrderID)
Go

ALTER TABLE dbo.OrderDetail
ADD PRIMARY KEY CLUSTERED (OrderID,OrderDetailID)
Go

-- Consultando os dados, ap�s a Cria��o das Chaves Prim�rias --
Select O.OrderId, 
           OD.OrderDetailID, 
           O.OrderAmt, 
           OD.PartAmt, 
           OD.PartID, 
           O.OrderDate
From Orders O Inner Join OrderDetail OD
                            On O.OrderID = OD.OrderID
                           
-- Fazendo uso do Operador Nested Loop --
Select O.OrderId, 
           OD.OrderDetailID, 
           O.OrderAmt, 
           OD.PartAmt, 
           OD.PartID, 
           O.OrderDate
From Orders O Inner Join OrderDetail OD
                            On O.OrderID = OD.OrderID
Where O.OrderID < 10 