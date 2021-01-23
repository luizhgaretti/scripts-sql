/*
	Checando Tamnho do Log emv varios ou somente um campo
*/

-- Essa Procedure executa DBCC SQLPERF(LOgSPACE) na instancia para todos os bancos.
Create Procedure LogSpace
as
Begin
	DBCC SQLPERF(LOgSPACE)
End
GO

-- Essa Procedure utiliza a procedure anterior para filtra o banco que deseja retornar a informação.
Create Procedure ExibirLogSpace @Database VARCHAR(50) = null 
as
Begin
	CREATE TABLE #tFileList 
	(DatabaseName	Sysname,
	 LogSize		Decimal(18,5), 
	 LogUsed		Decimal(18,5), 
	 status			INT) 

	Insert Into #tFileList 
	Exec LogSpace

	Select * From #tfilelist 
	Where DatabaseName = @Database 
	or @Database is null
End

Execute ExibirLogSpace 'TesteMirror'