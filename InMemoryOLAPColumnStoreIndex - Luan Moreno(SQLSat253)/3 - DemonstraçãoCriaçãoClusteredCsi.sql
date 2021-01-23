USE [SQLSaturdayColumnStoreIndex]
go

SELECT TOP 10 *
FROM dbo.FatoAtendimento

--NONCLUSTERED COLUMN STORE INDEX
CREATE NONCLUSTERED COLUMNSTORE INDEX idxNonClusteredCsi_FatoAtendimento
ON FatoVendasInternet
(
	[idAtendimento],
	[coFichaAtendimento],
	[idPosto],
	[coFormaAtendimento],
	[coBaixaAtendimento],
	[coStatusAtendimento],
	[idCronologiaFichaAtendimento],
	[vlReclamado],
	[vlRecuperado],
	[dtAlteracao]
)
ALTER INDEX idxNonClusteredCsi_FatoAtendimento
ON FatoAtendimento DISABLE

SELECT TOP 10 *
FROM dbo.FatoAtendimento

--CLUSTERED COLUMN STORE INDEX
CREATE CLUSTERED COLUMNSTORE INDEX idxClusteredCsi_FatoAtendimento
ON [dbo].[FatoAtendimento]

SP_HELP 'FatoAtendimento'






