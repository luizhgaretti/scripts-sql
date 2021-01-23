use locredvd
INSERT INTO [LOCREDVD].[dbo].[ACORDO01]
           ([EMPRESA]
           ,[N_NUMERO]
           ,[PARCELA]
           ,[PARCIAL]
           ,[NUMPRES]
           ,[TIPO]
           ,[VENCIMENTO]
           ,[PRINCIPAL]
           ,[CORRECAO]
           ,[JUROS]
           ,[MULTA]
           ,[HONORARIO]
           ,[DTACORDO]
           ,[VENC_ACORDO]
           ,[CONTRATO]
           ,[DTPAGTO]
           ,[CONTA]
           ,[DTPRCONTA]
           ,[NOME]
           ,[PGTO_DC]
           ,[RECIBO]
           ,[DTPLANILHA]
           ,[ULTIMO]
           ,[ATENDENTE]
           ,[DISPONIVEL]
           ,[DTEMISSAO]
           ,[DAC]
           ,[REPASSE]
           ,[CARTORIO]
           ,[VLR_PARCELA]
           ,[FAIXA]
           ,[FILIAL]
           ,[CD_PRODUTO]
           ,[DT_PREST_PREVIS]
           ,[DT_REAPRESENTAC]
           ,[DT_ENVIO]
           ,[DT_CHEQUE_DEVOL]
           ,[DT_ACORD_CANCEL]
           ,[VR_PAGAMENTO]
           ,[CD_ALINEA]
           ,[CD_FILIAL_ACORD]
           ,[TX_HONO_CREDIC]
           ,[VR_HONO_CREDIC]
           ,[DT_RETORN_CREDI]
           ,[IND_D_C_F]
           ,[CD_BANCO]
           ,[CD_AGENCIA]
           ,[CD_CONTA]
           ,[NR_CHEQUE]
           ,[DT_BOM_PARA]
           ,[NR_SERIE_RECIBO]
           ,[TX_DESCONTO]
           ,[TX_HONORARIO]
           ,[VR_PG_DINHEIRO]
           ,[VR_PG_OP]
           ,[NR_OP]
           ,[VR_PG_CHEQUE]
           ,[OBSERVACAO])
SELECT 
	   [EMPRESA]
      ,[N_NUMERO]
      ,[PARCELA]
      ,[PARCIAL]
      ,[NUMPRES]
      ,[TIPO]
      ,[VENCIMENTO]
      ,[PRINCIPAL]
      ,[CORRECAO]
      ,[JUROS]
      ,[MULTA]
      ,[HONORARIO]
      ,[DTACORDO]
      ,[VENC_ACORDO]
      ,[CONTRATO]
      ,[DTPAGTO]
      ,[CONTA]
      ,[DTPRCONTA]
      ,[NOME]
      ,[PGTO_DC]
      ,[RECIBO]
      ,[DTPLANILHA]
      ,[ULTIMO]
      ,[ATENDENTE]
      ,[DISPONIVEL]
      ,[DTEMISSAO]
      ,[DAC]
      ,[REPASSE]
      ,[CARTORIO]
      ,[VLR_PARCELA]
      ,[FAIXA]
      ,[FILIAL]
      ,[CD_PRODUTO]
      ,[DT_PREST_PREVIS]
      ,[DT_REAPRESENTAC]
      ,[DT_ENVIO]
      ,[DT_CHEQUE_DEVOL]
      ,[DT_ACORD_CANCEL]
      ,[VR_PAGAMENTO]
      ,[CD_ALINEA]
      ,[CD_FILIAL_ACORD]
      ,[TX_HONO_CREDIC]
      ,[VR_HONO_CREDIC]
      ,[DT_RETORN_CREDI]
      ,[IND_D_C_F]
      ,[CD_BANCO]
      ,[CD_AGENCIA]
      ,[CD_CONTA]
      ,[NR_CHEQUE]
      ,[DT_BOM_PARA]
      ,[NR_SERIE_RECIBO]
      ,[TX_DESCONTO]
      ,[TX_HONORARIO]
      ,[VR_PG_DINHEIRO]
      ,[VR_PG_OP]
      ,[NR_OP]
      ,[VR_PG_CHEQUE]
      ,[OBSERVACAO]
  FROM [LOCREDVD].[dbo].[ACORMORT]
where empresa = 16
and n_numero = 149335
and dt_exclusao = '2010-06-15'