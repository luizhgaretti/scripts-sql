create table sljcalcl (emps char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,grupos char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,estos char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,localizas char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cpros char(14) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,datas datetime null,usuars char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,qtds numeric(11,3) default 0 not null)
go
create table sljcrdmr (moedas char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cotacaos numeric(14,7) default 0 not null,mesano char(7) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,usuars char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljctpc (cgrus char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,descs char(50) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,seqs numeric(5,0) default 0 not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cods char(8) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljemail (empdopnums char(29) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,iclis char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,enviado numeric(1,0) default 0 not null,dataenv datetime null,datas datetime null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,logerr text null)
go
create table sljemppr (cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,fcdprioest int default 0 not null,cemps char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljestag (cods char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,descs char(30) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljfilik (cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cdfiltro char(24) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljggrpr (cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,fcdprioest int default 0 not null,codigos char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljgrupr (cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,fcdprioest int default 0 not null,cgrus char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljgrvpr (cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,fcdprioest int default 0 not null,colecoes char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljlocpr (cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,fcdprioest int default 0 not null,codigos char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljmarca (cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,kcdmarca int default 0 not null,nmmarca char(30) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,dsmarca text null,dspalchave char(150) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,icativo bit default 0 not null)
go
create table sljmarct (cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,fcdmarca int default 0 not null)
go
create table sljpara3 (cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,ntoltit2 numeric(4,0) default 0 not null,ntoltit3 numeric(4,0) default 0 not null,csitua2 char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,csitua3 char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,nmesclf numeric(3,0) default 0 not null,nddclisc numeric(4,0) default 0 not null,csitclisc char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,memps numeric(1,0) default 0 not null,estagcls char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cinfadpro3 char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cinfadpro4 char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,critclas numeric(1,0) default 0 not null,cdempvx char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cdopepedvx char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cdoperprvx char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cdopecrevx char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cdopestrvx char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cdopepdevx char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,qtminestvx int default 0 not null,cdgrprsvx char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,vlmaxprovx numeric(8,2) default 0 not null,vlminprovx numeric(8,2) default 0 not null,cdopenfpvx char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cdtabdvx char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cdmotdvx char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,dsurlftpvx char(150) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,nmusuftpvx char(100) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cdsenftpvx char(50) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cdlocpdvx char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,dsurlprxvx char(150) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cdprtprxvx int default 0 not null,nmusuprxvx char(100) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cdsenprxvx char(50) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,nmdomprxvx char(50) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,nmusuwsvx char(30) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cdsenwsvx char(30) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,precocongb numeric(1,0) default 0 not null,congvfp numeric(1,0) default 0 not null,fothispro numeric(1,0) default 0 not null,icenvim1vx bit default 0 not null,icenvim2vx bit default 0 not null,icenvim3vx bit default 0 not null,cversisnet char(14) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,csitua4 char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,tpgerclas numeric(1,0) default 0 not null,grnsustfs numeric(1,0) default 0 not null,prodescad1 char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,prodescad2 char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cmc7obrig numeric(1,0) default 0 not null,chkcads numeric(1,0) default 0 not null,trabtpops numeric(1,0) default 0 not null,empmins char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,tpcdevts numeric(1,0) default 0 not null,fecests numeric(1,0) default 0 not null,ddcarants numeric(3,0) default 0 not null,pmultas numeric(5,2) default 0 not null,ddcaratrs numeric(3,0) default 0 not null,chkacemp numeric(1,0) default 0 not null,vrfnopers numeric(1,0) default 0 not null,dopinunf char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null, flxdcprs numeric(1,0) default 0 not null)
go
create table sljpedcc (marcas numeric(1,0) default 0 null,codigos char(2) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,descrs char(50) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,conteudoss text not null,conteudosi text null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljpfoto (cpros char(14) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cods char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,figprocs text null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljprest (cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,kcdprioest int default 0 not null,nmprioest char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cdnumprior int default 0 not null,fcdgruest char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,fcdconest char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljprvci (codpais char(5) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,codprovs char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,desprovs char(40) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljptesp (datainis datetime not null,datafins datetime not null,empdopnums char(29) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cpros char(14) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,citens numeric(10,0) default 0 not null,vlcred numeric(11,2) default 0 not null,vlestorno numeric(11,2) default 0 not null,vlicms numeric(11,2) default 0 not null,chksubn bit default 0 not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,datas datetime not null,dtbaixa datetime not null)
go
create table sljrefpr (cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,fcdprioest int default 0 not null,cpros char(14) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljrspag (cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,kcdrspag int default 0 not null,nmresponsa char(50) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,nmatividad char(15) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,nmcargo char(15) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,nmemail char(50) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,nmtelefone char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljscol (codigos char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,descs char(40) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljsgrpr (cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,fcdprioest int default 0 not null,cgrucods char(9) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljstil (codigos char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,descs char(40) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljtpfot (cods char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,descs char(40) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table sljufd (ufdes char(2) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,codstats char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go
create table slvserop (dopes char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,series char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,modelos char(2) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,cidchaves char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null)
go


alter table sljcalcl add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljcrdmr add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljctpc add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljemail add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljemppr add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljestag add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljfilik add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljggrpr add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljgrupr add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljgrvpr add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljlocpr add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljmarca add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljmarct add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljpara3 add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljpedcc add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljpfoto add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljprest add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljprvci add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljptesp add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljrefpr add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljrspag add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljscol add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljsgrpr add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljstil add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljtpfot add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table sljufd add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go
alter table slvserop add [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL default newsequentialid()
go




