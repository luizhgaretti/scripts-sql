-- Tabela com Row Compression
CREATE TABLE Tmp_Row_Compression(ID      Int IDENTITY(1,1) PRIMARY KEY, 
                                 Nome    VarChar(200),
                                 Nome2   Char(200)     DEFAULT NEWID(),
                                 Nome3   Char(200)     DEFAULT NEWID(),
                                 Data    DateTime      DEFAULT GetDate(),
                                 Data1   DateTime      DEFAULT GetDate(),
                                 Valor   Numeric(18,4) DEFAULT 10.5,
                                 Inteiro BigInt        DEFAULT 10)
WITH (DATA_COMPRESSION = ROW);
GO
-- Tabela com Page Compression
CREATE TABLE Tmp_Page_Compression(ID INT IDENTITY(1,1) PRIMARY KEY, 
                                 Nome    VarChar(200),
                                 Nome2   Char(200)     DEFAULT NEWID(),
                                 Nome3   Char(200)     DEFAULT NEWID(),
                                 Data    DateTime      DEFAULT GetDate(),
                                 Data1   DateTime      DEFAULT GetDate(),
                                 Valor   Numeric(18,4) DEFAULT 10.5,
                                 Inteiro BigInt        DEFAULT 10)
WITH (DATA_COMPRESSION = Page);
GO
-- Tabela sem Compression
CREATE TABLE Tmp_Sem_Compression(ID INT IDENTITY(1,1) PRIMARY KEY, 
                                 Nome    VarChar(200),
                                 Nome2   Char(200)     DEFAULT NEWID(),
                                 Nome3   Char(200)     DEFAULT NEWID(),
                                 Data    DateTime      DEFAULT GetDate(),
                                 Data1   DateTime      DEFAULT GetDate(),
                                 Valor   Numeric(18,4) DEFAULT 10.5,
                                 Inteiro BigInt        DEFAULT 10)
GO

SET NOCOUNT ON 
DECLARE @I INT
SET @I = 0 
WHILE @I < 100000
BEGIN
  INSERT INTO Tmp_Row_Compression (Nome) VALUES('Test Row Compression')
  SET @I = @I + 1; 
END
GO

SET NOCOUNT ON 
DECLARE @I INT
SET @I = 0 
WHILE @I < 100000
BEGIN
  INSERT INTO Tmp_Page_Compression(Nome) VALUES('Test Page Compression')
  SET @I = @I + 1; 
END
GO

SET NOCOUNT ON 
DECLARE @I INT
SET @I = 0 
WHILE @I < 100000
BEGIN
  INSERT INTO Tmp_Sem_Compression (Nome) VALUES('Test Sem Compression')
  SET @I = @I + 1; 
END
GO

EXEC dbo.sp_SpaceUsed Tmp_Row_Compression
/* 
Data = 12904 KB, 12 MB
Reserved = 13000 KB, 12 MB
Index_Size = 56 KB
Unused = 40 KB
*/
GO

EXEC dbo.sp_SpaceUsed Tmp_Page_Compression
/* 
Data = 9064 KB, 8 MB
Reserved = 9160 KB, 8 MB
Index_Size = 48 KB
Unused = 48 KB
*/
GO
EXEC dbo.sp_SpaceUsed Tmp_Sem_Compression
/* 
Data = 47064 KB, 45 MB
Reserved = 47304 KB, 46 MB
Index_Size = 184 KB
Unused = 56 KB
*/
GO
DBCC SHOWCONTIG('Tmp_Row_Compression')
-- Pages Scanned : 1613
GO
DBCC SHOWCONTIG('Tmp_Page_Compression')
-- Pages Scanned : 1133
GO
DBCC SHOWCONTIG('Tmp_Sem_Compression')
-- Pages Scanned : 5883
/*
Resultados Finais.
-----------------------------------------------------------------
|_______Tabela________|CPU___|Writes_|Duration__|Tamanho_|Pages_|
|Tmp_Row_Compression	 |10656	|1617	  |45809	    |12 MB	  |1613  |
|Tmp_Page_Compression	|11359	|1142	  |44118	    |8 MB	   |1133  |
|Tmp_Sem_Compression	 |10032	|5914	  |46873	    |46 MB	  |5883  |
-----------------------------------------------------------------
*/