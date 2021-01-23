/*************************************
				INDEXES
**************************************/

-- Criando Index CLUSTERED
CREATE CLUSTERED INDEX idx_Tabela9
ON Tabela9 (Campo1)
GO

-- Criando Index UNIQUE
CREATE UNIQUE INDEX AK_UnitMeasure_Name 
   ON Production.UnitMeasure (Name); 


-- Desabilitando
ALTER INDEX Idx_Tabela6 ON TABELA6
DISABLE
GO


-- Recriando todos os niveis no Indices, Esse comando também Recria um indice caso
-- ele foi DESATIVADO
ALTER INDEX idx_Tabela6 ON TABELA6
REBUILD
GO


-- Desframenta somente o nivel Folha
ALTER INDEX idx_Tabela6 ON TABELA6
REORGANIZE
GO


-- Rescreve um indice já existente com as novos configurações
CREATE UNIQUE NONCLUSTERED INDEX idx_Tabela7
ON Tabela6 (Campo2)
With (SORT_IN_TEMPDB = OFF, DROP_EXISTING = ON)