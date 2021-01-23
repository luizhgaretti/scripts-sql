use MonitorDBA
go

/*
update Tb_MON_Cad_Clientes 
set snome = 'DL - 101' where ncodigo = 578
*/

/*
select * from MonitorDBA..Tb_MON_Cad_Clientes ORDER BY 1 DESC
where sNome like '%rimele%'

hublot

INSERT INTO MonitorDBA..Tb_MON_Cad_Clientes
VALUES('SARA PDV HUBLOT','SQL.SERVER@CAPTA.COM.BR','N','1','S')

SELEC

*/

select top 1 'backup', * from MonitorDBA..Tb_Mon_Mov_LocalDataTerminoBackup
where ncodigo = 520
order by backup_finish_date desc
go
select top 1 'espaco livre', * from MonitorDBA..Tb_MON_MovEspacoLivreHDClientes
where codcli = 520
order by dt_historico desc
go
select top 1 'tamanho bd', * from MonitorDBA..Tb_MON_Mov_TamanhoBDClientes
where nCliente = 520
order by dt_historico desc
go
select top 1 'sinal de vida', * from MonitorDBA..Tb_Mon_MovSinalVidaCliente
where codcli  = 520
order by dt_ult_sinalvida desc
go
select top 1 'versao', * from MonitorDBA..Tb_MON_MovVersaoCaptaCliente
where ncliente = 520
order by dt_informacao desc
go
select top 1 'suspect', * from MonitorDBA..Tb_Mon_Mov_BDClienteSuspect
where CODCLI = 520
order by Dt_Avisoemail desc
go


