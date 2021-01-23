 

SELECT TOP 1000 [nCliente]

      ,[dt_historico]

      ,[versao]

      ,[tipo]

      ,[nomebd]

      ,[tamanho_MB]

      ,[arquivo]

      ,[caminho_fisico]

  FROM [MonitorDBA].[dbo].[Tb_MON_Mov_TamanhoBDClientes]

  where nomebd='dl_cpt2009' and arquivo='DL_CPT2009_Data'

  order by dt_historico desc

