select * into contas_tmp2 from contas
where emps =  '001'

select * from contas_tmp2

update contas_tmp2
set emps = '100'

begin tran
rollback

insert into contas (ativos, classes, concps, contas, descs, digito, emps, histps, nives, cidchaves, ccobrigs, contarefs, codagluts, codnats, ctimps, contareff, codnatf)
select ativos, classes, concps, contas, descs, digito, emps, histps, nives, LEFT(CONVERT(VARCHAR(1000),NEWID()),20), ccobrigs, contarefs, codagluts, codnats, ctimps, contareff, codnatf
from contas_tmp2

