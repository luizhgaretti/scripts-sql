alter table sljfrete drop constraint sljfrete_cidas
go

alter table sljeest drop CONSTRAINT DF__sljeest__localen__40826CA7
go
alter table sljeest drop CONSTRAINT DF__sljeest__localen__553C954A
go
alter table sljeest drop CONSTRAINT DF__sljeest__localen__501753ED


alter table sljeti drop CONSTRAINT DF__sljeti__cbars__5ACC4E8F
go
alter table sljeti drop CONSTRAINT DF__sljeti__cbars__6F867732
go
alter table sljeti drop CONSTRAINT DF__sljeti__cbars__6A6135D5
go


alter table sljtope drop CONSTRAINT DF__sljtope__cptagsv__3CCAB145
go
alter table sljtope drop CONSTRAINT DF__sljtope__cptagsv__0253C523
go
alter table sljtope drop CONSTRAINT DF__sljtope__cptagsv__77E2EC20
go



drop statistics [sljbarra].[_wa_sys_00000008_4ca06362]
go
drop index [sljcarg].[descpors]
go
drop index [sljcarg].[acrepors]
go
alter table [sljconn] drop constraint [sljconn_cods]
go
drop index [sljeest].[localents]
go
drop index [sljemoch].[operacaos]
go
drop index [sljeti].[skgroup1]
go
drop index [sljeti].[skgroup2]
go
drop index [sljeti].[skgroup4]
go
drop index [sljeti].[skgroup5]
go
alter table [sljeti] drop constraint [sljeti_cbars]
go

drop index [sljtope].[cptagsvc]
go

