select 
c_emp as [Empresa],
c_dos as [Nosso Numero],
c_con as [Contrato],
nr_parcela,
cl_nom as [Nome],
convert(varchar(10),c.c_dat,103) as [Data Entrada],
c_fil as [Filial],
CD_produto as [Produto]


 from CADCONTR c
left join TBPARCEL p

on c.C_EMP = p.CD_EMPRESA
	and c.C_DOS = p.NR_NOSSO_NUMERO

where C_DAT between '2010-01-01' and '2010-12-31'
and (p.NR_parcela is null or nr_parcela = 0)
and C_EMP = 51
and CD_PRODUTO = 10
and C_SIT != 65