--TABELAS REPLICADAS
alter table fstindc add dscellloc text null

go

alter table sljagc add nflxcaixa numeric(1,0) default 0 not null

go

alter table sljbord add grutragcob char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljbord add contragcob char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljcarg add libcancs char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljcimp add cmdfinals text null

go

alter table sljcimp add cmdviasbol text null

go


alter table sljcli add cinterdeps char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljgccr alter column agrufases char(20) collate SQL_Latin1_General_CP1_CI_AS  not null

go

alter table sljgccr add gervars numeric(1,0) default 0 not null

go

alter table sljgccr add cgrpbal char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljlchm add grupages char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljlchm add contages char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljmltlc add diasscomp numeric(3,0) default 0 not null

go

alter table sljmltlc add autos numeric(1,0) default 0 not null

go

alter table sljmrcf add piss numeric(11,2) default 0 not null

go

alter table sljmrcf add cofinss numeric(11,2) default 0 not null

go

alter table sljmuope alter column ordens numeric(3,0)  not null

go

alter table sljpara3 add nfilestres numeric(1,0) default 0 not null

go

alter table sljpara3 add mantmoeori numeric(1,0) default 0 not null

go

alter table sljpara3 add pesqbarprd numeric(1,0) default 0 not null

go

alter table sljpara3 add qbrceed numeric(1,0) default 0 not null

go

alter table sljpara3 add calcdescpd numeric(1,0) default 0 not null

go

alter table sljpara3 add comjurs numeric(1,0) default 0 not null

go

alter table sljpara3 add comdscs numeric(1,0) default 0 not null

go

alter table sljpara3 add cdarpcqten int default 0 not null

go

alter table sljpara3 add pcqtdenv numeric(5,2) default 0 not null

go

alter table sljpara3 add cdtpfilqtd int default 0 not null

go

alter table sljpara3 add intcheques numeric(1,0) default 0 not null

go

alter table sljpara3 add cdopepedlp char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljropt add ccodseg char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljropt add cinfadpro3 char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljropt add cinfadpro4 char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljufiva alter column indivast numeric(9,3)  not null

go

alter table sljufiva add ivainter numeric(9,3) default 0 not null

go

alter table sljurlws add consnf201 numeric(1,0) default 0 not null

go

