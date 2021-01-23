/*
	Procudure Envia E-mail de Licenças a vencer e vencidas
	Autor: Luiz Henrique Garetti
	Data: 04/09/2014
*/

CREATE PROCEDURE sp_EnviaEmailLicenca
AS
BEGIN

	BEGIN TRY
	BEGIN TRANSACTION

		DECLARE @QtdRegistro	INT
		DECLARE @QtdRegistro2	INT
		DECLARE @Aux			INT
		DECLARE @Aux2			INT
		DECLARE @Mensagem		VARCHAR(MAX)
		DECLARE @Mensagem1		VARCHAR(MAX)
		DECLARE @Inicio			VARCHAR(MAX)
		DECLARE @Inicio2		VARCHAR(MAX)
	
		CREATE TABLE #EnvioTempNaoVencido
		(
			id		INT		IDENTITY,
			Texto	VARCHAR(MAX),
			Mes		INT,
			DataFim DATE
		)

		CREATE TABLE #EnvioTempVencido
		(
			id		INT		IDENTITY,
			Texto	VARCHAR(MAX),
			Mes		INT,
			DataFim DATE
		)

		INSERT #EnvioTempNaoVencido
		SELECT  'Licença do Produto [' + P.nmProduto + '] da empresa ' + E.nmEmpresa + ' vencerá dia ' + CONVERT(VARCHAR(15),P.dtFim), DATEDIFF(Month,GetDate(),dtFim), dtFim
		FROM Produto P
		INNER JOIN Empresa E
			ON P.ciEmpresa = E.ciEmpresa
		WHERE dtinicio is not null
		AND DATEDIFF(Month,GetDate(),dtFim) >= 0
		AND DATEDIFF(Month,GetDate(),dtFim) <= 6

		INSERT #EnvioTempVencido
		SELECT  'Licença do Produto [' + P.nmProduto + '] da empresa ' + E.nmEmpresa + ' está vencida desde ' + CONVERT(VARCHAR(15),P.dtFim), DATEDIFF(Month,GetDate(),dtFim), dtFim
		FROM Produto P
		INNER JOIN Empresa E
			ON P.ciEmpresa = E.ciEmpresa
		WHERE dtinicio is not null
		AND DATEDIFF(Month,GetDate(),dtFim) <= 0

		SELECT @QtdRegistro = Count(*) FROM #EnvioTempNaoVencido WHERE Mes >= 0
		SELECT @QtdRegistro2 = Count(*) FROM #EnvioTempVencido WHERE Mes <= 0

		IF (@QtdRegistro >= 1)
		Begin
			SET @Inicio = '.:: ATENÇÃO ::. ' + CHAR(10) + CHAR(10) + CHAR(10)
			SET @Inicio = @Inicio + '=> Segue Lista de Licença(s) com prazo de vencimento próximo: ' + CHAR(10)
		End

		SET @aux = 0
		SET @aux2 = 1

		IF (@QtdRegistro >= 1)
		BEGIN
			WHILE (@aux2 <= @QtdRegistro)
			BEGIN 
				SET @Mensagem =  (CASE WHEN @Aux2 = 1 THEN @Inicio ELSE @Mensagem END) + CONVERT(VARCHAR(2),@Aux2) + '-'+ (SELECT Texto FROM #EnvioTempNaoVencido WHERE id = @Aux2)
				SET @Mensagem = @Mensagem + CHAR(10) + CHAR(10)
				SET @aux2 = (@aux2 + 1)
			End
		End

		SET @aux = 0
		SET @aux2 = 1
		SET @Mensagem = @Mensagem + CHAR(10) +  '----------------------------------------------------------------------------------------------------------------------' + CHAR(10) + CHAR(10)

		IF (@QtdRegistro >= 1)
		BEGIN
			IF (@QtdRegistro2 >= 1)
			BEGIN
				SET @Mensagem = @Mensagem + '=> Segue Lista de Licença(s) vencidas: ' + CHAR(10)
			END
		END
		ELSE IF (@QtdRegistro2 >= 1)
		BEGIN
			SET @Mensagem = '.:: ATENÇÃO ::. ' + CHAR(10) + CHAR(10) + CHAR(10)
			SET @Mensagem = @Mensagem + '=> Segue Lista de Licença(s) vencidas: ' + CHAR(10)
		END
		ELSE
		BEGIN
			SET @Mensagem = @Mensagem + 'Nenhuma Licença vencida e também com vencidade menor que 6 meses'
		END

		IF (@QtdRegistro2 >= 0)
		BEGIN
			WHILE (@aux2 <= @QtdRegistro2)
			BEGIN 
				SET @Mensagem = @Mensagem + CONVERT(VARCHAR(2),@Aux2) + '-'+ (SELECT Texto FROM #EnvioTempVencido WHERE id = @Aux2)
				SET @Mensagem = @Mensagem + CHAR(10) + CHAR(10)
				SET @aux2 = (@aux2 + 1)
			END
		END

		EXEC msdb.dbo.Sp_Send_DBmail
		@profile_name	= 'LuizHenrique',
		@recipients		= 'luizhgr@rgm.com.br',
		@subject		= 'Controle de Licencimaneto de Software - RGM',
		@Body			= @Mensagem,
		@Body_Format	= 'TEXT'

		DROP TABLE #EnvioTempNaoVencido
		DROP TABLE #EnvioTempVencido
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		IF @@TRANCOUNT > 0
		BEGIN
			ROLLBACK TRANSACTION
		END
	END CATCH
END
GO

EXECUTE sp_EnviaEmailLicenca
GO

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------

/************************************************************************
	Database Utilizado para controlar Licenças dos Softwares da RGM
*************************************************************************/

CREATE DATABASE ControleLicencaRGM
GO

USE ControleLicencaRGM
GO

CREATE TABLE dbo.Empresa
(
	ciEmpresa	INT			IDENTITY	NOT NULL,
	nmEmpresa	VARCHAR(80)				NOT NULL,
	CONSTRAINT pkEmpresa PRIMARY KEY CLUSTERED (ciEmpresa)
)
GO

CREATE TABLE dbo.Produto
(
	ciProduto	INT			IDENTITY	NOT NULL,
	ciEmpresa	INT						NOT NULL,
	nmProduto	VARCHAR(255)			NOT NULL,
	nrLicenca	VARCHAR(50)				NOT NULL,
	inParceria  BIT						NOT NULL,
	inVitalicio BIT						NOT NULL,
	inExperiado BIT						NOT NULL,
	dtInicio	DATE					NULL,
	dtFim		DATE					NULL,
	CONSTRAINT pkProduto PRIMARY KEY CLUSTERED (ciProduto)
)
GO

ALTER TABLE dbo.Produto
ADD CONSTRAINT fkEmpresa_Produto01 FOREIGN KEY (ciEmpresa) REFERENCES dbo.Empresa (ciEmpresa)
GO

EXEC sys.sp_addextendedproperty
	@name=N'inParceria',
	@value=N'0-Não | 1-Sim' , 
	@level0type=N'SCHEMA',
	@level0name=N'dbo',
	@level1type=N'TABLE',
	@level1name=N'Produto'
GO

EXEC sys.sp_addextendedproperty 
	@name=N'inVitalicio', 
	@value=N'0-Licença NÃO é vitalícia | 1-Licença vitalícia',
	@level0type=N'SCHEMA',
	@level0name=N'dbo',
	@level1type=N'TABLE',
	@level1name=N'Produto'
GO

EXEC sys.sp_addextendedproperty 
	@name=N'inExperiado', 
	@value=N'0-Não | 1-Sim' , 
	@level0type=N'SCHEMA',
	@level0name=N'dbo',
	@level1type=N'TABLE',
	@level1name=N'Produto'
GO