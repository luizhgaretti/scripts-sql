
 /*
	 TUDO SOBRE VIEWS
 */


-- Sintaxe
 CREATE VIEW [ schema_name . ] view_name [ (column [ ,...n ] ) ] 
[ WITH <view_attribute> [ ,...n ] ] 
AS select_statement 
[ WITH CHECK OPTION ] [ ; ] -- Essa propriedade garante que todas as operações de Insert, Update devem obedecer os critérios da consulta.


<view_attribute> ::= 
{
    [ ENCRYPTION ]
    [ SCHEMABINDING ]
    [ VIEW_METADATA ] 
} 

-- EXEMPLO 1 -> Criando View com WITH CHECK OPTION
	-- Vai dar erro, pois com esse update o registro sairia dos criterios do select, portando CHECK OPTION bloqueia isso
CREATE VIEW dbo.ViewTeste01
AS
	Select * From UnidadeFederativa
	Where UF = 'SP'
	WITH CHECK OPTION
GO

begin tran
	Update ViewTeste set UF = 'TT'
	Where UF = 'SP'
rollback



-- EXEMPLO 2 -> Criando View com ENCRYPTION
	-- Criptografa as entradas em sys.syscomments que contêm o texto da instrução CREATE VIEW. 
	-- O uso de WITH ENCRYPTION impede que a exibição seja publicada como parte da replicação do SQL Server.
	-- OBS: A sys.syscomments Contém entradas para cada view, Rule, Default, Trigger, Constraint CHECK, Constraint DEFAULT e SPs. A coluna texto contém as instruções de definição SQL originais.
CREATE VIEW dbo.ViewTeste02
WITH ENCRYPTION
AS
	Select * From UnidadeFederativa
	Where UF = 'SP'	
GO

Select * From Sys.syscomments


-- EXEMPLO 3 -> Criando View com SCHEMABINDING
	-- Precisa ser informado o SCHEMA
	-- Não permite alteração nas tabelas E campos especificados na query
CREATE VIEW dbo.ViewTeste03
WITH SCHEMABINDING
AS
	Select ID, UF, Estado From dbo.UnidadeFederativa
	Where UF = 'SP'
GO



-- EXEMPLO 4 -> View Indexada
CREATE UNIQUE CLUSTERED INDEX ix_View1
ON ViewTeste03 (ID Asc)
GO



----------------- 
Select * From sys.views
Select * From sys.sql_expression_dependencies --> Dependencias da Views 
Select * From sys.sql_modules --> Script de criação das Views
Select * From sys.syscomments