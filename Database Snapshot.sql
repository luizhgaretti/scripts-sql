CREATE DATABASE AdventureWorks_dbss1800 ON
( NAME = AdventureWorks_Data, FILENAME = 
'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\Data\AdventureWorks_data_1800.ss' )
AS SNAPSHOT OF AdventureWorks;
G



-------------- snapshot da Base iss_Osasco
Use MASTER
GO

CREATE DATABASE iss_osasco_snapshot ON
(NAME = iss_osasco,
	FILENAME = 'Y:\SnapshotOsasco\iss_osasco.ss'),
(NAME = iss_osasco_imagem,
	FILENAME = 'Y:\SnapshotOsasco\iss_osasco_imagem.ss'),
(NAME = iss_osasco_index,
	FILENAME = 'Y:\SnapshotOsasco\iss_osasco_index.ss'),
(NAME = iss_osasco_imagem01, 
	FILENAME = 'Y:\SnapshotOsasco\iss_osasco_imagem01.ss'),
(NAME = iss_osasco_imagem02,
	FILENAME = 'Y:\SnapshotOsasco\iss_osasco_imagem02.ss'),
(NAME = iss_osasco_imagem03,
	FILENAME = 'Y:\SnapshotOsasco\iss_osasco_imagem03.ss'),
(NAME = iss_osasco_imagem04,
	FILENAME = 'Y:\SnapshotOsasco\iss_osasco_imagem04.ss'),
(NAME = iss_osasco02,
	FILENAME = 'Y:\SnapshotOsasco\iss_osasco02.ss'),
(NAME = iss_osasco_imagem05,
	FILENAME = 'Y:\SnapshotOsasco\iss_osasco_imagem05.ss'),
(NAME = iss_osasco_index01,
	FILENAME = 'Y:\SnapshotOsasco\iss_osasco_index01.ss'),
(NAME = iss_osasco03,
	FILENAME = 'Y:\SnapshotOsasco\iss_osasco03.ss')
AS SNAPSHOT OF iss_Osasco
GO


--- Restrições
	-- Snapshot é somente leitura'
	-- Se a base estiver participando do espelhamento... a base deve estar como sincronizada