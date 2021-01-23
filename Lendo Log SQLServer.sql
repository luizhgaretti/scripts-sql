/*
	Script para 'ler' o log do SQL Server
*/

Use Master 
GO 

IF OBJECT_ID('dbo.uspErrorLog') IS NOT NULL 
DROP PROCEDURE dbo.uspErrorLog;
GO

CREATE PROCEDURE dbo.uspErrorLog
( -- Quantidade de minutos a retroagir na pesquisa. 
  -- O Default são 30 minutos 
  -- Informe NULL para desconsiderar e não usar este parâmetro 
  @MinutosRetroagir INT = 30,

  -- Data inicial para a pesquisa no log. 
  -- Registros com datas menores serão desconsiderados 
  -- O Default é NULL 
  -- Informe NULL para desconsiderar e não usar este parâmetro 
  @DataInicial DATETIME = NULL, 

   -- Data final para a pesquisa no log. 
   -- Registros com datas maiores serão desconsiderados 
   -- O Default é NULL 
   -- Informe NULL para desconsiderar e não usar este parâmetro 
   @DataFinal DATETIME = NULL,  
   
   -- Texto a ser pesquisado dentro da coluna ProcessInfo do log 
   -- Exemplo: Server, Backup, SPID, etc. 
   -- A pesquisa pelo texto é parcial (em qualquer parte) 
   -- O Default é NULL 
   -- Informe NULL para desconsiderar e não usar este parâmetro 
   @Processo VARCHAR(50) = NULL,

    -- Texto a ser pesquisado dentro da coluna Text do log 
	-- Exemplo: error, starting, etc. 
	-- A pesquisa pelo texto é parcial (em qualquer parte) 
	-- O Default é NULL 
	-- Informe NULL para desconsiderar e não usar este parâmetro 
	@Texto VARCHAR(100) = NULL, 
	
	-- Filtra a pesquisa para exibir apenas o log do nome do servidor informado 
	-- Use este parâmetro quando estiver pesquisando o log de vários servidores ao mesmo tempo 
	-- O Default é NULL 
	-- Informe NULL para desconsiderar e não usar este parâmetro 
	@NomeServidor VARCHAR(128) = NULL
)AS 

DECLARE
	@Tmp TABLE 
	(ID INT IDENTITY,  
	 Data DATETIME,   
	 Processo VARCHAR(50),  
	 Texto VARCHAR(4000) 
	);

INSERT INTO @Tmp (Data, Processo, Texto) exec sp_readerrorlog;

SELECT * FROM @Tmp t
WHERE t.Data >=
CASE WHEN @MinutosRetroagir IS NOT NULL THEN DATEADD(MINUTE, -@MinutosRetroagir, GETDATE())
ELSE t.Data END

AND t.Data >= ISNULL(@DataInicial, t.Data)
AND t.Data <= ISNULL(@DataFinal, t.Data)

AND t.Processo LIKE 
CASE WHEN @Processo IS NOT NULL THEN '%' + @Processo + '%'
ELSE t.Processo END

AND t.Texto LIKE
CASE WHEN @Texto IS NOT NULL THEN '%' + @Texto + '%'
ELSE t.Texto END

AND SERVERPROPERTY('ServerName') = 
ISNULL(@NomeServidor, CONVERT(VARCHAR(128), SERVERPROPERTY('ServerName')))
ORDER BY t.ID DESC;
GO