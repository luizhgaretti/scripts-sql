/*********************************************************************************
								ATTACH Banco de Dados
**********************************************************************************/

CREATE DATABASE [AdventureWorks2012] ON 
( FILENAME = N'D:\Testes\DadosSQL\AdventureWorks2012_Data.mdf' ),
( FILENAME = N'D:\Testes\DadosSQL\AdventureWorks2012_log.ldf' )
 FOR ATTACH
GO