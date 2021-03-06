/*
select * from Tb_MON_Cad_Clientes

select * from Tb_Mon_Mov_LocalDataTerminoBackup

insert into Tb_MON_Cad_Clientes values
(73,'Tiffany Iguatemi', 'sql.server@capta.com.br', 'N',1)

insert into Tb_MON_Cad_Clientes values
(72,'Tiffany Cidade Jardim', 'sql.server@capta.com.br', 'N',1)

insert into Tb_MON_Cad_Clientes values
(523,'Tiffany Brasília', 'sql.server@capta.com.br', 'N',1)
*/


/**********************************************************************************************************************************/




CREATE DATABASE MonitorDBA
GO

USE [MonitorDBA]
GO
/****** Object:  Table [dbo].[Tb_DBA_EspacoTotaleLivre]    Script Date: 21/06/2012 11:04:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_DBA_EspacoTotaleLivre](
	[codcli] [int] NOT NULL,
	[unidade] [varchar](1) NOT NULL,
	[dt_historico] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_DBA_EspacoTotaleLivre2]    Script Date: 21/06/2012 11:04:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_DBA_EspacoTotaleLivre2](
	[Codigo] [int] NOT NULL,
	[Cliente] [varchar](200) NOT NULL,
	[unidade] [varchar](1) NULL,
	[Tamanho Total (GB)] [numeric](12, 2) NOT NULL,
	[Espaço Livre (GB)] [numeric](12, 2) NOT NULL,
	[(%) Livre] [numeric](12, 2) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_DBA_tamanhobdclienteatual]    Script Date: 21/06/2012 11:04:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_DBA_tamanhobdclienteatual](
	[ncliente] [int] NOT NULL,
	[nomebd] [varchar](100) NOT NULL,
	[arquivo] [varchar](50) NULL,
	[caminho_fisico] [varchar](500) NULL,
	[dt_historico] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_dba_temp_sinalvida]    Script Date: 21/06/2012 11:04:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_dba_temp_sinalvida](
	[cliente] [varchar](1012) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_MON_Cad_Clientes]    Script Date: 21/06/2012 11:04:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_MON_Cad_Clientes](
	[ncodigo] [int] NOT NULL,
	[sNome] [varchar](200) NOT NULL,
	[enviar_email] [varchar](1000) NULL,
	[Flag_CliPrioritario] [char](1) NULL,
	[flgAtivo] [int] NULL,
 CONSTRAINT [PK_Tb_MON_Cad_Clientes] PRIMARY KEY CLUSTERED 
(
	[ncodigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_MON_Cad_TipoMonitor]    Script Date: 21/06/2012 11:04:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_MON_Cad_TipoMonitor](
	[nCodigo] [int] IDENTITY(1,1) NOT NULL,
	[sDescricao] [varchar](100) NOT NULL,
 CONSTRAINT [PK_Tb_MON_Cad_TipoMonitor] PRIMARY KEY CLUSTERED 
(
	[nCodigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_Mon_Mov_BDClienteSuspect]    Script Date: 21/06/2012 11:04:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_Mon_Mov_BDClienteSuspect](
	[CODCLI] [int] NULL,
	[NOMEBD] [varchar](100) NULL,
	[DB_SIZE] [varchar](100) NULL,
	[OWNER] [varchar](100) NULL,
	[DBID] [numeric](18, 0) NULL,
	[CREATED] [varchar](20) NULL,
	[STATUS] [varchar](1000) NULL,
	[compatibility_level] [int] NULL,
	[Dt_Avisoemail] [datetime] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_MON_Mov_IndicadoresMonitor]    Script Date: 21/06/2012 11:04:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tb_MON_Mov_IndicadoresMonitor](
	[nCliente] [int] NOT NULL,
	[nTipoMonitor] [int] NOT NULL,
	[dConclusao] [datetime] NOT NULL,
 CONSTRAINT [PK_Tb_MON_Mov_IndicadoresMonitor] PRIMARY KEY CLUSTERED 
(
	[nCliente] ASC,
	[nTipoMonitor] ASC,
	[dConclusao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tb_Mon_Mov_LocalDataTerminoBackup]    Script Date: 21/06/2012 11:04:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_Mon_Mov_LocalDataTerminoBackup](
	[ncodigo] [int] NOT NULL,
	[database_name] [varchar](100) NOT NULL,
	[backup_finish_date] [datetime] NOT NULL,
	[physical_device_name] [varchar](512) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_Mon_Mov_PercIndicesDados]    Script Date: 21/06/2012 11:04:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[Tb_Mon_Mov_PercIndicesDados](
	[ncliente] [int] NOT NULL,
	[dt_historico] [datetime] NOT NULL,
	[nomebd] [varchar](100) NOT NULL,
	[perc_indice] [numeric](9, 2) NULL,
	[perc_dados] [numeric](9, 2) NULL,
 CONSTRAINT [PK_Tb_Mon_Mov_PercIndicesDados] PRIMARY KEY CLUSTERED 
(
	[ncliente] ASC,
	[dt_historico] ASC,
	[nomebd] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_MON_Mov_TamanhoBDClientes]    Script Date: 21/06/2012 11:04:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_MON_Mov_TamanhoBDClientes](
	[nCliente] [int] NOT NULL,
	[dt_historico] [datetime] NOT NULL,
	[versao] [varchar](10) NOT NULL,
	[tipo] [varchar](50) NOT NULL,
	[nomebd] [varchar](100) NOT NULL,
	[tamanho_MB] [decimal](18, 4) NULL,
	[arquivo] [varchar](50) NULL,
	[caminho_fisico] [varchar](500) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_MON_MovEspacoLivreHDClientes]    Script Date: 21/06/2012 11:04:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_MON_MovEspacoLivreHDClientes](
	[codcli] [int] NOT NULL,
	[dt_historico] [datetime] NOT NULL,
	[unidade] [varchar](1) NOT NULL,
	[tamanho_total_gb] [numeric](12, 2) NULL,
	[espaco_livre_gb] [numeric](12, 2) NULL,
	[perc_livre] [numeric](12, 2) NULL,
 CONSTRAINT [PK_Tb_MON_MovEspacoLivreHDClientes] PRIMARY KEY CLUSTERED 
(
	[codcli] ASC,
	[dt_historico] ASC,
	[unidade] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tb_Mon_MovSinalVidaCliente]    Script Date: 21/06/2012 11:04:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tb_Mon_MovSinalVidaCliente](
	[codcli] [int] NOT NULL,
	[dt_ult_sinalvida] [datetime] NULL,
 CONSTRAINT [PK_Tb_Mon_MovSinalVidaCliente] PRIMARY KEY CLUSTERED 
(
	[codcli] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tb_MON_MovVersaoCaptaCliente]    Script Date: 21/06/2012 11:04:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tb_MON_MovVersaoCaptaCliente](
	[ncliente] [int] NOT NULL,
	[nome_banco] [varchar](100) NOT NULL,
	[dt_informacao] [datetime] NOT NULL,
	[cversaos] [char](70) NULL,
	[cversis] [char](14) NULL,
 CONSTRAINT [PK_Tb_MON_MovVersaoCaptaCliente] PRIMARY KEY CLUSTERED 
(
	[ncliente] ASC,
	[nome_banco] ASC,
	[dt_informacao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Tb_MON_Cad_Clientes] ADD  DEFAULT ('N') FOR [Flag_CliPrioritario]
GO
ALTER TABLE [dbo].[Tb_MON_Cad_Clientes] ADD  CONSTRAINT [DF_flgAtivo]  DEFAULT ((1)) FOR [flgAtivo]
GO
ALTER TABLE [dbo].[Tb_MON_Mov_IndicadoresMonitor] ADD  CONSTRAINT [DF_Tb_MON_Mov_IndicadoresMonitor_dConclusao]  DEFAULT (getdate()) FOR [dConclusao]
GO
ALTER TABLE [dbo].[Tb_MON_Cad_Clientes]  WITH CHECK ADD  CONSTRAINT [CK_flgAtivo] CHECK  (([flgAtivo]=(1) OR [flgAtivo]=(0)))
GO
ALTER TABLE [dbo].[Tb_MON_Cad_Clientes] CHECK CONSTRAINT [CK_flgAtivo]
GO
