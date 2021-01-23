select * from [dbo].[Tb_MON_Cad_Clientes]
where ncodigo = 408

select * from Tb_DBA_EspacoTotaleLivre where codcli=501
select * from Tb_DBA_EspacoTotaleLivre where codcli=408

select * from Tb_DBA_EspacoTotaleLivre2 where codigo=501
select * from Tb_DBA_EspacoTotaleLivre2 where codigo=408

select * from Tb_DBA_tamanhobdclienteatual where ncliente=501
select * from Tb_DBA_tamanhobdclienteatual where ncliente=408

select * from Tb_Mon_Mov_LocalDataTerminoBackup where  ncodigo=501 order by backup_finish_date desc
select * from Tb_Mon_Mov_LocalDataTerminoBackup where  ncodigo=408 order by backup_finish_date desc

select * from Tb_Mon_Mov_PercIndicesDados where ncliente=501
select * from Tb_Mon_Mov_PercIndicesDados where ncliente=408

select * from Tb_MON_Mov_TamanhoBDClientes where ncliente=501 order by dt_historico desc
select * from Tb_MON_Mov_TamanhoBDClientes where ncliente=408 order by dt_historico desc

select * from Tb_MON_MovEspacoLivreHDClientes where codcli=501 order by dt_historico desc