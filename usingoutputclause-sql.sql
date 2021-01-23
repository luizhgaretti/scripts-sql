-- Sample Usage of the OUTPUT Clause
USE AdventureWorks
GO
UPDATE Sales.SpecialOffer
   SET description = 'Big Mountain Tire Sale'
OUTPUT deleted.SpecialOfferID
	,deleted.Description
	,deleted.DiscountPct
	,deleted.[Type]
	,deleted.Category
	,deleted.StartDate
	,deleted.EndDate
	,deleted.MinQty
	,deleted.MaxQty
	,deleted.rowguid
	,deleted.ModifiedDate
	,GETDATE()
	,'UPDATE' INTO Sales.SpecialOffer_Audit
 WHERE SpecialOfferID = 10
