use TestOpenTech
GO

set statistics io on
-- getdate() = CONVERT(DateTime, '20120910 16:54:14.440')

dbcc dropcleanbuffers
-- Plano bom para pegar o menor "cdevtacao"
declare @i Int
select @i = ea.cdevtacao
from eventoacao ea
where ea.dtexec > CONVERT(DateTime, '20120910 16:54:14.440') - 0.5 --getdate()-0.5 
and ea.flsituacao = 5
order by ea.cdevtacao DESC
OPTION (recompile)
GO

dbcc dropcleanbuffers
-- Plano bom para pegar o menor "cdevtacao"
declare @i Int
select @i = ea.cdevtacao
from eventoacao ea WITH (index = idxevtacao33)
where ea.dtexec > CONVERT(DateTime, '20120910 16:54:14.440') - 0.5
and ea.flsituacao = 5
order by ea.cdevtacao DESC
OPTION (recompile)
select @i
GO

dbcc dropcleanbuffers
-- Plano péssimo para pegar o menor "cdevtacao"
select MIN(ea.cdevtacao)
from eventoacao ea
where ea.dtexec > CONVERT(DateTime, '20120910 16:54:14.440') - 0.5 -- getdate()-0.5 
and ea.flsituacao = 5
OPTION (recompile)
GO

dbcc dropcleanbuffers
-- Plano péssimo para pegar o menor "cdevtacao"
select TOP 1 ea.cdevtacao
from eventoacao ea
where ea.dtexec > CONVERT(DateTime, '20120910 16:54:14.440') - 0.5 -- getdate()-0.5 
and ea.flsituacao = 5
ORDER BY ea.cdevtacao ASC
OPTION (recompile)