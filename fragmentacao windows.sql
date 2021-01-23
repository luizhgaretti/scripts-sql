exec master.dbo.xp_cmdshell 'defrag C: -a > c:\sistemas\defragC.txt', no_output
exec master.dbo.xp_cmdshell 'defrag D: -a > c:\sistemas\defragD.txt', no_output
exec master.dbo.xp_cmdshell 'defrag E: -a > c:\sistemas\defragE.txt', no_output


declare @codcli int
set @codcli = 68
declare @msg varchar(1000)
if ISNULL( ( select ISNULL( count(1),0) from sysobjects where xtype='U' and name = 'tb_dba_analisedefrag' ),0) > 0 drop table tb_dba_analisedefrag
create table tb_dba_analisedefrag
(
linha varchar(1000)
)


BULK INSERT tb_dba_analisedefrag
   FROM 'c:\sistemas\defragC.txt';

if
ISNULL(
(
select 
isnull(COUNT(1),0)
from 
tb_dba_analisedefrag 
where 
linha like '%Voc� deve desfragmentar este volume%'
or linha like '%You should defragment this volume%'
or linha like '%Voc� deve desfragmentar este volume%'
)
,0) > 0
begin
	set @msg = ''
	select @msg = @msg + linha
	from
	tb_dba_analisedefrag 
	where 
	linha is not null
	
	insert into [200.158.216.85].monitordba.dbo.Tb_Mon_MovDefrag ( ncodigo, unidade, dt_log, msg )
	values
	(
	@codcli
	,'C'
	,GETDATE()
	,@msg
	)
end












if ISNULL( ( select ISNULL( count(1),0) from sysobjects where xtype='U' and name = 'tb_dba_analisedefrag' ),0) > 0 drop table tb_dba_analisedefrag
create table tb_dba_analisedefrag
(
linha varchar(1000)
)


BULK INSERT tb_dba_analisedefrag
   FROM 'c:\sistemas\defragD.txt';

if
ISNULL(
(
select 
isnull(COUNT(1),0)
from 
tb_dba_analisedefrag 
where 
linha like '%Voc� deve desfragmentar este volume%'
or linha like '%You should defragment this volume%'
or linha like '%Voc� deve desfragmentar este volume%'
)
,0) > 0
begin
	set @msg = ''
	select @msg = @msg + linha
	from
	tb_dba_analisedefrag 
	where 
	linha is not null
	
	insert into [200.158.216.85].monitordba.dbo.Tb_Mon_MovDefrag ( ncodigo, unidade, dt_log, msg )
	values
	(
	@codcli
	,'D'
	,GETDATE()
	,@msg
	)	
end





if ISNULL( ( select ISNULL( count(1),0) from sysobjects where xtype='U' and name = 'tb_dba_analisedefrag' ),0) > 0 drop table tb_dba_analisedefrag
create table tb_dba_analisedefrag
(
linha varchar(1000)
)


BULK INSERT tb_dba_analisedefrag
   FROM 'c:\sistemas\defragE.txt';
if
ISNULL(
(
select 
isnull(COUNT(1),0)
from 
tb_dba_analisedefrag 
where 
linha like '%Voc� deve desfragmentar este volume%'
or linha like '%You should defragment this volume%'
or linha like '%Voc� deve desfragmentar este volume%'
)
,0) > 0
begin
	set @msg = ''
	select @msg = @msg + linha
	from
	tb_dba_analisedefrag 
	where 
	linha is not null
	
	insert into [200.158.216.85].monitordba.dbo.Tb_Mon_MovDefrag ( ncodigo, unidade, dt_log, msg )
	values
	(
	@codcli
	,'E'
	,GETDATE()
	,@msg
	)		
end



GO


