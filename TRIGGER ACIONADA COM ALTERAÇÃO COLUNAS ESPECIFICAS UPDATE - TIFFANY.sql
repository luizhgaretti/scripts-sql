IF EXISTS (SELECT NAME FROM SYS.SYSOBJECTS WHERE NAME = 'sljpro_trg_update_tptrib')

DROP TRIGGER sljpro_trg_update_tptrib
GO

CREATE trigger sljpro_trg_update_tptrib on dbo.sljpro

after update

as

if update(tptribs)

BEGIN

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

END


/*select  * from sljpro  where tptribs<>'dffp' and clfiscals in (select codigos from slvclf where codigos not in ( '71151000' ,'71162020') and codigos between '71130000' and '71169999')

select* from sljpro  where tptribs<>'SP95' and clfiscals in (select codigos from slvclf where codigos ='95044000')

UPDATE SLJPRO
SET tptribs = 'aa'
WHERE CPROS = '21486272'

UPDATE SLJPRO
SET tptribs = 'bb'
WHERE CPROS = '10292336'

select tptribs, * from sljpro
WHERE CPROS = '21486272'

select tptribs, * from sljpro
WHERE CPROS = '10292336'
*/


