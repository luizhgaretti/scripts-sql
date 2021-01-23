
select
c.NR_BOLETO,

PRINCIPAL+juros+multa as Repasse,

((PRINCIPAL+juros+multa)+honorario+vr_despesa)as "TOTAL PAGO",

cast(day(a.dt_retorn_credi) as varchar(2)) + '/'+
cast(month(a.dt_retorn_credi) as varchar(2)) + '/'+
cast (year(a.dt_retorn_credi) as varchar(4)) as "Data Retorno Credito",

--((PRINCIPAL+juros+multa)+honorario+vr_despesa)as "TOTAL PAGO",

cast(day(a.DTPAGTO) as varchar(2)) + '/'+
cast(month(a.DTPAGTO) as varchar(2)) + '/'+
cast (year(a.DTPAGTO) as varchar(4)) as "Data Pagamento",
a.DTPAGTO,
c.cd_cedente,
disponivel,
c.NR_PARCELA as "Parcela TB_parcel",
a.parcela

from tbcnab c

inner join acordo01 a on
c.CD_EMPRESA = a.EMPRESA and
c.NR_NOSSO_NUMERO = a.N_NUMERO

where DT_RETORN_CREDI = '2010-07-20' and
a.disponivel!= 'msg' and c.cd_cedente = '00000003731995' and
dtpagto = '2010-07-19' and c.NR_PARCELA = a.parcela

order by  "TOTAL PAGO"

