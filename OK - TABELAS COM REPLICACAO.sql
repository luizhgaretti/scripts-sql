alter table fstcubi add cclffls numeric(1,0) default 0 not null

go

alter table sljcli2 add contavens char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljcopoi add copgrserv numeric(1,0) default 0 not null

go

alter table sljeesti add vladpis numeric(11,2) default 0 not null

go

alter table sljeesti add vladcfs numeric(11,2) default 0 not null

go

alter table sljeesti add vladicm numeric(11,2) default 0 not null

go

alter table sljeesti add totalnfs numeric(11,2) default 0 not null

go

alter table sljeesti add codobs numeric(3,0) default 0 not null
go
alter table sljeesti add pesosubs numeric(9,3) default 0 not null
go
alter table sljeesti add nagrupas numeric(3,0) default 0 not null
go

alter table sljestis add vrtirrf numeric(11,2) default 0 not null

go

alter table sljestis add vrtinss numeric(11,2) default 0 not null

go

alter table sljestis add vrtpis numeric(11,2) default 0 not null

go

alter table sljestis add vrtcofins numeric(11,2) default 0 not null

go

alter table sljestis add vrtcsll numeric(11,2) default 0 not null

go

alter table sljesti2 add citens2 numeric(4,0) default 0 not null
go

alter table sljeti add obsits text null

go

alter table sljgccr add agrufases char(15) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go


alter table sljgru add cngrus numeric(4,0) default 0 not null

go

alter table sljmala add clas char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go


alter table sljmccrd add vjuros numeric(11,2) default 0 not null

go

alter table sljmccrd add nopers numeric(7,0) default 0 not null

go

alter table sljmccrd add opers char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljnfis add vladpis numeric(11,2) default 0 not null

go

alter table sljnfis add vladcfs numeric(11,2) default 0 not null

go

alter table sljnfis add vladicm numeric(11,2) default 0 not null

go

alter table sljnfis add vrtirrf numeric(11,2) default 0 not null

go

alter table sljnfis add vrtinss numeric(11,2) default 0 not null

go

alter table sljnfis add vrtpis numeric(11,2) default 0 not null

go

alter table sljnfis add vrtcofins numeric(11,2) default 0 not null

go

alter table sljnfis add vrtcsll numeric(11,2) default 0 not null

go


alter table sljpaemp alter column lprecos char(30) collate SQL_Latin1_General_CP1_CI_AS  not null

go

alter table sljpara3 add marcaenvnf numeric(1,0) default 0 not null

go

alter table sljpara3 add urlwscpl char(150) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add urlftpcpl char(150) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add usuftpcpl char(30) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add senftpcpl char(30) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add depcpl char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add chavecpl char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add dopescpl char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add atrasocpl numeric(3,0) default 0 not null

go

alter table sljpara3 add cidususw1s char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add cpwususw1s char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add cidusuhw1s char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add cpwusuhw1s char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljpara3 add intsemcc numeric(1,0) default 0 not null
go

alter table sljpro alter column margems numeric(10,6)  not null

go


alter table sljpro2 alter column margems numeric(10,6)  not null

go


alter table sljtlmki add clas char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljtpeti add qtdigpro numeric(1,0) default 0 not null

go

alter table sljttri add aliqadicm numeric(4,2) default 0 not null

go

alter table sljurlws add urlrelnfs char(254) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljurlws add urlrecevt char(254) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljurlws add urldownnf char(254) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null

go

alter table sljurlws add recevtonac numeric(1,0) default 0 not null
go

alter table slvcfo add aliqadpis numeric(4,2) default 0 not null

go

alter table slvcfo add aliqadcfs numeric(4,2) default 0 not null

go

