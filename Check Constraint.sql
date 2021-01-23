/**************************************
	Checando Constraint

**************************************/

-- Checando Constraint
ALTER TABLE dbo.USUARIOFISCAL CHECK CONSTRAINT [fkUSUARIO_USUARIOFISCAL01]
GO


-- Criando com Check de Constraints
ALTER TABLE dbo.USUARIOFISCAL  WITH CHECK ADD  CONSTRAINT [fkUSUARIO_USUARIOFISCAL01] FOREIGN KEY(cdUsuario)
REFERENCES dbo.USUARIO (cdUsuario)
GO