use lopaname 
go
delete cctbpres

begin tran
set identity_insert cctbpres on
go
insert into cctbpres
(RECNUM,
	DT_PAGAMENTO,
	
NM_SEMANA_PAGTO,
	DT_PRESTACAO,
	NM_SEMANA_PREST)
(select RECNUM,
	DT_PAGAMENTO,

	NM_SEMANA_PAGTO,
	DT_PRESTACAO,
	NM_SEMANA_PREST
from lofinasa..cctbpres)
go
set identity_insert cctbpres off

commit