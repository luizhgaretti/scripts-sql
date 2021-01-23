SELECT
CONTRATO,
sum(PRINCIPAL+juros+multa) as repasse,
sum((PRINCIPAL+juros+multa)+honorario+vr_despesa)as "TOTAL PAGO",
dt_retorn_credi

FROM ACORDO01
WHERE DT_RETORN_CREDI = '2010-07-06'
GROUP BY CONTRATO,dt_retorn_credi

select
c.NR_BOLETO,
PRINCIPAL+juros+multa as Repasse,
((PRINCIPAL+juros+multa)+honorario+vr_despesa)as "TOTAL PAGO",
cast(day(a.dt_retorn_credi) as varchar(2)) + '/'+
cast(month(a.dt_retorn_credi) as varchar(2)) + '/'+
cast (year(a.dt_retorn_credi) as varchar(4)) as "Data Retorno de Credito",
a.DTPAGTO,
c.cd_cedente,
disponivel,
c.NR_PARCELA as "Parcela TB_parcel",
a.parcela

from tbcnab c
inner join acordo01 a on
c.CD_EMPRESA = a.EMPRESA and
c.NR_NOSSO_NUMERO = a.N_NUMERO
where DT_RETORN_CREDI = '2010-07-06' and
a.disponivel!= 'msg' and c.cd_cedente = '00000003731995' and
dtpagto = '2010-07-05' and c.NR_PARCELA = a.parcela
order by c.nr_boleto





select * from acordo01
where DT_RETORN_CREDI = '2010-07-06' and disponivel!= 'msg' and
dtpagto = '2010-07-05'


select * from tbcnab c
inner join acordo01 a on
c.vr_pago = a.principal and
c.dt_credito = a.dtpagto

where cd_cedente = '00000003731995' and dt_credito = '2010-07-05'

