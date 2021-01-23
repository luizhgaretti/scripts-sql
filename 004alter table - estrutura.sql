alter table fisimpf add desservs numeric(1,0) default 0 not null
go
alter table fisrelx add cccfs char(6) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table fisrelx add cccds char(4) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table fisrelx add cgrgs char(6) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table fisrelx add cgoncs char(4) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table fisrelx add cacrenfs char(14) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table fisrelx add cdescnfs char(14) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table fisrelx add ccancnfs char(14) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table fisrelx add credpends char(4) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table fisrelx add ccfds char(6) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table fisrelx add chrveraos char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table fisrelxt add ctpregs char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table fisrelxt add cdesctots char(50) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table fistef add datatrans datetime null
go
alter table fstparam add cversisnet char(14) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table plmpar alter column cotacao numeric(11,6)  not null
go
alter table programa add objetivos text null
go
alter table programa add estends char(40) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table scoope add nomedopes char(40) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table scotitcc alter column cotacaos numeric(11,6)  not null
go
alter table scotitoc alter column cotacaos numeric(11,6)  not null
go
alter table sljaccxa alter column cotants numeric(11,6)  not null
go
alter table sljaccxa alter column cotatus numeric(11,6)  not null
go
alter table sljagnda add cdrevproj char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljagnda add cdusucria char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljagnda add fcdrspag int default 0 not null
go
alter table sljamex add nsus char(15) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljamex add txcomis numeric(5,2) default 0 not null
go
alter table sljamex add vlcomis numeric(11,2) default 0 not null
go
alter table sljaptar add dsobstar text null
go
alter table sljbarra alter column descricaos char(100) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table sljbarra alter column barraordem numeric(10,0)  not null
go
alter table sljbarra alter column selbarras bit  not null
go
alter table sljcaped add somnecs numeric(1,0) default 0 not null
go
alter table sljcarg alter column descpors numeric(9,4)  not null
go
alter table sljcarg alter column acrepors numeric(9,4)  not null
go
alter table sljcchm alter column cotas numeric(11,6)  not null
go
alter table sljccpag add tpinibs numeric(1,0) default 0 not null
go
alter table sljccrec add tpinibs numeric(1,0) default 0 not null
go
alter table sljcdmri add lisoutros numeric(1,0) default 0 not null
go
alter table sljchm alter column cotas numeric(11,6)  not null
go
alter table sljcli alter column txjurvps numeric(9,6)  not null
go
alter table sljcli add iclmvcars numeric(1,0) default 0 not null
go
alter table sljcli add estagcls char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljcli add apelidos char(30) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljcli add cdidclivx int default 0 not null
go
alter table sljcli add dsptorefvx char(50) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljcli add emailauto numeric(1,0) default 0 not null
go
alter table sljcli add uforgems char(2) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljcli add codprovs char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go

alter table sljcli add zipcodes numeric(1,0) default 0 not null
go
alter table sljcli2 add emps char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljcliee add clieeid int default 0 not null
go
alter table sljconn alter column cods char(20) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table sljcserv add desccons char(40) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljctme add limpdttr numeric(1,0) default 0 not null
go
alter table sljctme add trftabaux numeric(1,0) default 0 not null
go
alter table sljcvepa add sittricms char(2) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljdelet add motivos text null
go
alter table sljdelp alter column cotfpgs numeric(11,6)  not null
go
alter table sljeest alter column localents int  not null
go
alter table sljeest add ctpfretes char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljeestd add nobss numeric(1,0) default 0 not null
go
alter table sljemoch alter column operacaos char(15) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table sljestis add vtotiss numeric(14,2) default 0 not null
go
alter table sljestis add virrf numeric(14,2) default 0 not null
go
alter table sljestis add vinss numeric(14,2) default 0 not null
go
alter table sljestis add vpis numeric(14,2) default 0 not null
go
alter table sljestis add vcofins numeric(14,2) default 0 not null
go
alter table sljestis add vcsll numeric(14,2) default 0 not null
go
alter table sljeti alter column cbars int  not null
go
alter table sljevent add insngrps numeric(1,0) default 0 not null
go
alter table sljevent add limbas numeric(1,0) default 0 not null
go
alter table sljevent add oculcmge numeric(1,0) default 0 not null
go
alter table sljevent add modulos numeric(1,0) default 0 not null
go
alter table sljevent add paises char(40) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljevent add npartics numeric(4,0) default 0 not null
go
alter table sljevntg add tpfatgs char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljevntg add pcomigs numeric(5,2) default 0 not null
go
alter table sljevntg add tpcalcs char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljevnto add gcadas char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljevnto add gerents char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljfclac add nqtdcomfs numeric(6,0) default 0 not null
go
alter table sljfclac add nvltotcfs numeric(10,2) default 0 not null
go
alter table sljfpagc add perccfps2 numeric(7,4) default 0 not null
go
alter table sljfpagc add nomefinp2 char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljgccr add doptevs char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljgccr add grupoevs char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljgccr add contaevs char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljgccr add blqacerts numeric(1,0) default 0 not null
go
alter table sljgdmi add codevents char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljgdmi add icms numeric(11,2) default 0 not null
go
alter table sljggrp add relgers numeric(1,0) default 0 not null
go
alter table sljgope add subntimers numeric(3,0) default 0 not null
go
alter table sljgope add procsfil numeric(1,0) default 0 not null
go
alter table sljgru add pesmetals numeric(1,0) default 0 not null
go
alter table sljgru add aplsrvs numeric(1,0) default 0 not null
go
alter table sljgru add rfmaster numeric(1,0) default 0 not null
go
alter table sljgru add tpatcus numeric(1,0) default 0 not null
go
alter table sljlcar alter column cotacaos numeric(11,6)  not null
go
alter table sljlcchm alter column cotas numeric(11,6)  not null
go
alter table sljlch alter column cotacaos numeric(13,6)  not null
go
alter table sljlchm alter column cotas numeric(11,6)  not null
go
alter table sljlpre alter column nqtdes numeric(7,0)  not null
go
alter table sljlprem alter column cotacaos numeric(11,6)  not null
go
alter table sljmala add coddtcom numeric(10,0) default 0 not null
go
alter table sljmccr alter column nlancs numeric(7,0)  not null
go
alter table sljmccrc add tplancs numeric(1,0) default 0 not null
go
alter table sljmdsc alter column limdescs numeric(9,4)  not null
go
alter table sljmltlc add ncadincon numeric(1,0) default 0 not null
go
alter table sljmltlc add ckdtvld bit default 0 not null
go
alter table sljmltlc add dtvldi datetime null
go
alter table sljmltlc add dtvldf datetime null
go
alter table sljmltlc add cestagcls char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljmltlc add ckendincon bit default 0 not null
go
alter table sljmltlc add optinativo numeric(1,0) default 0 not null
go
alter table sljmltlc add ckinativo bit default 0 not null
go
alter table sljmuope add certcrds numeric(1,0) default 0 not null
go
alter table sljmuope add nobss numeric(1,0) default 0 not null
go
alter table sljmuope add empdfs char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljnfis alter column cotacaos numeric(11,6)  not null
go
alter table sljnfis add idlote numeric(2,0) default 0 not null
go
alter table sljnfis add lotprocs numeric(1,0) default 0 not null
go
alter table sljocctb add empdopncs char(29) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljocctb add codocor char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljococl add tpocors numeric(1,0) default 0 not null
go
alter table sljoper add filtipos numeric(1,0) default 0 not null
go
alter table sljoper add grpemprs numeric(1,0) default 0 not null
go
alter table sljopp2 add impctas numeric(1,0) default 0 not null
go
alter table sljopp2 add justexcs numeric(1,0) default 0 not null
go
alter table sljopp2 add nomedopps char(40) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljpaemp add dopesatust char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljpais add isocodes char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljpar alter column cotfpgs numeric(11,6)  not null
go
alter table sljpar add nsusitefs char(6) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljparrp alter column mestoqs text null
go
alter table sljprbx alter column cotacaos numeric(11,6)  not null
go
alter table sljprbx alter column cotacaocs numeric(11,6)  not null
go
alter table sljprit alter column cotacaos numeric(11,6)  not null
go
alter table sljprit alter column cotacaocs numeric(11,6)  not null
go
alter table sljprit alter column cotorigs numeric(11,6)  not null
go
alter table sljpro add cinfadpro3 char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljpro add cinfadpro4 char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljpro add dprosits text null
go
alter table sljpro add figsit1s text null
go
alter table sljpro add figsit2s text null
go
alter table sljpro add kcdmarca int default 0 not null
go
alter table sljpro add proid int default 0 not null
go
alter table sljpro add dspalchave text null
go
alter table sljpro add codtpcs char(8) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljpro add descadpro1 text null
go
alter table sljpro add descadpro2 text null
go
alter table sljpro add codstils char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljpro add codscols char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljpro add cprobals char(14) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go

/*
alter table sljpro2 add cinfadpro3 char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go

alter table sljpro2 add cinfadpro4 char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljpro2 add dprosits text null
go
alter table sljpro2 add figsit1s text null
go
alter table sljpro2 add figsit2s text null
go
alter table sljpro2 add kcdmarca int default 0 not null
go
alter table sljpro2 add proid int default 0 not null
go
alter table sljpro2 add dspalchave text null
go
alter table sljpro2 add tabd char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljpro2 add codtpcs char(8) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljpro2 add descadpro1 text null
go
alter table sljpro2 add descadpro2 text null
go
alter table sljpro2 add codstils char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljpro2 add codscols char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljpro2 add cprobals char(14) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
*/
alter table sljproce add csatura char(20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljproce add impdata numeric(1,0) default 0 not null
go
alter table sljproce add impdataje numeric(1,0) default 0 not null
go
alter table sljproce add impdataap numeric(1,0) default 0 not null
go
alter table sljprocs add ntcompras numeric(6,0) default 0 not null
go
alter table sljprocs add cparams char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljprocs add dtcompras datetime null
go
alter table sljprocs add cclass char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljprocs add tpclass numeric(1,0) default 0 not null
go
alter table sljprocs add vencclasi datetime null
go
alter table sljprocs add vencclasf datetime null
go
alter table sljprtot alter column cotacaos numeric(11,6)  not null
go
alter table sljratcc alter column percs numeric(8,6)  not null
go
alter table sljrcpst add vlrapsimp numeric(11,2) default 0 not null
go
alter table sljreser add ictransf bit default 0 not null
go
alter table sljscli add venlojs numeric(1,0) default 0 not null
go
alter table sljspnac alter column valinis numeric(12,2)  not null
go
alter table sljspnac alter column valfins numeric(12,2)  not null
go
alter table sljsts add stsid int default 0 not null
go
alter table sljsts add envsits numeric(1,0) default 0 not null
go
alter table sljsts add ctrlaces numeric(1,0) default 0 not null
go
alter table sljtabd add retjurs numeric(1,0) default 0 not null
go
alter table sljtabd add totites numeric(1,0) default 0 not null
go
alter table sljtabdo add tabdss char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljtam add desrdzs char(5) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljtccr add autorecs numeric(1,0) default 0 not null
go
alter table sljtesp add ajuddebs char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljtesp add ajudcreds char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljtesp add lprecos char(30) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljtope alter column cptagsvc int  not null
go
alter table sljtope add congenb numeric(1,0) default 0 not null
go
alter table sljtpent add tpentid int default 0 not null
go
alter table sljtpeti add lprecos char(30) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table sljtpeti add obrigcts numeric(1,0) default 0 not null
go
alter table sljtpeti add enviareset numeric(1,0) default 0 not null
go
alter table sljtpres add icexibdisp bit default 0 not null
go
alter table sljuf add codprovs char(3) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table slvcfo alter column ctsocpis char(3) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfo alter column ctsoccofs char(3) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfo alter column ajudebs char(10) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfo alter column ajucreds char(10) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfo alter column ajucredspn char(10) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfo alter column ajudcredsp char(12) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfo alter column ajuddebs char(12) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfo alter column ajudcreds char(12) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfo alter column aliqcprevs numeric(7,4)  not null
go
alter table slvcfo2 alter column ctsocpis char(3) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfo2 alter column ctsoccofs char(3) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfo2 alter column ajudebs char(10) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfo2 alter column ajucreds char(10) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfo2 alter column ajucredspn char(10) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfo2 alter column ajudcredsp char(12) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfo2 alter column ajuddebs char(12) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfo2 alter column ajudcreds char(12) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfo2 add modelos char(2) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table slvcfo2 add tphisints numeric(3,0) default 0 not null
go
alter table slvcfo2 add icmstncred numeric(3,0) default 0 not null
go
alter table slvcfo2 add contpisds char(9) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table slvcfo2 add contpiscs char(9) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table slvcfo2 add contcofds char(9) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table slvcfo2 add contcofcs char(9) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table slvcfo2 add aliqpis numeric(5,2) default 0 not null
go
alter table slvcfo2 add aliqcofins numeric(5,2) default 0 not null
go
alter table slvcfo2 add csosns char(5) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table slvcfo2 add cfoeqinvs char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table slvcfo2 add tagipis numeric(3,0) default 0 not null
go
alter table slvcfo2 add tagiis numeric(3,0) default 0 not null
go
alter table slvcfo2 add motdesicms numeric(4,0) default 0 not null
go
alter table slvcfo2 add fsdbas char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table slvcfo2 add impimps numeric(3,0) default 0 not null
go
alter table slvcfo2 add pisimps numeric(3,0) default 0 not null
go
alter table slvcfo2 add cofimps numeric(3,0) default 0 not null
go
alter table slvcfo2 add iinfs numeric(3,0) default 0 not null
go
alter table slvcfo2 add infadfiscs text null
go
alter table slvcfo2 add pisbcicms numeric(3,0) default 0 not null
go
alter table slvcfo2 add cofbcicms numeric(3,0) default 0 not null
go
alter table slvcfo2 add codgiarss char(5) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
alter table slvcfo2 add gercat17s numeric(1,0) default 0 not null
go
alter table slvcfo2 alter column aliqcprevs numeric(7,4)  not null
go
alter table slvcfouf alter column codajdebs char(10) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfouf alter column codajcreds char(10) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfouf alter column codajdocdb char(12) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table slvcfouf alter column codajdoccr char(12) collate SQL_Latin1_General_CP1_CI_AS  not null
go
alter table usuario add dirpdfpads char(100) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
go
