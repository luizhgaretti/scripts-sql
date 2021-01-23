/**********************************************
	Renomeando Coluna de uma Tabela
				SQL Server	
************************************************/


-- Exemplo
EXEC sp_rename 'Esquema.Tabela.Campo', 'CampoNovo', 'COLUMN';
GO


EXEC sp_rename 'dbo.Teste1.TerrID', 'T123', 'COLUMN';
GO