

-- Informações sobre a Versão do SQL Server Instalado
SELECT
SERVERPROPERTY('ProductVersion') AS ProductVersion,
SERVERPROPERTY('ProductLevel') AS ProductLevel,
SERVERPROPERTY('Edition') AS Edition,
SERVERPROPERTY('EngineEdition') AS EngineEdition;
GO



-- Restorna Informações Sobre a Instancia
SELECT	
SERVERPROPERTY('servername') As "Nome do Servidor",
SERVERPROPERTY('productversion') As Versão,
SERVERPROPERTY ('productlevel') As "Service Pack", 
SERVERPROPERTY ('edition') As Edição, @@Version As "Sistema Operacional"
GO




/****************************************************
		Outras Possibilidades de Propriedade
*****************************************************/
--BuildClrVersion
--Collation
--CollationID
--ComparisonStyle
--ComputerNamePhysicalNetBIOS
--Edition
--EditionID
--EngineEdition
--HadrManagerStatus
--InstanceName
--IsClustered
--IsFullTextInstalled
--IsHadrEnabled 
--IsIntegratedSecurityOnly
--IsLocalDB
--IsSingleUser
--LCID
--LicenseType
--MachineName
--NumLicenses
--ProcessID
--ProductVersion
--ProductLevel
--ResourceLastUpdateDateTime
--ResourceVersion
--ServerName
--SqlCharSet
--SqlCharSetName
--SqlSortOrder
--SqlSortOrderName
--FilestreamShareName
--FilestreamConfiguredLevel
--FilestreamEffectiveLevel