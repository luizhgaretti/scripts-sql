--TABELAS NAO REPLICADAS
alter table sljfpag add chkcontas numeric(1,0) default 0 not null

go

alter table sljemp2 add ladoimpjc numeric(1,0) default 0 not null

go

alter table sljempc2 alter column dataalts datetime null

go

alter table sljancon alter column datainis datetime null

go

alter table sljancon alter column datafims datetime null

go

alter table sljope4 add blqrcnpjs numeric(1,0) default 0 not null

go

alter table sljope4 add dckimpflws numeric(1,0) default 0 not null

go

alter table sljope4 add numflwdocs numeric(1,0) default 0 not null

go