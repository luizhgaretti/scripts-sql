/*
*********************************************************
		Restauração Parcial do Banco de Dados

Restaurando somente um FileGroup.
*********************************************************
*/


-- Criando Database com dois Filegroups
CREATE DATABASE [VariosGruposDeArquivos]
ON  PRIMARY
(
	NAME = N'VariosGruposDeArquivos_Primary',
	FILENAME = N'D:\Teste1\VariosGruposDeArquivos_Primary.mdf' , SIZE = 8096KB , FILEGROWTH = 10%
 ),

FILEGROUP [FG_USER_SECUNDARIO]
 (
	NAME = N'VariosGruposDeArquivos_Secondary',
	FILENAME = N'D:\Teste2\VariosGruposDeArquivos_Secondary.ndf' , SIZE = 4096KB , FILEGROWTH = 10%
 )

LOG ON
 (
	NAME = N'VariosGruposDeArquivos_log',
	FILENAME = N'D:\Teste2\VariosGruposDeArquivos_log.ldf' , SIZE = 1024KB , FILEGROWTH = 10%
)
GO
 

-- Alterando modo de Recuperação para FULL
ALTER DATABASE [VariosGruposDeArquivos] SET RECOVERY FULL
GO


-- Criando Tabelas
use [VariosGruposDeArquivos]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
CREATE TABLE [dbo].[Cliente]
( 
	[ClienteID] [int] IDENTITY(1,1) NOT NULL,
	[ClienteCadastro] [datetime] NULL,
	CONSTRAINT [PK_Cliente] PRIMARY KEY CLUSTERED
	([ClienteID] ASC) ON [PRIMARY]
 
) ON [PRIMARY]
GO
 
CREATE TABLE [dbo].[Produto]
(
	[ProdutoID] [int] IDENTITY(1,1) NOT NULL,
	[ProdutoCadastro] [datetime] NULL,
	CONSTRAINT [PK_Produto] PRIMARY KEY CLUSTERED
	([ProdutoID] ASC) ON [FG_USER_SECUNDARIO]
 ) ON [FG_USER_SECUNDARIO]
GO



-- Inserindo Dados
use [VariosGruposDeArquivos]
GO
INSERT INTO dbo.Cliente(ClienteCadastro) VALUES (GETDATE())
INSERT INTO dbo.Produto(ProdutoCadastro) VALUES (GETDATE())
INSERT INTO dbo.Cliente(ClienteCadastro) VALUES (GETDATE())
INSERT INTO dbo.Produto(ProdutoCadastro) VALUES (GETDATE())



-- Backup FULL
Use Master
go
BACKUP DATABASE [VariosGruposDeArquivos] TO  DISK = N'D:\VariosGruposDeArquivos.bak' 
WITH NOFORMAT, 
	 INIT,
	 NAME = N'VariosGruposDeArquivos-Full Database Backup',
	 SKIP,
	 NOREWIND,
	 NOUNLOAD,
	 STATS = 10



-- Dropando o Database, para simular um desastre
Use Master
go
Drop Database VariosGruposDeArquivos



-- Restaurando somente o FileGroup PRIMARY
	-- OBS: Clausula FILE: Passa qual datafile que vai ser restaurado.
	--		Clausula PARTIAL: Informa que o restore será feito em pedaços
Use Master
GO
RESTORE DATABASE [VariosGruposDeArquivos]
FILE = N'VariosGruposDeArquivos_Primary'
FROM  DISK = N'D:\VariosGruposDeArquivos.bak'
WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10, PARTIAL
GO



-- Visualizando o Resultado
Use VariosGruposDeArquivos
GO
Select * From Produto
Select * From Cliente



-- Restaurando somente o FileGroup PRIMARY
--	OBS: Vamos deixar o outro filegrouo online, aplicaremos novamente o comando de restore. O arquivo do backup será 
--		 o mesmo, o que mudará dessa vez é o valor do parâmetro “FILE”. Agora nos iremos informar o nome do segundo datafile.
Use Master
GO
RESTORE DATABASE [VariosGruposDeArquivos]
FILE = N'VariosGruposDeArquivos_Secondary'
FROM  DISK = N'D:\VariosGruposDeArquivos.bak'
WITH  FILE = 1,  NOUNLOAD,  REPLACE,  STATS = 10
GO