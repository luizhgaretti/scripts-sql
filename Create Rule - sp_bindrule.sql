Create rule [dbo].[chkUmDoisTresQuatro] as @col in (1,2,3,4)
GO

EXEC sp_bindrule 'chkUmDoisTresQuatro', 'PagamentoLote.inStatus'
GO