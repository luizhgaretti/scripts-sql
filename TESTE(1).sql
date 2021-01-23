select 'coliseu', cpros from coliseu..sljpro
where cpros = '750'

select 'coliseu', cpros from coliseu..sljpro
where cpros = '751'

select 'coliseu2', cpros from coliseu2..sljpro
where cpros = '750'

select 'coliseu2', cpros from coliseu2..sljpro
where cpros = '751'

update coliseu..sljpro
set cpros = '751'
where cpros = '750'