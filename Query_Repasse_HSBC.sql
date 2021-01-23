select REPASSE,
HONORARIO,
VR_DESPESA,
sum(repasse+honorario+vr_despesa) as r from ACORDO01
where VENC_ACORDO = '2010-07-05'
group by REPASSE,
HONORARIO,
VR_DESPESA

having sum(repasse+honorario+vr_despesa) = 880.41


select empresa, n_numero, contrato,
nr_acordo, NR_BOLETO, VENC_ACORDO,
CD_BARRA,
sum(PRINCIPAL+juros+multa) as repasse,
sum((PRINCIPAL+juros+multa)+honorario+vr_despesa)as "TOTAL PAGO"

from acordo01
where NR_ACORDO like '%5137314%' 
group by empresa, n_numero, contrato,
nr_acordo, NR_BOLETO, VENC_ACORDO, CD_BARRA

select empresa, n_numero, contrato,
nr_acordo, NR_BOLETO, VENC_ACORDO,
CD_BARRA
--sum(PRINCIPAL+juros+multa) as repasse,
--sum((PRINCIPAL+juros+multa)+honorario+vr_despesa)as "TOTAL PAGO"

from tbbolpar
where NR_ACORDO like '%5137314%' 
group by empresa, n_numero, contrato,
nr_acordo, NR_BOLETO, VENC_ACORDO, CD_BARRA

