select
c.NR_BOLETO AS BOLETO,
PRINCIPAL+juros+multa as Repasse,
((PRINCIPAL+juros+multa)+honorario+vr_despesa)as TOTAL_PAGO,
convert(varchar(10), a.dt_retorn_credi,103) as Data_Retorno_Credito,
convert(varchar(10),dtpagto,103) as Data_Pagamento,
c.cd_cedente AS CEDENTE,
disponivel AS TIPO,
c.NR_PARCELA as Parcela


from tbcnab c

inner join acordo01 a on
c.CD_EMPRESA = a.EMPRESA and
c.NR_NOSSO_NUMERO = a.N_NUMERO

where convert(varchar(10),DT_RETORN_CREDI,103) = convert (varchar(10),getdate(),103)
--and a.disponivel != 'msg'
and c.cd_cedente = '00000003897745'
and (day(dtpagto) = day(getdate()-1)
and month (dtpagto) = month(getdate() - 1)
and year(dtpagto) = year(getdate() - 1)) and c.NR_PARCELA = a.parcela


SELECT CAD.C_CON
,CAD.CL_NOM
,A.principal,
convert(varchar(10),par.DT_VENCIMENTO,103) as "Data Vencimento"
,(PRINCIPAL+juros+multa) as Repasse
, HONORARIO
, VR_PREST_ORIG as "prestação original"
,VR_PARC_VRG as "Resíduo"

FROM TBCNAB C, cadcontr cad
, acordo01 a, tbparcel par


WHERE c.cd_cedente = '00000003897745'
AND c.DT_PROCESSAMENT = '2011-10-04'
AND CAD.C_EMP = C.CD_EMPRESA
AND CAD.C_DOS = C.NR_NOSSO_NUMERO 
and c.CD_EMPRESA = a.EMPRESA and
c.NR_NOSSO_NUMERO = a.N_NUMERO
and c.NR_PARCELA = a.parcela
and par.cd_empresa = c.cd_empresa
and par.nr_nosso_numero = c.nr_nosso_numero
and par.nr_parcela = c.nr_parcela


