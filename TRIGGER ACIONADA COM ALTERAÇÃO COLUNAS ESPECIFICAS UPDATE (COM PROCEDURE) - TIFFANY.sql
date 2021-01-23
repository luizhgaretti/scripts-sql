--CRIAÇÃO DA PROCEDURE
IF EXISTS (SELECT NAME FROM SYS.SYSOBJECTS WHERE NAME = 'sljpro_pr_update_tptrib')

DROP TRIGGER sljpro_pr_update_tptrib
GO

CREATE PROCEDURE sljpro_pr_update_tptrib

AS

if (select COUNT(*) from sljpro  where tptribs<>'dffp' and clfiscals in (select codigos from slvclf where codigos not in ( '71151000' ,'71162020') and codigos between '71130000' and '71169999')) > 0
begin  
	update sljpro set tptribs='DFFP' where tptribs<>'dffp' and clfiscals in (select codigos from slvclf where codigos not in ( '71151000' ,'71162020') and codigos between '71130000' and '71169999')

	--PRINT 'OK UPDATE 1'
end
if (select COUNT(*) from sljpro  where tptribs<>'SP95' and clfiscals in (select codigos from slvclf where codigos ='95044000')) > 0
begin
	update sljpro set tptribs='SP95' where tptribs<>'SP95' and clfiscals in (select codigos from slvclf where codigos ='95044000')

	--PRINT 'OK UPDATE 2'
end

--CRIAÇÃO DA TRIGGER
IF EXISTS (SELECT NAME FROM SYS.SYSOBJECTS WHERE NAME = 'sljpro_trg_update_tptrib')

DROP TRIGGER sljpro_trg_update_tptrib
GO

CREATE trigger sljpro_trg_update_tptrib on dbo.sljpro

FOR update

as

if update(clfiscals) or update(tptribs) 

BEGIN

EXEC sljpro_pr_update_tptrib

--PRINT 'UPDATE OK'

END


/*select  * from sljpro  where tptribs<>'dffp' and clfiscals in (select codigos from slvclf where codigos not in ( '71151000' ,'71162020') and codigos between '71130000' and '71169999')

select clfiscals, tptribs,* from sljpro  where tptribs='SP95' and clfiscals in (select codigos from slvclf where codigos ='95044000')

UPDATE SLJPRO
SET tptribs = 'aa'
WHERE CLFISCALS = '71130000'

UPDATE SLJPRO
SET tptribs = 'bb'
WHERE CPROS = '10292336'

UPDATE SLJPRO
SET TPTRIBS = 'aa'
WHERE clfiscals = '71141100'

UPDATE SLJPRO
SET clfiscals = '95044000'
WHERE clfiscals = '12'

select top 2 tptribs, clfiscals, * from sljpro
WHERE clfiscals = '71141100'

select tptribs, * from sljpro
WHERE clfiscals = 'AA'
*/


