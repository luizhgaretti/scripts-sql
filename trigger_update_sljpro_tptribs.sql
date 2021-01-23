use tiffany_iguatemi

CREATE NONCLUSTERED INDEX skgroup11
ON [dbo].[sljpro] ([clfiscals],[tptribs])
go
drop trigger sljpro_trg_update_tptrib
go

create trigger sljpro_trg_update_tptrib on dbo.sljpro
after update
as
if (select COUNT(*) from sljpro  where tptribs<>'dffp' and clfiscals in (select codigos from slvclf where codigos not in ( '71151000' ,'71162020') and codigos between '71130000' and '71169999')) > 0
begin  
	update sljpro set tptribs='DFFP' where tptribs<>'dffp' and clfiscals in (select codigos from slvclf where codigos not in ( '71151000' ,'71162020') and codigos between '71130000' and '71169999')
end
if (select COUNT(*) from sljpro  where tptribs<>'SP95' and clfiscals in (select codigos from slvclf where codigos ='95044000')) > 0
begin
	update sljpro set tptribs='SP95' where tptribs<>'SP95' and clfiscals in (select codigos from slvclf where codigos ='95044000')
end
go
