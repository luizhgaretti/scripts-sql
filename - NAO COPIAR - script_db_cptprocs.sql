--cptprocs

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[cptcusu]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[cptcusu](
	[cusuarios] [char](32) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,
 CONSTRAINT [cptcusu_cusuarios] PRIMARY KEY CLUSTERED 
(
	[cusuarios] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[cptemail]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[cptemail](
	[cidemail1s] [char](64) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,
 CONSTRAINT [cptemail_cidemail1s] PRIMARY KEY CLUSTERED 
(
	[cidemail1s] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[cpttrfem]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[cpttrfem](
	[cidchaves] [char](20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,
 CONSTRAINT [cpttrfem_cidchaves] PRIMARY KEY CLUSTERED 
(
	[cidchaves] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
-- cptemail

if exists (select 1 from tempdb.INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = '##tmpemail' )
	begin
	drop table ##tmpemail
end
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cptemail' and COLUMN_NAME = 'cname1s')
Begin 
execute ('Select a.cname1s as cidemail1s, a.cemail1s, a.ctpemail1s, a.cactive1s as cative1s INTO ##tmpemail from cptemail a')
Drop Table cptemail
END

go
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[cptemail]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[cptemail](
	[cidemail1s] [char](64)  collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,
	[cemail1s] [char](64)  collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,
	[ctpemail1s] [char](10)  collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,
	[cactive1s] [char](1)  collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,
 CONSTRAINT [cptemail_cidemail1s] PRIMARY KEY CLUSTERED 
(
	[cidemail1s] ASC
) ON [PRIMARY]
) ON [PRIMARY]

Insert into cptemail select * from ##tmpemail
END

IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[cpttrfem]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[cpttrfem](
	[cidemail1s] [char](64)  collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,
	[cidtars] [char](64)  collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,
	[cidchaves] [char](20)  collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,
 CONSTRAINT [cpttrfem_cidchaves] PRIMARY KEY CLUSTERED 
(
	[cidchaves] ASC
) ON [PRIMARY]
) ON [PRIMARY]
Create index cidtars on cpttrfem (cidtars)
Create index cidemail1s on cpttrfem (cidemail1s)

End 


go
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[cpttrf]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[cpttrf](
	[cidtars] [char](64)  collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,
 CONSTRAINT [cpttrf_cidtars] PRIMARY KEY CLUSTERED 
(
	[cidtars] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[cpttrfh]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[cpttrfh](
	[cidchaves] [char](20) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null,
 CONSTRAINT [cpttrfh_cidchaves] PRIMARY KEY CLUSTERED 
(
	[cidchaves] ASC
) ON [PRIMARY]
) ON [PRIMARY]
END
GO
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cptcusu' and COLUMN_NAME = 'csenhas')
begin
alter table cptcusu add csenhas char(32) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cptcusu' and COLUMN_NAME = 'ctpusuars')
begin
alter table cptcusu add ctpusuars char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cptemail' and COLUMN_NAME = 'cactive1s')
begin
alter table cptemail add cactive1s char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cptemail' and COLUMN_NAME = 'cemail1s')
begin
alter table cptemail add cemail1s char(64) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cptemail' and COLUMN_NAME = 'ctpemail1s')
begin
alter table cptemail add ctpemail1s char(10) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'caltercaps')
begin
alter table cpttrf add caltercaps char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'cativos')
begin
alter table cpttrf add cativos char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'ccmdpars')
begin
alter table cpttrf add ccmdpars char(64) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'ccmdruns')
begin
alter table cpttrf add ccmdruns char(64) collate SQL_Latin1_General_CP1_CI_AS default ' ' null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'cdiamesfs')
begin
alter table cpttrf add cdiamesfs char(7) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'chorafims')
begin
alter table cpttrf add chorafims char(5) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'chorainis')
begin
alter table cpttrf add chorainis char(5) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'cpendtars')
begin
alter table cpttrf add cpendtars char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'cstatus')
begin
alter table cpttrf add cstatus char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'ctpfreqs')
begin
alter table cpttrf add ctpfreqs char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'ctptars')
begin
alter table cpttrf add ctptars char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'ctrfexcls')
begin
alter table cpttrf add ctrfexcls char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'ctxtagends')
begin
alter table cpttrf add ctxtagends char(64) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'nfreqtars')
begin
alter table cpttrf add nfreqtars int default 0 not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'nhmodexecs')
begin
alter table cpttrf add nhmodexecs numeric(12,0) default 0 not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'nidprocs')
begin
alter table cpttrf add nidprocs numeric(12,0) default 0 not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'nintfreqs')
begin
alter table cpttrf add nintfreqs int default 0 not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'tdtagends')
begin
alter table cpttrf add tdtagends datetime null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'tdtageunis')
begin
alter table cpttrf add tdtageunis datetime null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'tdtexecs')
begin
alter table cpttrf add tdtexecs datetime null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'tdtfims')
begin
alter table cpttrf add tdtfims datetime null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'tdtinis')
begin
alter table cpttrf add tdtinis datetime null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrfem' and COLUMN_NAME = 'cidemail1s')
begin
alter table cpttrfem add cidemail1s char(64) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrfem' and COLUMN_NAME = 'cidtars')
begin
alter table cpttrfem add cidtars char(64) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrfh' and COLUMN_NAME = 'cidtars')
begin
alter table cpttrfh add cidtars char(64) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrfh' and COLUMN_NAME = 'cstatus')
begin
alter table cpttrfh add cstatus char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrfh' and COLUMN_NAME = 'ctpexecs')
begin
alter table cpttrfh add ctpexecs char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrfh' and COLUMN_NAME = 'ctphists')
begin
alter table cpttrfh add ctphists char(1) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrfh' and COLUMN_NAME = 'cusuexecs')
begin
alter table cpttrfh add cusuexecs char(32) collate SQL_Latin1_General_CP1_CI_AS default ' ' not null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrfh' and COLUMN_NAME = 'tdtfims')
begin
alter table cpttrfh add tdtfims datetime null
End 
go
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrfh' and COLUMN_NAME = 'tdtinis')
begin
alter table cpttrfh add tdtinis datetime null
End 
Go
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'ccmdruns')
begin
alter table cpttrf alter column ccmdruns char(128) not null
End 
Go
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cpttrf' and COLUMN_NAME = 'ccmdpars')
begin
alter table cpttrf alter column ccmdpars char(128) not null
End 
Go
IF NOT EXISTS (SELECT * FROM dbo.sysindexes WHERE id = OBJECT_ID(N'[dbo].[cpttrfem]') AND name = N'cidemail1s')
begin
CREATE NONCLUSTERED INDEX [cidemail1s] ON [dbo].[cpttrfem] 
(
	[cidemail1s] ASC
) ON [PRIMARY]
end
GO

IF NOT EXISTS (SELECT * FROM dbo.sysindexes WHERE id = OBJECT_ID(N'[dbo].[cpttrfem]') AND name = N'cidtars')
Begin 
CREATE NONCLUSTERED INDEX [cidtars] ON [dbo].[cpttrfem] 
(
	[cidtars] ASC
) ON [PRIMARY]
end
GO
IF NOT EXISTS (SELECT * FROM dbo.sysindexes WHERE id = OBJECT_ID(N'[dbo].[cpttrfh]') AND name = N'cidtars')
begin
CREATE NONCLUSTERED INDEX [cidtars] ON [dbo].[cpttrfh] 
(
	[cidtars] ASC
) ON [PRIMARY]
end
Go

IF NOT EXISTS (SELECT * FROM cptcusu WHERE cusuarios = 'Q0FQVEFQUk9D')
begin
	insert into cptcusu (cusuarios,csenhas,ctpusuars) values ('Q0FQVEFQUk9D','Q1BUQ0FQVEFQUk9D','I')
End
Go
