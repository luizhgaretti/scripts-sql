use TIFFANYBR
go

/*
SELECT COUNT(*) FROM SLJCFGNF
SELECT COUNT(*) FROM TIFFANYBR_DIFF..SLJCFGNF
*/

IF EXISTS (SELECT NAME FROM tiffanybr.SYS.sysobjects WHERE NAME = 'TR_UPDATE_INSERT')

DROP TRIGGER TR_UPDATE_INSERT
GO

CREATE TRIGGER TR_UPDATE_INSERT
on SLJCFGNF 
for update, insert
as
--SELECT * into TB_INSERTED FROM INSERTED
--SELECT * into TB_DELETED FROM DELETED

delete from TIFFANYBR_DIFF..SLJCFGNF
where CIDCHAVES in (select CIDCHAVES from INSERTED)

insert into TIFFANYBR_DIFF..SLJCFGNF
select * from INSERTED
where cidchaves not in (select cidchaves from TIFFANYBR_DIFF..SLJCFGNF)

/*
insert into TIFFANYBR_DIFF..SLJCFGNF
select * from SLJCFGNF
where CIDCHAVES not in (select CIDCHAVES from TIFFANYBR_DIFF..SLJCFGNF)
*/

--DROP TABLE TB_INSERTED
--DROP TABLE TB_DELETED
/*FIM DA TRIGGER*/



update SLJCFGNF
set ltqtde = '4'
where CIDCHAVES = 'CIDCHAVES'

insert into SLJCFGNF values (2,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	'A',	1,	'A',	'A',	'A',	'A',	'A',	'A',	'A',	'A',	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	'A',	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	'A',	'A',	'A',	1,	'A',	'A',	'A', 'CIDCHAVES',	'A',	'A',	1)

select * from SLJCFGNF
WHERE cidchaves = 'CIDCHAVES'

select * from TIFFANYBR_DIFF..SLJCFGNF
WHERE cidchaves = 'CIDCHAVES'

--drop table TB_INSERTED
--select * from TB_INSERTED --DADOS_ATUAIS
--select * from TB_DELETED --'DADOS_ANTIGOS'

