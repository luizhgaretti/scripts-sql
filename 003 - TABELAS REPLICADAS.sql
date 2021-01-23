--TABELAS REPLICADAS
alter table sljbal add ajustes bit default 0 not null

go

alter table sljeti add empfs char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljggrp add codlojas char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljggrp add dopesgera char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljgru add tpfors numeric(1,0) default 0 not null

go

alter table sljmccr add npedclis numeric(11,0) default 0 not null

go


alter table sljpara3 add tabdscploc char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add empgrverp char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add lprecosenv char(30) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add dopaje char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add dopajs char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add dopajlce char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add dopajlcs char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add cdgruvenvx char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add cdconvenvx char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpmccr add npedclis numeric(11,0) default 0 not null

go

alter table sljtabd add envsites numeric(1,0) default 0 not null

go

alter table slvcfo add retipis numeric(1,0) default 0 not null

go


