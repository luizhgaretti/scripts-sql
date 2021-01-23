--altera tipo de campo
alter table fstcampo drop CONSTRAINT DF__fstcampo__decima__50C5FA01
goalter table fstcampo alter column decimais int  not null
go
alter table fstcampo add CONSTRAINT DF__fstcampo__decima__50C5FA01 DEFAULT 0 FOR decimais
go

--altera tipo de campo
alter table fstcampo drop CONSTRAINT DF__fstcampo__tamanh__4FD1D5C8
go
alter table fstcampo alter column tamanhos int  not null
go
alter table fstcampo add CONSTRAINT DF__fstcampo__tamanh__4FD1D5C8 DEFAULT 0 FOR tamanhos
go

/********************************************************************************************************************/

--renomeia uma primary ja existente
--concusto
Exec sp_rename 'pk_concusto', 'concusto_cods', 'OBJECT' 
go

--cptdw1
Exec sp_rename 'cptdw1_key_', 'cptdw1_ckey', 'OBJECT' 
go

--fstcampo
Exec sp_rename 'fstcampo_pkidchaves', 'fstcampo_cidchaves', 'OBJECT' 
go

--fstcubc
Exec sp_rename 'fstcubc_pkidchaves', 'fstcubc_cidchaves', 'OBJECT' 
go

--fstcubi
Exec sp_rename 'fstcubi_pkidchaves', 'fstcubi_cidchaves', 'OBJECT' 
go

/********************************************************************************************************************/--add primary keyalter table [fstindc] with nocheck add constraint [fstindc_indinds] primary key clustered (cidinds) on [primary]go

