use monitordba
go

--insert into Tb_MON_Cad_Clientes values ('Coliseu POA', 'sql.server@capta.com.br', 'N', 1)

/*
begin tran
delete from Tb_MON_Mov_IndicadoresMonitor where nCliente = 471
rollback
commit
*/

/*
select * from Tb_MON_Cad_Clientes
where sNome like '%amé%'
or ncodigo = 49

select * from Tb_MON_Mov_IndicadoresMonitor
where nCliente = 460
order by dConclusao desc
*/

select * from Tb_Mon_Mov_LocalDataTerminoBackup
where ncodigo = 554
order by backup_finish_date desc



--insert into Tb_MON_Cad_Clientes values ('América 3.9 - SITEF', 'sql.server@capta.com.br', 'N', 1)

/*
update Tb_MON_Cad_Clientes
set flgativo = 0
where ncodigo = 185
*/