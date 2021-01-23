alter table sljbolel alter column dtemissao datetime null

go

alter table sljcred alter column datas datetime null

go

alter table sljctrpn alter column datinis datetime null

go

alter table sljctrpn alter column datfins datetime null

go


alter table sljestpe alter column chksubn bit  not null

go

alter table sljevntg add grucads char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljflxcx alter column datainis datetime null

go

alter table sljflxcx alter column datafins datetime null

go

alter table sljggrp add qtminenvvx int default 0 not null

go

alter table sljgnre alter column dtoper datetime null

go

alter table sljitecf alter column tdatas datetime null

go

alter table sljlgnfe alter column datas datetime null

go

alter table sljmalc alter column ckclagemps bit  not null

go

alter table sljopp2 add sepptots numeric(1,0) default 0 not null

go

alter table sljpara3 add multpreco numeric(6,3) default 0 not null

go

alter table sljpara3 add carprecoop numeric(1,0) default 0 not null

go

alter table sljpara3 add altprecos numeric(1,0) default 0 not null

go

alter table sljpara3 add digcmc7s numeric(1,0) default 0 not null

go

alter table sljpara3 add cdstspsmvx char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add digusuflws numeric(1,0) default 0 not null

go

alter table sljpara3 add mailsrvs char(200) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add mailprts numeric(5,0) default 0 not null

go

alter table sljpcfcp add process bit default 0 not null

go

alter table sljpcfcp add lprecos char(30) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpcfcp add proclps bit default 0 not null

go


alter table sljpcfcx alter column valors numeric(9,4)  not null

go

alter table sljpcfpi add sqtds numeric(11,3) default 0 not null

go


alter table sljpcfpi alter column fatormo numeric(9,4)  not null

go

alter table sljperct alter column dtinis datetime null

go

alter table sljperct alter column dtfins datetime null

go

alter table sljprest add icprestesp bit default 0 not null

go

alter table sljprft2 alter column dataalts datetime null

go

alter table sljpromo alter column dtinis datetime null

go

alter table sljpromo alter column dtfims datetime null

go

alter table sljptesp alter column datainis datetime null

go

alter table sljptesp alter column datafins datetime null

go

alter table sljptesp alter column datas datetime null

go

alter table sljptesp alter column dtbaixa datetime null

go

alter table sljsacat alter column taberts datetime null

go

alter table sljtrflg alter column datas datetime null

go

alter table slvcfo2 alter column dataalts datetime null

go

alter table slvclf2 alter column dataalts datetime null

go

