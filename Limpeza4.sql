-Atualizar Instalador da Capta.
-Verificar e se necessario atualizar dll bematech
-Atualizar o sistema para o "prod2009"

-Checar se os Recebimntos e Transportes estão OK.

-Alterar o Recebimento (transporte por tipo)
Matriz (T - Copia) \ Lojas (R - Atualiza)
> 7 - GGRP
> 8 - GCCR
> 9 - SGRU
> 0 - SLJVCLF
> Z - CLAS 

---

sp_help slj

---

select empdopnums,* from sljeesti where empdopnums in (select empdopnums from sljeest where emps = '502' and datas < '?')
select empdopnums,* from sljesti2 where empdopnums in (select empdopnums from sljeest where emps = '502' and datas < '?')
select empdopnums,* from sljbxest where empdopnums in (select empdopnums from sljeest where emps = '502' and datas < '?')
select empdopnums,* from sljestpe where empdopnums in (select empdopnums from sljeest where emps = '502' and datas < '?')
select empdopnums,* from sljpar where empdopnums in (select empdopnums from sljeest where emps = '502' and datas < '?')
select empdopnums,* from sljmccr where empdopnums in (select empdopnums from sljeest where emps = '502' and datas < '?')
select empdopnums,* from sljhis where empdopnums in (select empdopnums from sljeest where emps = '502' and datas < '?')
select empdopnums from sljeest where emps = '502' and datas < '?'
begin tran
delete from sljeesti where empdopnums in (select empdopnums from sljeest where emps = '502' and datas < '?')
delete from sljesti2 where empdopnums in (select empdopnums from sljeest where emps = '502' and datas < '?')
delete from sljbxest where empdopnums in (select empdopnums from sljeest where emps = '502' and datas < '?')
delete from sljestpe where empdopnums in (select empdopnums from sljeest where emps = '502' and datas < '?')
delete from sljpar where empdopnums in (select empdopnums from sljeest where emps = '502' and datas < '?')
delete from sljmccr where empdopnums in (select empdopnums from sljeest where emps = '502' and datas < '?')
delete from sljhis where empdopnums in (select empdopnums from sljeest where emps = '502' and datas < '?')
delete from sljeest where emps = '502' and datas < '?'
commit

---

select empdopnums,* from sljeesti where empdopnums in (select empdopnums from sljeest where dopes not in ('venda nacional','venda internacional') and datas < '?')
select empdopnums,* from sljesti2 where empdopnums in (select empdopnums from sljeest where dopes not in ('venda nacional','venda internacional') and datas < '?')
select empdopnums,* from sljbxest where empdopnums in (select empdopnums from sljeest where dopes not in ('venda nacional','venda internacional') and datas < '?')
select empdopnums,* from sljestpe where empdopnums in (select empdopnums from sljeest where dopes not in ('venda nacional','venda internacional') and datas < '?')
select empdopnums,* from sljpar where empdopnums in (select empdopnums from sljeest where dopes not in ('venda nacional','venda internacional') and datas < '?')
select empdopnums,* from sljmccr where empdopnums in (select empdopnums from sljeest where dopes not in ('venda nacional','venda internacional') and datas < '?')
select empdopnums,* from sljhis where empdopnums in (select empdopnums from sljeest where dopes not in ('venda nacional','venda internacional') and datas < '?')
select empdopnums,* from sljeest where dopes not in ('venda nacional','venda internacional') and datas < '?'

begin tran
delete from sljeesti where empdopnums in (select empdopnums from sljeest where dopes not in ('venda nacional','venda internacional') and datas < '?')
delete from sljesti2 where empdopnums in (select empdopnums from sljeest where dopes not in ('venda nacional','venda internacional') and datas < '?')
delete from sljbxest where empdopnums in (select empdopnums from sljeest where dopes not in ('venda nacional','venda internacional') and datas < '?')
delete from sljestpe where empdopnums in (select empdopnums from sljeest where dopes not in ('venda nacional','venda internacional') and datas < '?')
delete from sljpar where empdopnums in (select empdopnums from sljeest where dopes not in ('venda nacional','venda internacional') and datas < '?')
delete from sljmccr where empdopnums in (select empdopnums from sljeest where dopes not in ('venda nacional','venda internacional') and datas < '?')
delete from sljhis where empdopnums in (select empdopnums from sljeest where dopes not in ('venda nacional','venda internacional') and datas < '?')
delete from sljeest where dopes not in ('venda nacional','venda internacional') and datas < '?'
commit

---

select * from sljproce where emps <> '!'
select * from sljapprp where emps <> '!'
select * from sljappra where emps <> '!'

begin tran
delete from sljproce where emps <> '!'
delete from sljapprp where emps <> '!'
delete from sljappra where emps <> '!'
commit

---

select * from fisrelx where emps <> '!'
select * from fisrelxt where emps <> '!'

begin tran
delete from fisrelx where emps <> '!'
delete from fisrelxt where emps <> '!'
commit

---

select * from sljmrcf where emps <> '!'
select * from sljmri where emps <> '!'

begin tran
delete from sljmrcf where emps <> '!'
delete from sljmri where emps <> '!'
commit

---

select cpros,* from sljpro where sgrus = 'solita' and cgrus = 'E'
select cpros,* from sljpro where sgrus = 'cord' and cgrus = 'A'

select * from sljpro where cpros in ('A01712','E00560')
select * from sljcompo where cpros in ('A01712','E00560')

begin tran 
delete from sljpro where cpros in ('A01712','E00560')
delete from sljcompo where cpros in ('A01712','E00560')
commit

---

select Distinct mercs from sljgru where mercs not in (select codigos from sljggrp) and mercs <> 'COA'

select * from sljgru where mercs = 'POA'
select * from sljgru where mercs = 'SER'

begin tran
delete from sljgru where mercs = 'POA'
delete from sljgru where mercs = 'SER'
commit

---

select dpros,descfis,* from sljpro where dpros = ''
select dpros,substring(descfis,1,40),* from sljpro where dpros = ''

begin tran
update sljpro set dpros = substring(descfis,1,40) where dpros = ''
commit

---

select * from sljuf where estados = 'SP'

begin tran
update sljuf set aicms = '18.00' where estados = 'SP'
commit

---

select mercs,cgrus,* from sljpro where cgrus = 'MPE' and mercs <> 'MPE'

begin tran
update sljpro set mercs = 'MPE' where cgrus = 'MPE' and mercs <> 'MPE'
commit

---

select * from sljpar where dopes not in ('venda nacional','venda internacional')

begin tran
delete from sljpar where dopes not in ('venda nacional','venda internacional')
commit

---

select * from sljcalcc
select * from sljcalcp
select * from sljest

begin tran
delete from sljcalcc
delete from sljcalcp
delete from sljest
commit

---

-Gerar transporte na Matriz e Receber na loja
-Iniciar > Executar - c:\sistemas\prod2008.exe 1p

-Rodar analise de consistencia. 

