
-- Failover em Casos Normais... onde o PRINCIPAL ainda est� no AR
ALTER DATABASE ControleLicencaRGM SET PARTNER FAILOVER
GO


-- Failover em casos de Desastre... onde o PRINCIPAL n�o est� no AR
ALTER DATABASE ControleLicencaRGM SET PARTNER FORCE_SERVICE_ALLOW_DATA_LOSS
GO
ALTER DATABASE ControleLicencaRGM SET PARTNER RESUME -- RESUME � necess�rio pq o Mirror ficar� como SUSPEND
GO


-- Retorna Papel (Principal or Mirror)
SELECT db.name, m.mirroring_role_desc 
FROM sys.database_mirroring m 
JOIN sys.databases db
ON db.database_id = m.database_id
WHERE db.name = N'ControleLicencaRGM '
GO