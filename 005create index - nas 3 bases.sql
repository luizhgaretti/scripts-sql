create  nonclustered index [datatrans] on [fistef] (datatrans) on [primary]
go
create  nonclustered index [skgroiup2] on [programa] (isdotnet) include (barrapict,descricaos,parametros,programas) on [primary]
go
create  nonclustered index [nomedopes] on [scoope] (nomedopes) on [primary]
go
--alter table [sljararq] with nocheck add constraint [sljararq_cidchaves] primary key clustered (cidchaves) on [primary]
Exec sp_rename 'ararq_cidchaves', 'sljararq_cidchaves', 'OBJECT' 
go
create  nonclustered index [acrepors] on [sljcarg] (acrepors) on [primary]
go
create  nonclustered index [descpors] on [sljcarg] (descpors) on [primary]
go
create  nonclustered index [sljcli_cdidclivx] on [sljcli] (cdidclivx) on [primary]
go
create  nonclustered index [sljcli_grupovens] on [sljcli] (grupovens) on [primary]
go
create  nonclustered index [sljcopoi_skgroup1] on [sljcopoi] (drives) include (codigos,dias,dopeds,dopes,empds,emps,tpprodutos,agrupar,custos,gruconds,gruconos,novocods,pctmaxs,pctmins,processos,barras,mccrs,imagem,empdests,gdegrupos,origems,destinos,cunis,franquias,cidchaves,oricompos,delets,desitens,montaobs,chkcons,cortams,semitens,mantemmats,cheques,recalculos,mantprods,mantdpros,fiscais,pctcopias,impostos,opitens,movmzeros,movcparc,parcsemab,mantctas,ifors,mantseries,subniveis,tabauxpro,germovcc,copident,limptrans,copeqs,limputils) on [primary]
go
create  nonclustered index [mesano] on [sljcrdmr] (mesano) on [primary]
go
create  nonclustered index [moedas] on [sljcrdmr] (moedas) on [primary]
go
--alter table [sljcscof] with nocheck add constraint [sljcscof_cidchaves] primary key clustered (cidchaves) on [primary]
Exec sp_rename 'cscof_cidchaves', 'sljcscof_cidchaves', 'OBJECT' 
go
--alter table [sljcsipi] with nocheck add constraint [sljcsipi_cidchaves] primary key clustered (cidchaves) on [primary]
Exec sp_rename 'csipi_cidchaves', 'sljcsipi_cidchaves', 'OBJECT' 
go
--alter table [sljcsosn] with nocheck add constraint [sljcsosn_cidchaves] primary key clustered (cidchaves) on [primary]
Exec sp_rename 'csosn_cidchaves', 'sljcsosn_cidchaves', 'OBJECT' 
go

--alter table [sljcspis] with nocheck add constraint [sljcspis_cidchaves] primary key clustered (cidchaves) on [primary]
Exec sp_rename 'cspis_cidchaves', 'sljcspis_cidchaves', 'OBJECT' 
go
create  nonclustered index [cods] on [sljctpc] (cods) on [primary]
go
create  nonclustered index [localents] on [sljeest] (localents) on [primary]
go
create  nonclustered index [skgroup21] on [sljeest] (chksubn,utilizados,chkpagos) include (datas,dopes,empds,emps,numes,contads,npedclis,empdopnums,pstatus
) on [primary]
go
create  nonclustered index [skgroup24] on [sljeest] (chksubn,chkpagos) include (dopes,empds,emps,vends,contads,npedclis,cidchaves,empdopnums,contaes,localents,pstatus
) on [primary]
go
create  nonclustered index [sljeest_skgroup22] on [sljeest] (chksubn,dopes,utilizados,chkpagos) include (datas,empds,emps,numes,contads,npedclis,empdopnums,pstatus) on [primary]
go
create  nonclustered index [sljeest_skgroup23] on [sljeest] (dopes,datas,notas) include (empds,emps,numes,usuars,valos,contaos,contads,empdopnums) on [primary]
go
create  nonclustered index [sljeesti_ncodigos] on [sljeesti] (ncodigos) on [primary]
go
create  nonclustered index [tptrans] on [sljeestt] (tptrans) on [primary]
go
create  nonclustered index [empdopnums] on [sljemail] (empdopnums) on [primary]
go
create  nonclustered index [enviado] on [sljemail] (enviado) on [primary]
go
create  nonclustered index [operacaos] on [sljemoch] (operacaos) on [primary]
go
create  nonclustered index [sljemppr_fcdprioest_cemps] on [sljemppr] (fcdprioest, cemps) on [primary]
go
create  nonclustered index [skgroup8] on [sljest] (emps) include (cpros,grupos,estos,sqtds,cidchaves,empgruests,cmd5_1s,dpros,cunis
) on [primary]
go
create  nonclustered index [skgroup1] on [sljeti] (contas,cpros,empos,grupos,cbars,datas) on [primary]
go
create  nonclustered index [skgroup2] on [sljeti] (cbars,empos,cpros,grupos,contas) on [primary]
go
create  nonclustered index [skgroup4] on [sljeti] (cpros,cbars,empos) on [primary]
go
create  nonclustered index [skgroup5] on [sljeti] (cpros,empos,grupos,contas,cbars,qtds,pesos,localizas,codtams,codcors,datas) on [primary]
go
create  nonclustered index [sljeti_localizas] on [sljeti] (localizas) on [primary]
go
create  nonclustered index [sljfilik_cdfiltro] on [sljfilik] (cdfiltro) on [primary]
go
create  nonclustered index [sljggrpr_fcdprioest_codigos] on [sljggrpr] (fcdprioest, codigos) on [primary]
go
create  nonclustered index [sljgrupr_fcdprioest_cgrus] on [sljgrupr] (fcdprioest, cgrus) on [primary]
go
create  nonclustered index [sljgrvpr_fcdprioest_colecoes] on [sljgrvpr] (fcdprioest, colecoes) on [primary]
go
create  nonclustered index [sljlocpr_fcdprioest_codigos] on [sljlocpr] (fcdprioest, codigos) on [primary]
go
create  nonclustered index [sljmarca_kcdmarca] on [sljmarca] (kcdmarca) on [primary]
go
create  nonclustered index [sljmarct_fcdmarca] on [sljmarct] (fcdmarca) on [primary]
go
--alter table [sljnfepr2] with nocheck add constraint [sljnfepr2_cidchaves] primary key clustered (cidchaves) on [primary]
Exec sp_rename 'nfepr2_cidchaves', 'sljnfepr2_cidchaves', 'OBJECT' 
go
create  nonclustered index [sljnfis_lotes] on [sljnfis] (emps,loterps,idlote) on [primary]
go
create  nonclustered index [sljnfis_skgroup10] on [sljnfis] (emps,modelos) include (dopes,emis,cfis,dtsaidas,empdopnums) on [primary]
go
create  nonclustered index [sljnfis_skgroup12] on [sljnfis] (operas) include (nfis,emps,emis,empdopnums,modelos) on [primary]
go
--alter table [sljnfse] with nocheck add constraint [sljnfse_cidchaves] primary key clustered (cidchaves) on [primary]
Exec sp_rename 'nfse_cidchaves', 'sljnfse_cidchaves', 'OBJECT' 
go
create  nonclustered index [nomedopps] on [sljopp2] (Nomedopps) on [primary]
go
create  nonclustered index [fcdagend] on [sljosag] (fcdagend) on [primary]
go
create  nonclustered index [fcdeest] on [sljosag] (fcdeest) on [primary]
go
create  nonclustered index [skgroup7] on [sljpar] (emps,numlotechs) on [primary]
go
create  nonclustered index [cpros] on [sljpfoto] (cpros) on [primary]
go
create  nonclustered index [sljprest_kcdprioest] on [sljprest] (kcdprioest) on [primary]
go
create  nonclustered index [codscols] on [sljpro] (codscols) on [primary]
go
create  nonclustered index [codstils] on [sljpro] (codstils) on [primary]
go
create  nonclustered index [skgroup9] on [sljpro] (cpros) include (cgrus, sgrus, origmercs, compos, Dpros, Cunis, cUnips, reffs, ClFiscals, Moevs, Pvens,  Moecs, Pcuss, Moedas, Valors, Montagens, AliqIpis, Situas, Encoms, mUltComps, vUltComps, cftios, tinsts, ifors, CodFinP, linhas, colecoes, CodIdent, PesoMetal, fabrproprs, cInfAdPro1,  cInfAdPro2, tEnts, Pesoms, Mercs, MoeCusFs, CustoFs, nTpItem
) on [primary]
go
create  nonclustered index [codscols] on [sljpro2] (codscols) on [primary]
go
create  nonclustered index [codstils] on [sljpro2] (codstils) on [primary]
go
create  nonclustered index [codpais] on [sljprvci] (codpais) on [primary]
go
create  nonclustered index [skgroup1] on [sljptesp] (datainis,datafins,empdopnums) include (cpros,citens) on [primary]
go
create  nonclustered index [sljrefpr_fcdprioest_cpros] on [sljrefpr] (fcdprioest, cpros) on [primary]
go
create  nonclustered index [sljrspag_kcdrspag] on [sljrspag] (kcdrspag) on [primary]
go
create  nonclustered index [descs] on [sljscol] (descs) on [primary]
go
create  nonclustered index [sljsgrpr_fcdprioest_cgrucods] on [sljsgrpr] (fcdprioest, cgrucods) on [primary]
go
create  nonclustered index [skgroup1] on [sljsgru] (codigos, cgrus) on [primary]
go
create  nonclustered index [descs] on [sljstil] (descs) on [primary]
go
--alter table [sljtccr] with nocheck add constraint [sljtccr_cods] primary key clustered (cods) on [primary]
Exec sp_rename 'cods', 'sljtccr_cods', 'OBJECT' 
go
create  nonclustered index [adendocs] on [sljtif] (adendocs) on [primary]
go
create  nonclustered index [cptagsvc] on [sljtope] (cptagsvc) on [primary]
go
create  nonclustered index [ufdes] on [sljufd] (ufdes) on [primary]
go
create  nonclustered index [dopes] on [slvserop] (dopes) on [primary]
go
