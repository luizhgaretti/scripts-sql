Banco->TiffanyBr
Tabela->FSTCUBC
Campos->Cexbdims char(1)
Campos->Ctpcorimps char(1) 


alter table FSTCUBC add Cexbdims char(1) not null default ''

alter table FSTCUBC add Ctpcorimps char(1) not null default ''