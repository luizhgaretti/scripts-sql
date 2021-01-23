use ca_erp_imagem
go
begin tran
go
begin tran
go
insert into sljtwscn (cidchaves,docs,descs,imgs,empdopnums,empdopncs,datas,zipped) select a.cidchaves,a.docs,a.descs,a.imgs,a.empdopnums,a.empdopncs,a.datas,a.zipped from ca_erp.dbo.sljtwscn a
go
commit tran
go
commit tran
