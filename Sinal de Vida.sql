

--****************************************************************************************************************************
--Sinal de Vida
--****************************************************************************************************************************
declare @codcli int
set @codcli = 526

if
isnull(
(
select 
count(1) 
from 
[200.158.216.85].monitordba.dbo.Tb_Mon_MovSinalVidaCliente
where
codcli = @codcli
)
,0)
> 0 
	update [200.158.216.85].monitordba.dbo.Tb_Mon_MovSinalVidaCliente
	set
	dt_ult_sinalvida = getdate()
	where
	codcli = @codcli




if
isnull(
(
select 
count(1) 
from 
[200.158.216.85].monitordba.dbo.Tb_Mon_MovSinalVidaCliente
where
codcli = @codcli
)
,0)
= 0 
	insert into [200.158.216.85].monitordba.dbo.Tb_Mon_MovSinalVidaCliente values ( @codcli, getdate())

--****************************************************************************************************************************
--Sinal de Vida
--****************************************************************************************************************************




