select * from cadcontr
where C_dat = '2010-10-05'

select 'FINASA VEICULOS' as Empresa
, count(*) as "total carga"
from cadcontr
where c_dat = '2010-10-05'
and c_emp = 200


select 'FINABENS' as Empresa
,count(*) as "total carga"
from cadcontr
where c_dat = '2010-10-05'
and c_emp = 210

select 'FINASA JURIDICO' as Empresa,
count(*) as "Total Carga"
from cadcontr
where c_dat = '2010-10-05'
and c_emp = 211

select * from CADEMPRE
where empr = 211


