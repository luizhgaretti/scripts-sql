USE [SQLSaturdayColumnStoreIndex]
go

SELECT TOP 10 *
FROM dbo.FatoAtendimento

--Insert - Update - Delete

--Msg 35330, Level 15, State 1, Line 2
--UPDATE statement failed because data cannot be updated in a table
--with a columnstore index. Consider disabling the columnstore index before
--issuing the UPDATE statement,
--then rebuilding the columnstore index after UPDATE is complete.

go
sp_help 'FatoAtendimento'
go

SELECT COUNT(*)
FROM FatoAtendimento
--9.951.980

--Insert
BEGIN TRANSACTION

INSERT INTO dbo.FatoAtendimento (coFichaAtendimento, idPosto, coFormaAtendimento, coBaixaAtendimento, coStatusAtendimento, idCronologiaFichaAtendimento, vlReclamado, vlRecuperado, dtAlteracao)
VALUES (10101033322,78,4,1,'B',20100616,0.00,0.00, GETDATE())

SELECT TOP 1 *
FROM dbo.FatoAtendimento
ORDER BY idAtendimento DESC

SELECT *
FROM dbo.FatoAtendimento
WHERE idAtendimento = (SELECT MAX(idAtendimento) FROM dbo.FatoAtendimento)

ROLLBACK

--Delete
BEGIN TRANSACTION

DELETE
FROM dbo.FatoAtendimento
WHERE idPosto = 3

ROLLBACK

--Update
BEGIN TRANSACTION

UPDATE dbo.FatoAtendimento
	SET dtAlteracao = GETDATE()
WHERE idPosto = 3

ROLLBACK

--TupleMover
SELECT TOP 100 *
FROM FatoAtendimentoTupleMover

SELECT *
FROM sys.column_store_row_groups
WHERE object_id = OBJECT_ID('FatoAtendimentoTupleMover')

BEGIN TRANSACTION

INSERT INTO dbo.FatoAtendimentoTupleMover (coFichaAtendimento, idPosto, coFormaAtendimento, coBaixaAtendimento, coStatusAtendimento, idCronologiaFichaAtendimento, vlReclamado, vlRecuperado, dtAlteracao)
VALUES (10101033322,78,4,1,'B',20100616,0.00,0.00, GETDATE())
go 500

SELECT *
FROM sys.column_store_row_groups
WHERE object_id = OBJECT_ID('FatoAtendimentoTupleMover')

ALTER TABLE FatoAtendimentoTupleMover
    REBUILD
GO

SELECT *
FROM sys.column_store_row_groups
WHERE object_id = OBJECT_ID('FatoAtendimentoTupleMover')

ROLLBACK