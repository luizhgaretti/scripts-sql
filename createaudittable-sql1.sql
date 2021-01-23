-- Finalized Script for the Audit Table
USE AdventureWorks;
GO
CREATE TABLE Sales.SpecialOffer_Audit(
	SpecialOfferID INT NULL,
	Description NVARCHAR(255) NULL,
	DiscountPct SMALLMONEY NULL,
	[Type] NVARCHAR(50) NULL,
	Category NVARCHAR(50) NULL,
	StartDate DATETIME NULL,
	EndDate DATETIME NULL,
	MinQty INT NULL,
	MaxQty INT NULL,
	rowguid UNIQUEIDENTIFIER NULL,
	ModifiedDate DATETIME NULL,
	AuditModifiedDate DATETIME NULL,
	AuditType NVARCHAR(20) null
); 
GO
