declare @cl_ddd smallint
, @cl_fon char (8)

set @cl_ddd = 15
set @cl_fon =  '91068475'

select c_emp,c_dos, cl_ddd, cl_fon from cadcontr
where cl_ddd = @cl_ddd
and cl_fon = @cl_fon

----------------------------------------------------

declare @lt_ddd smallint
, @lt_fon char (8)

set @lt_ddd = 15
set @lt_fon = '91068475'

select c_emp,c_dos, lt_ddd, lt_fon from cadcontr
where lt_ddd = @lt_ddd
and lt_fon = @lt_fon

-------------------------------------------------------
declare @dddrec1 smallint
, @fonrec1 char (8)

set @dddrec1 = 11
set @fonrec1 =  2024-2291

select c_emp,c_dos, dddrec1, fonrec1 from cadcontr
where dddrec1 = @dddrec1
and fonrec1 = @fonrec1

---------------------------------------------------------
declare @dddrec2 smallint
, @fonrec2 char (8)

set @dddrec2 = 11
set @fonrec2 =  2024-2291

select c_emp,c_dos, dddrec2, fonrec2 from cadcontr
where dddrec2 = @dddrec2
and fonrec2 = @fonrec2

----------------------------------------------------------

declare @nr_ddd smallint
, @nr_telefone char (8)

set @nr_ddd = 11
set @nr_telefone = '20242291'

select nr_cpf_cnpj,nr_ddd, nr_telefone from tblocali
where nr_ddd = @nr_ddd
and nr_telefone = @nr_telefone
