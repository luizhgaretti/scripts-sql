CREATE TABLE [dbo].[SEGMENTOATIVIDADE](
	[cdSegmentoAtividade] [int] NOT NULL,
	[dcSegmentoAtividade] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[inConfiguracao] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkSEGMENTOATIVIDADE] PRIMARY KEY CLUSTERED 
(
	[cdSegmentoAtividade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

/****** Object:  Table [dbo].[TIPOINCONSISTENCIA]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TIPOINCONSISTENCIA](
	[cdTipoInconsistencia] [smallint] NOT NULL,
	[dcTipoInconsistencia] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrDias] [smallint] NOT NULL,
 CONSTRAINT [pkTIPOINCONSISTENCIA] PRIMARY KEY CLUSTERED 
(
	[cdTipoInconsistencia] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TIPOGUIA]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TIPOGUIA](
	[cdTipoGuia] [smallint] NOT NULL,
	[dcTipoGuia] [varchar](50) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcNomeAmigavel] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkTIPOGUIA] PRIMARY KEY CLUSTERED 
(
	[cdTipoGuia] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SERVIDOREMAIL]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SERVIDOREMAIL](
	[cdServidorEmail] [int] IDENTITY(1,1) NOT NULL,
	[nrMetodoEnvio] [tinyint] NOT NULL,
	[dcUsuario] [varchar](25) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcSenha] [varchar](15) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcHost] [varchar](25) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrPorta] [int] NULL,
 CONSTRAINT [pkSERVIDOREMAIL] PRIMARY KEY CLUSTERED 
(
	[cdServidorEmail] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[USUARIOINTEGRACAO]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[USUARIOINTEGRACAO](
	[cdUsuarioIntegracao] [int] IDENTITY(1,1) NOT NULL,
	[cdSistemaIntegracao] [smallint] NOT NULL,
	[dcUsuario] [varchar](20) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcSenha] [varchar](50) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkUSUARIOINTEGRACAO] PRIMARY KEY CLUSTERED 
(
	[cdUsuarioIntegracao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TABELAAUDITORIA]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TABELAAUDITORIA](
	[cdTabelaAuditoria] [smallint] NOT NULL,
	[dcTabelaAuditoria] [varchar](50) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkTABELAAUDITORIA] PRIMARY KEY CLUSTERED 
(
	[cdTabelaAuditoria] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RPSMENSAGEMINCONSISTENCIA]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RPSMENSAGEMINCONSISTENCIA](
	[cdRPSMensagemInconsistencia] [int] NOT NULL,
	[dcMensagem] [varchar](1000) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcMensagemSolucao] [varchar](1000) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkRPSMENSAGEMINCONSISTENCIA] PRIMARY KEY CLUSTERED 
(
	[cdRPSMensagemInconsistencia] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DIVIDAATIVANAOENCONTRADO]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DIVIDAATIVANAOENCONTRADO](
	[cdDividaAtivaNaoEncontrado] [int] IDENTITY(1,1) NOT NULL,
	[nrExercicio] [smallint] NOT NULL,
	[nrParcela] [smallint] NOT NULL,
	[nrInscricaoMunicipal] [varchar](10) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkDIVIDAATIVANAOENCONTRADO] PRIMARY KEY CLUSTERED 
(
	[cdDividaAtivaNaoEncontrado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DIVIDAATIVA]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DIVIDAATIVA](
	[cdDividaAtiva] [int] IDENTITY(1,1) NOT NULL,
	[nrInscricaoMunicipal] [varchar](10) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrExercicio] [smallint] NOT NULL,
	[nrParcela] [smallint] NOT NULL,
	[dtVencimento] [datetime] NOT NULL,
	[vlEstimado] [numeric](15, 2) NOT NULL,
	[vlIssDevido] [numeric](15, 2) NOT NULL,
	[nrAtividade] [varchar](5) COLLATE Latin1_General_CI_AI NOT NULL,
	[inStatus] [char](1) COLLATE Latin1_General_CI_AI NULL,
	[dtInscricao] [datetime] NULL,
	[dcMotivoNaoInscricao] [varchar](200) COLLATE Latin1_General_CI_AI NULL,
	[dcTipoGuia] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[dcItenAtividade] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[qtItenAtividade] [smallint] NULL,
 CONSTRAINT [pkDIVIDAATIVA] PRIMARY KEY CLUSTERED 
(
	[cdDividaAtiva] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixDividaAtiva01] ON [dbo].[DIVIDAATIVA] 
(
	[nrInscricaoMunicipal] ASC,
	[nrExercicio] ASC
)
INCLUDE ( [nrParcela],
[nrAtividade],
[inStatus],
[dcTipoGuia]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 70) ON [INDEXES]
GO
/****** Object:  Table [dbo].[DOCUMENTOHISTSEMST]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DOCUMENTOHISTSEMST](
	[cdDocumento] [int] NOT NULL,
	[nrDocumento] [numeric](19, 0) NOT NULL,
	[vlIss] [decimal](18, 2) NOT NULL,
	[vlReceita] [decimal](18, 2) NOT NULL,
	[nrMes] [smallint] NOT NULL,
	[dtEmissao] [datetime] NOT NULL,
	[vlAliquota] [decimal](18, 2) NOT NULL,
	[nrExercicio] [smallint] NOT NULL,
	[inGeracaoPagamento] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inSubstituicaoTributaria] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdAtividade] [int] NULL,
	[cdItemAtividade] [int] NULL,
	[cdPessoaPrestador] [int] NULL,
	[nrTipoDeclaracao] [smallint] NOT NULL,
	[cdPessoaTomador] [int] NULL,
	[cdSerieNotaFiscal] [int] NULL,
	[dcSerieNotaFiscal] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[cdTipoDocumento] [int] NOT NULL,
	[inTeste] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[dtDeclaracao] [datetime] NULL,
	[cdImportacaoLancamentoItens] [int] NULL,
	[tpInconsistencia] [smallint] NOT NULL,
	[inSituacaoInconsistencia] [char](1) COLLATE Latin1_General_CI_AI NULL,
	[inStatus] [int] NOT NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CONFIGURACAOSISTEMA]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CONFIGURACAOSISTEMA](
	[cdConfiguracaoSistema] [int] NOT NULL,
	[inRpsBloqueado] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inSistemaBloqueado] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkCONFIGURACAOSISTEMA] PRIMARY KEY CLUSTERED 
(
	[cdConfiguracaoSistema] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CODIGOCOSIF]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CODIGOCOSIF](
	[dcCodigoCosif] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrCodigoCosif] [varchar](16) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdCodigoCosif] [int] NOT NULL,
 CONSTRAINT [pkCODIGOCOSIF] PRIMARY KEY CLUSTERED 
(
	[cdCodigoCosif] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[AGENDADORTAREFA]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AGENDADORTAREFA](
	[cdAgendadorTarefa] [int] IDENTITY(1,1) NOT NULL,
	[dcNome] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcAssemblyProcesso] [varchar](200) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrIntervaloMinutos] [smallint] NOT NULL,
	[nrStatus] [tinyint] NOT NULL,
	[dtInclusao] [smalldatetime] NOT NULL,
	[dtUltimaExecucao] [smalldatetime] NULL,
 CONSTRAINT [pkAGENDADORTAREFA] PRIMARY KEY CLUSTERED 
(
	[cdAgendadorTarefa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CDCIPTU]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CDCIPTU](
	[CDCDCIPTU] [int] IDENTITY(1,1) NOT NULL,
	[DCCODIGOCDC] [varchar](12) COLLATE Latin1_General_CI_AI NOT NULL,
	[NREXERCICIO] [smallint] NOT NULL,
	[DCENDERECO] [varchar](250) COLLATE Latin1_General_CI_AI NOT NULL,
	[DCSITUACAO] [varchar](10) COLLATE Latin1_General_CI_AI NOT NULL,
	[VLIPTUATUAL] [numeric](15, 2) NOT NULL,
	[VLTOTALCREDITOS] [numeric](15, 2) NULL,
	[INDESCAPLICADO] [char](1) COLLATE Latin1_General_CI_AI NULL,
	[DCOBSERVACAO] [varchar](500) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkCDCIPTU] PRIMARY KEY CLUSTERED 
(
	[CDCDCIPTU] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixCDCIPTU01] ON [dbo].[CDCIPTU] 
(
	[DCCODIGOCDC] ASC,
	[NREXERCICIO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[CONFIGURACAOCREDITOIPTU]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CONFIGURACAOCREDITOIPTU](
	[cdConfiguracaoCreditoIptu] [int] IDENTITY(1,1) NOT NULL,
	[inAtivaFuncaoCredito] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrDescontoPessoaFisica] [numeric](4, 2) NOT NULL,
	[nrDescontoPessoaJuridica] [numeric](4, 2) NOT NULL,
	[nrMesInicialIndicacaoImovel] [smallint] NOT NULL,
	[nrMesFinalIndicacaoImovel] [smallint] NOT NULL,
	[dtPublicacaoDecreto] [datetime] NOT NULL,
	[nrDescontoCondominios] [numeric](4, 2) NOT NULL,
	[nrDescontoResponsavelIss] [numeric](4, 2) NOT NULL,
	[vlMaximoTransferenciaCredito] [decimal](18, 2) NOT NULL,
	[inTomadorPublico] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inTomadorForaOsasco] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inEmpresaSuperSimples] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inPermiteDevolucaoCredito] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inPermiteTransferenciaCredito] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inPermiteTransferenciaCreditoMultipla] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[vlMaximoAbatimentoIPTU] [decimal](18, 2) NOT NULL,
 CONSTRAINT [pkCONFIGURACAOCREDITOIPTU] PRIMARY KEY CLUSTERED 
(
	[cdConfiguracaoCreditoIptu] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BANCOS]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BANCOS](
	[cdBanco] [int] NOT NULL,
	[dcCodigoBanco] [varchar](10) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcBanco] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkBANCOS] PRIMARY KEY CLUSTERED 
(
	[cdBanco] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ATIVASCANCELADAS]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ATIVASCANCELADAS](
	[IM] [float] NULL,
	[NOME] [nvarchar](255) COLLATE Latin1_General_CI_AI NULL,
	[INCICIO ATIV] [datetime] NULL,
	[DATA CANCELAMENTO] [nvarchar](255) COLLATE Latin1_General_CI_AI NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ARREPGEXPORTACAOPAGAMENTOS_ITRIB]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ARREPGEXPORTACAOPAGAMENTOS_ITRIB](
	[IDF_PAGAMENTO_EXPORTACAO] [int] NOT NULL,
	[NUM_SEQ_ARQUIVO] [int] NOT NULL,
	[NUM_NOSSO_NUMERO] [decimal](17, 0) NOT NULL,
	[VLR_PAGAMENTO] [decimal](18, 2) NOT NULL,
	[DTA_PAGAMENTO] [datetime] NOT NULL,
 CONSTRAINT [pkARREPGEXPORTACAOPAGAMENTOS_ITRIB] PRIMARY KEY CLUSTERED 
(
	[IDF_PAGAMENTO_EXPORTACAO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ALIQUOTASUPERSIMPLES]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALIQUOTASUPERSIMPLES](
	[cdAliquotaSuperSimples] [int] IDENTITY(1,1) NOT NULL,
	[nrValor] [decimal](4, 2) NOT NULL,
 CONSTRAINT [pkALIQUOTASUPERSIMPLES] PRIMARY KEY CLUSTERED 
(
	[cdAliquotaSuperSimples] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOGINCONSISTENCIAPAGAMENTO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOGINCONSISTENCIAPAGAMENTO](
	[cdLogInconsistenciaPagamento] [int] IDENTITY(1,1) NOT NULL,
	[nrTipo] [tinyint] NOT NULL,
	[dtLog] [smalldatetime] NOT NULL,
	[nrIdConvivencia] [int] NOT NULL,
	[nrSequenciaArquivo] [int] NOT NULL,
	[nrNossoNumero] [varchar](20) COLLATE Latin1_General_CI_AI NOT NULL,
	[vlPagamento] [decimal](18, 2) NOT NULL,
	[dtPagamento] [smalldatetime] NOT NULL,
 CONSTRAINT [pkLOGINCONSISTENCIAPAGAMENTO] PRIMARY KEY CLUSTERED 
(
	[cdLogInconsistenciaPagamento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LOGERROS]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOGERROS](
	[cdEvento] [int] IDENTITY(1,1) NOT NULL,
	[dtEvento] [datetime] NOT NULL,
	[dcEvento] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcFuncionalidade] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[dcOrigem] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcTipo] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcNatureza] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
	[inCriticidade] [smallint] NOT NULL,
	[dcXmlCausador] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[dcXmlAdicional] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkAUDITORIAEVENTOS] PRIMARY KEY CLUSTERED 
(
	[cdEvento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixLogErros01] ON [dbo].[LOGERROS] 
(
	[dtEvento] DESC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
/****** Object:  Table [dbo].[LockChain]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LockChain](
	[Blocker] [smallint] NULL,
	[Blocked] [smallint] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOCALIDADE]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOCALIDADE](
	[cdLocalidade] [int] IDENTITY(1,1) NOT NULL,
	[dcLocalidade] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcEstadoSigla] [varchar](3) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcCodigoCorreio] [varchar](8) COLLATE Latin1_General_CI_AI NOT NULL,
	[inTipoLocalidade] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkLOCALIDADE] PRIMARY KEY CLUSTERED 
(
	[cdLocalidade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ISSRLCRen_Leg_Contribuinte]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ISSRLCRen_Leg_Contribuinte](
	[ID_Contribuinte] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[Inscricao_Municipal] [varchar](10) COLLATE Latin1_General_CI_AI NOT NULL,
	[Ano] [int] NOT NULL,
	[Data_Envio] [datetime] NULL,
	[Num_CNPJ] [varchar](14) COLLATE Latin1_General_CI_AI NULL,
	[Num_CPF] [varchar](11) COLLATE Latin1_General_CI_AI NULL,
	[Razao_Social] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
	[End_Logradouro] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
	[End_Numero] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[End_Complemento] [varchar](30) COLLATE Latin1_General_CI_AI NULL,
	[End_Bairro] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[End_Cep] [varchar](8) COLLATE Latin1_General_CI_AI NOT NULL,
	[Inscricao_Estadual] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[Registro_Jucesp] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[Num_RG] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[Reg_Orgao_Classe] [varchar](20) COLLATE Latin1_General_CI_AI NULL,
	[Fone_DDD] [varchar](4) COLLATE Latin1_General_CI_AI NULL,
	[Fone_Num] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[Inscr_Imovel] [varchar](25) COLLATE Latin1_General_CI_AI NULL,
	[Tipo_Industria] [bit] NOT NULL,
	[Tipo_Comercio] [bit] NOT NULL,
	[Tipo_Prestador] [bit] NOT NULL,
	[Tipo_Outros] [bit] NOT NULL,
	[Num_Empreg_Aluno] [int] NULL,
	[Num_Socio_Profis] [int] NULL,
	[Num_Barb_Cong] [int] NULL,
	[Num_Bilhar_Peb] [int] NULL,
	[Num_Div_Eletronica] [int] NULL,
	[Metr_Banca] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[Tipo_Zona] [tinyint] NULL,
	[End_Corr_Logradouro] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[End_Corr_Numero] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[End_Corr_Compl] [varchar](30) COLLATE Latin1_General_CI_AI NULL,
	[End_Corr_Bairro] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[End_Corr_Cep] [varchar](8) COLLATE Latin1_General_CI_AI NULL,
	[Observacoes] [varchar](400) COLLATE Latin1_General_CI_AI NULL,
	[ID_MOB] [int] NULL,
 CONSTRAINT [PK_ISSRLCRenov_Legado_Contri] PRIMARY KEY CLUSTERED 
(
	[ID_Contribuinte] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ix_Inscricao_Municipal] ON [dbo].[ISSRLCRen_Leg_Contribuinte] 
(
	[Inscricao_Municipal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[ISSRNCRen_Contribuinte]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ISSRNCRen_Contribuinte](
	[ID_Contribuinte] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[Inscricao_Municipal] [varchar](10) COLLATE Latin1_General_CI_AI NOT NULL,
	[Ano] [int] NOT NULL,
	[Data_Envio] [datetime] NULL,
	[Num_CNPJ] [varchar](14) COLLATE Latin1_General_CI_AI NULL,
	[Num_CPF] [varchar](11) COLLATE Latin1_General_CI_AI NULL,
	[Razao_Social] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
	[End_Logradouro] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
	[End_Numero] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[End_Complemento] [varchar](30) COLLATE Latin1_General_CI_AI NULL,
	[End_Bairro] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[End_Cep] [varchar](8) COLLATE Latin1_General_CI_AI NOT NULL,
	[Inscricao_Estadual] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[Registro_Jucesp] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[Num_RG] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[Reg_Orgao_Classe] [varchar](20) COLLATE Latin1_General_CI_AI NULL,
	[Fone_DDD] [varchar](4) COLLATE Latin1_General_CI_AI NULL,
	[Fone_Num] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[Inscr_Imovel] [varchar](20) COLLATE Latin1_General_CI_AI NULL,
	[Tipo_Industria] [bit] NOT NULL,
	[Tipo_Comercio] [bit] NOT NULL,
	[Tipo_Prestador] [bit] NOT NULL,
	[Tipo_Outros] [bit] NOT NULL,
	[Num_Empreg_Aluno] [int] NULL,
	[Num_Socio_Profis] [int] NULL,
	[Num_Barb_Cong] [int] NULL,
	[Num_Bilhar_Peb] [int] NULL,
	[Num_Div_Eletronica] [int] NULL,
	[Metr_Banca] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[Tipo_Zona] [tinyint] NULL,
	[End_Corr_Logradouro] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[End_Corr_Numero] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[End_Corr_Compl] [varchar](30) COLLATE Latin1_General_CI_AI NULL,
	[End_Corr_Bairro] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[End_Corr_Cep] [varchar](8) COLLATE Latin1_General_CI_AI NULL,
	[Observacoes] [varchar](400) COLLATE Latin1_General_CI_AI NULL,
	[Num_ip] [varchar](20) COLLATE Latin1_General_CI_AI NULL,
	[Data_Gravacao] [datetime] NULL,
	[inStatus] [int] NOT NULL,
 CONSTRAINT [PK_ISSRLCRenov_Contri] PRIMARY KEY CLUSTERED 
(
	[ID_Contribuinte] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ITEMATIVIDADE]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ITEMATIVIDADE](
	[cdItemAtividade] [int] IDENTITY(1,1) NOT NULL,
	[dcItemAtividade] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkITEMATIVIDADE] PRIMARY KEY CLUSTERED 
(
	[cdItemAtividade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixItemAtividade01] ON [dbo].[ITEMATIVIDADE] 
(
	[dcItemAtividade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[ISSRTPRen_Tipo_Puplic]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ISSRTPRen_Tipo_Puplic](
	[ID_TipoPublicidade] [int] NOT NULL,
	[Tipo_Publicidade] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [PK_ISSRTPRenov_Tipo_Publi] PRIMARY KEY CLUSTERED 
(
	[ID_TipoPublicidade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GRUPOATIVIDADE]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GRUPOATIVIDADE](
	[cdGrupoAtividade] [int] IDENTITY(1,1) NOT NULL,
	[nrGrupoAtividade] [varchar](3) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcGrupoAtividade] [varchar](200) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkGRUPOATIVIDADE] PRIMARY KEY CLUSTERED 
(
	[cdGrupoAtividade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixGrupoAtividade01] ON [dbo].[GRUPOATIVIDADE] 
(
	[nrGrupoAtividade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixGrupoAtividade02] ON [dbo].[GRUPOATIVIDADE] 
(
	[dcGrupoAtividade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[GERACAOPDFNOTAFISCAL]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GERACAOPDFNOTAFISCAL](
	[cdGeracaoPdfNotaFiscal] [int] IDENTITY(1,1) NOT NULL,
	[dcNomeArquivo] [varchar](250) COLLATE Latin1_General_CI_AI NOT NULL,
	[inStatusGeracao] [tinyint] NOT NULL,
	[dtCriacao] [datetime] NOT NULL,
	[dtErro] [datetime] NULL,
	[dtFinalizado] [datetime] NULL,
	[dcErro] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkGERACAOPDFNOTAFISCAL] PRIMARY KEY CLUSTERED 
(
	[cdGeracaoPdfNotaFiscal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[INATIVAS]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[INATIVAS](
	[num_inscricao] [bigint] NOT NULL,
	[des_nome] [varchar](150) COLLATE Latin1_General_CI_AI NULL,
	[data_ult_alteracao] [datetime] NOT NULL,
	[tipo_pessoa] [char](2) COLLATE Latin1_General_CI_AI NOT NULL,
	[cnpj] [char](14) COLLATE Latin1_General_CI_AI NULL,
	[cpf] [char](11) COLLATE Latin1_General_CI_AI NULL,
	[end] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
	[num] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[cep] [varchar](8) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkINATIVAS] PRIMARY KEY CLUSTERED 
(
	[num_inscricao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ISSFIXO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ISSFIXO](
	[IM] [float] NULL,
	[NOME] [nvarchar](255) COLLATE Latin1_General_CI_AI NULL,
	[INCICIO ATIV] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IO_SQLTB_FILESTATS_LATENCY]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IO_SQLTB_FILESTATS_LATENCY](
	[ReadLatency] [bigint] NULL,
	[WriteLatency] [bigint] NULL,
	[Latency] [bigint] NULL,
	[AvgBPerRead] [bigint] NULL,
	[AvgBPerWrite] [bigint] NULL,
	[AvgBPerTransfer] [bigint] NULL,
	[Drive] [nvarchar](2) COLLATE Latin1_General_CI_AI NULL,
	[DB] [nvarchar](128) COLLATE Latin1_General_CI_AI NULL,
	[physical_name] [nvarchar](260) COLLATE Latin1_General_CI_AI NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IO_SQLTB_FILESTATS_GROUP]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IO_SQLTB_FILESTATS_GROUP](
	[FileVolume] [varchar](20) COLLATE Latin1_General_CI_AI NULL,
	[NumberReads] [bigint] NULL,
	[BytesRead] [bigint] NULL,
	[NumberWrites] [bigint] NULL,
	[BytesWritten] [bigint] NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IO_SQLTB_FILESTATS]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IO_SQLTB_FILESTATS](
	[DbId] [int] NOT NULL,
	[DBName] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[fileid] [int] NOT NULL,
	[FileName] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[SampleTime] [datetime] NOT NULL,
	[TS] [bigint] NULL,
	[NumberReads] [bigint] NULL,
	[BytesRead] [bigint] NULL,
	[IoStallReadMS] [bigint] NULL,
	[NumberWrites] [bigint] NULL,
	[BytesWritten] [bigint] NULL,
	[IOStallWriteMS] [bigint] NULL,
	[IOStallMS] [bigint] NULL,
	[BytesOnDisk] [bigint] NULL,
	[FilePhysicalName] [varchar](1000) COLLATE Latin1_General_CI_AI NULL,
	[FileVolume] [varchar](20) COLLATE Latin1_General_CI_AI NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PERFILACESSO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PERFILACESSO](
	[cdPerfilAcesso] [int] NOT NULL,
	[nmPerfilAcesso] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcPerfilAcesso] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
	[inAtivo] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inPadrao] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrTipoPadrao] [smallint] NULL,
	[inFiscal] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkPERFILACESSO] PRIMARY KEY CLUSTERED 
(
	[cdPerfilAcesso] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixPerfilAcesso01] ON [dbo].[PERFILACESSO] 
(
	[nmPerfilAcesso] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfUm]', @objname=N'[dbo].[PERFILACESSO].[inAtivo]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PERFILACESSO].[inPadrao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PERFILACESSO].[inFiscal]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfUm]', @objname=N'[dbo].[PERFILACESSO].[inAtivo]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PERFILACESSO].[inPadrao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PERFILACESSO].[inFiscal]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[INCONSISTENCIAFISCALIZACAO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[INCONSISTENCIAFISCALIZACAO](
	[cdInconsistenciaFiscalizacao] [int] IDENTITY(1,1) NOT NULL,
	[dtInconsistenciaFiscalizacao] [datetime] NOT NULL,
	[cdTipoInconsistencia] [smallint] NOT NULL,
	[inSituacao] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcMotivoSituacao] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
	[cdPessoaEncaminhamento] [int] NULL,
	[dtEncaminhamento] [datetime] NULL,
	[cdPessoaResponsavel] [int] NULL,
	[cdDocumento] [int] NOT NULL,
	[nrDocumento] [numeric](19, 0) NULL,
	[vlIss] [decimal](18, 2) NULL,
	[dcTipoDocumento] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
	[dtEmissao] [datetime] NULL,
	[dtDeclaracao] [datetime] NULL,
	[dcAtividade] [varchar](510) COLLATE Latin1_General_CI_AI NULL,
	[vlDiferenca] [decimal](18, 2) NULL,
	[cdDocumentoRelacionado] [int] NULL,
	[cdPessoaPrestador] [int] NULL,
	[dcPrestador] [varchar](150) COLLATE Latin1_General_CI_AI NULL,
	[dcCPFPrestador] [char](11) COLLATE Latin1_General_CI_AI NULL,
	[dcCNPJPrestador] [char](14) COLLATE Latin1_General_CI_AI NULL,
	[nrInscricaoMunicipalPrestador] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[cdPessoaTomador] [int] NULL,
	[dcTomador] [varchar](150) COLLATE Latin1_General_CI_AI NULL,
	[dcCPFTomador] [char](11) COLLATE Latin1_General_CI_AI NULL,
	[dcCNPJTomador] [char](14) COLLATE Latin1_General_CI_AI NULL,
	[nrInscricaoMunicipalTomador] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[dcSerieNotaFiscal] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[nrExercicio] [int] NULL,
	[nrMes] [int] NULL,
	[dcGrauEnsino] [varchar](20) COLLATE Latin1_General_CI_AI NULL,
	[qtContratos] [int] NULL,
	[vlReceita] [decimal](18, 2) NULL,
	[vlApurado] [numeric](18, 2) NULL,
	[qtApurado] [int] NULL,
 CONSTRAINT [pkINCONSISTENCIAFISCALIZACAO] PRIMARY KEY CLUSTERED 
(
	[cdInconsistenciaFiscalizacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixInconsistenciaFiscalizacao01] ON [dbo].[INCONSISTENCIAFISCALIZACAO] 
(
	[cdTipoInconsistencia] ASC,
	[inSituacao] ASC
)
INCLUDE ( [cdInconsistenciaFiscalizacao],
[cdDocumento],
[cdDocumentoRelacionado]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixInconsistenciaFiscalizacao02] ON [dbo].[INCONSISTENCIAFISCALIZACAO] 
(
	[cdTipoInconsistencia] ASC,
	[inSituacao] ASC
)
INCLUDE ( [cdInconsistenciaFiscalizacao],
[cdDocumento],
[nrDocumento],
[cdPessoaPrestador],
[cdPessoaTomador]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[INCONSISTENCIABAIXADAM]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[INCONSISTENCIABAIXADAM](
	[cdInconsistenciaBaixaDam] [int] IDENTITY(1,1) NOT NULL,
	[cdLegado] [int] NULL,
	[nrNossoNumero] [char](17) COLLATE Latin1_General_CI_AI NULL,
	[vlPagamento] [money] NOT NULL,
	[dtPagamento] [datetime] NULL,
	[dtInconsistencia] [datetime] NULL,
	[dcInconsistencia] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[inSituacaoInconsistencia] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkINCONSISTENCIABAIXADAM] PRIMARY KEY CLUSTERED 
(
	[cdInconsistenciaBaixaDam] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixInconsistenciaBaixaDam01] ON [dbo].[INCONSISTENCIABAIXADAM] 
(
	[inSituacaoInconsistencia] ASC
)
INCLUDE ( [cdInconsistenciaBaixaDam],
[cdLegado],
[nrNossoNumero],
[vlPagamento],
[dtPagamento],
[dtInconsistencia],
[dcInconsistencia]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[INCONSISTENCIABAIXADAM].[inSituacaoInconsistencia]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[INCONSISTENCIABAIXADAM].[inSituacaoInconsistencia]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[ISSRNSRen_Socio]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ISSRNSRen_Socio](
	[Id_Socio] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[Id_Contribuinte] [numeric](10, 0) NOT NULL,
	[Nome] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[Num_Documento] [varchar](14) COLLATE Latin1_General_CI_AI NULL,
	[Num_RG] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[Reg_Orgao_Classe] [varchar](20) COLLATE Latin1_General_CI_AI NULL,
	[End_Logradouro] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[End_Numero] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[End_Compl] [varchar](30) COLLATE Latin1_General_CI_AI NULL,
	[End_Bairro] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[End_Cep] [varchar](8) COLLATE Latin1_General_CI_AI NULL,
	[_Inscricao] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[Nome_Pai] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[Nome_Mae] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [PK_ISSRLSRenov_Socio] PRIMARY KEY CLUSTERED 
(
	[Id_Socio] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ISSRNPRen_Publicidade]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ISSRNPRen_Publicidade](
	[Id_Publicidade] [int] IDENTITY(1,1) NOT NULL,
	[Id_Contribuinte] [numeric](10, 0) NOT NULL,
	[Id_Tipo_Publicidade] [int] NOT NULL,
	[Quantidade] [int] NOT NULL,
	[Metragem] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[Data_Inicio] [datetime] NOT NULL,
	[_Inscricao] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [PK_ISSRLPRenov_Publi] PRIMARY KEY CLUSTERED 
(
	[Id_Publicidade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ISSRNARen_Atividade]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ISSRNARen_Atividade](
	[Id_Atividade] [int] IDENTITY(1,1) NOT NULL,
	[Id_Contribuinte] [numeric](10, 0) NOT NULL,
	[Cod_Atividade] [varchar](5) COLLATE Latin1_General_CI_AI NULL,
	[_Inscricao] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [PK_ISSRLARenov_Ati] PRIMARY KEY CLUSTERED 
(
	[Id_Atividade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ISSRLSRen_Leg_Socio]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ISSRLSRen_Leg_Socio](
	[Id_Socio] [numeric](10, 0) IDENTITY(1,1) NOT NULL,
	[Id_Contribuinte] [numeric](10, 0) NOT NULL,
	[Nome] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[Num_Documento] [varchar](14) COLLATE Latin1_General_CI_AI NULL,
	[Num_RG] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[Reg_Orgao_Classe] [varchar](20) COLLATE Latin1_General_CI_AI NULL,
	[End_Logradouro] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[End_Numero] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[End_Compl] [varchar](30) COLLATE Latin1_General_CI_AI NULL,
	[End_Bairro] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[End_Cep] [varchar](8) COLLATE Latin1_General_CI_AI NULL,
	[_Inscricao] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [PK_ISSRLSRenov_Legado_Socio] PRIMARY KEY CLUSTERED 
(
	[Id_Socio] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ISSRLPRen_Leg_Publicidade]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ISSRLPRen_Leg_Publicidade](
	[Id_Publicidade] [int] IDENTITY(1,1) NOT NULL,
	[Id_Contribuinte] [numeric](10, 0) NOT NULL,
	[Id_Tipo_Publicidade] [int] NOT NULL,
	[Quantidade] [int] NOT NULL,
	[Metragem] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[Data_Inicio] [datetime] NOT NULL,
	[_Inscricao] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [PK_ISSRLPRenov_Legado_Publi] PRIMARY KEY CLUSTERED 
(
	[Id_Publicidade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ix_Id_Contribuinte] ON [dbo].[ISSRLPRen_Leg_Publicidade] 
(
	[Id_Contribuinte] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[ISSRLARen_Leg_Atividade]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ISSRLARen_Leg_Atividade](
	[Id_Atividade] [int] IDENTITY(1,1) NOT NULL,
	[Id_Contribuinte] [numeric](10, 0) NOT NULL,
	[Cod_Atividade] [varchar](5) COLLATE Latin1_General_CI_AI NULL,
	[_Inscricao] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [PK_ISSRLARenov_Legado_Ati] PRIMARY KEY CLUSTERED 
(
	[Id_Atividade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ix_ID_CONTRIBUINTE] ON [dbo].[ISSRLARen_Leg_Atividade] 
(
	[Id_Contribuinte] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[JUROSMULTA]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[JUROSMULTA](
	[cdJurosMulta] [int] IDENTITY(1,1) NOT NULL,
	[dtInicioValidade] [datetime] NOT NULL,
	[inJurosCobrancaMes] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inJurosSobreValorCorrigido] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[vlJurosTipoCobranca] [smallint] NOT NULL,
	[vlJuros] [decimal](18, 2) NOT NULL,
	[inMultasTipoCobranca] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[vlMultas] [decimal](18, 2) NOT NULL,
	[vlMultasLimite] [decimal](18, 0) NOT NULL,
 CONSTRAINT [pkJUROSMULTA] PRIMARY KEY CLUSTERED 
(
	[cdJurosMulta] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[JUROSMULTA].[inJurosCobrancaMes]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[JUROSMULTA].[vlJurosTipoCobranca]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[JUROSMULTA].[inMultasTipoCobranca]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[JUROSMULTA].[inJurosCobrancaMes]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[JUROSMULTA].[vlJurosTipoCobranca]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[JUROSMULTA].[inMultasTipoCobranca]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[ATIVIDADE]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ATIVIDADE](
	[cdAtividade] [int] IDENTITY(1,1) NOT NULL,
	[nrAtividade] [varchar](5) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcAtividade] [varchar](500) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrLei] [varchar](12) COLLATE Latin1_General_CI_AI NULL,
	[inSubsTributaria] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inVetaAtividade] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inBloqueiaAtividade] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdSegmentoAtividade] [int] NULL,
	[cdGrupoAtividade] [int] NULL,
	[inDeducaoNotaFiscal] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkATIVIDADE] PRIMARY KEY CLUSTERED 
(
	[cdAtividade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixAtividade] ON [dbo].[ATIVIDADE] 
(
	[cdAtividade] ASC
)
INCLUDE ( [nrAtividade],
[dcAtividade],
[cdGrupoAtividade]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixAtividade01] ON [dbo].[ATIVIDADE] 
(
	[nrAtividade] ASC,
	[dcAtividade] ASC,
	[cdGrupoAtividade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixAtividade02] ON [dbo].[ATIVIDADE] 
(
	[cdGrupoAtividade] ASC,
	[nrAtividade] ASC
)
INCLUDE ( [cdAtividade]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[ATIVIDADE].[inDeducaoNotaFiscal]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[ATIVIDADE].[inDeducaoNotaFiscal]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[ALIQUOTA]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ALIQUOTA](
	[cdAliquota] [int] IDENTITY(1,1) NOT NULL,
	[nrincidencia] [smallint] NOT NULL,
	[nrTipoValor] [smallint] NOT NULL,
	[nrValor] [decimal](18, 2) NOT NULL,
 CONSTRAINT [pkALIQUOTA] PRIMARY KEY CLUSTERED 
(
	[cdAliquota] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[ALIQUOTA].[nrincidencia]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTres]', @objname=N'[dbo].[ALIQUOTA].[nrTipoValor]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[ALIQUOTA].[nrincidencia]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTres]', @objname=N'[dbo].[ALIQUOTA].[nrTipoValor]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[CADASTROTOMADORCREDITOS]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CADASTROTOMADORCREDITOS](
	[cdCadastroTomadorCreditos] [int] IDENTITY(1,1) NOT NULL,
	[dcCnpj] [char](14) COLLATE Latin1_General_CI_AI NULL,
	[dcCpf] [char](11) COLLATE Latin1_General_CI_AI NULL,
	[dcTomador] [varchar](150) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcCep] [varchar](8) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcLogradouro] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrNumero] [varchar](6) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcComplemento] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[dcBairro] [varchar](50) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcEstado] [varchar](2) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcLocalidade] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcEmail] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcSenha] [varchar](50) COLLATE Latin1_General_CI_AI NOT NULL,
	[dtCadastro] [datetime] NOT NULL,
	[inTomadorPublico] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkCADASTROTOMADORCREDITOS] PRIMARY KEY CLUSTERED 
(
	[cdCadastroTomadorCreditos] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[CADASTROTOMADORCREDITOS].[inTomadorPublico]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[CADASTROTOMADORCREDITOS].[inTomadorPublico]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[CONFIGURACAONOTAFISCAL]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CONFIGURACAONOTAFISCAL](
	[cdConfiguracaoNotaFiscal] [int] IDENTITY(1,1) NOT NULL,
	[nrTipoPermissao] [smallint] NOT NULL,
	[nrFaixaValor] [smallint] NULL,
	[vlInicial] [decimal](18, 2) NULL,
	[vlFinal] [decimal](18, 2) NULL,
	[dcDeptoResponsavel] [varchar](150) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcDoctosAdicionais] [varchar](1000) COLLATE Latin1_General_CI_AI NULL,
	[dcTextoAutorizacaoImpressa] [varchar](400) COLLATE Latin1_General_CI_AI NULL,
	[inPermiteContribFiscalizacao] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inPermiteContribDevedor] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inPermiteContribInconsistencia] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inPermiteContribInscricaoProvisoria] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inPermiteContribPessoaFisica] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inPermiteContribSemInscricao] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inApresenteDoctoAdicional] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inAssinaFirma] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inComparecePrefeitura] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcNotaFiscal] [varchar](256) COLLATE Latin1_General_CI_AI NOT NULL,
	[inNFMaisDeUmaAtividade] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrMaximoGeracaoPdfNotaFiscal] [int] NOT NULL,
 CONSTRAINT [pkCONFIGURACAONOTAFISCAL] PRIMARY KEY CLUSTERED 
(
	[cdConfiguracaoNotaFiscal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[nrTipoPermissao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatro]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[nrFaixaValor]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inPermiteContribFiscalizacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inPermiteContribDevedor]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inPermiteContribInconsistencia]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inPermiteContribInscricaoProvisoria]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inPermiteContribPessoaFisica]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inPermiteContribSemInscricao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inApresenteDoctoAdicional]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inAssinaFirma]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inComparecePrefeitura]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inNFMaisDeUmaAtividade]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inNFMaisDeUmaAtividade]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[nrTipoPermissao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatro]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[nrFaixaValor]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inPermiteContribFiscalizacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inPermiteContribDevedor]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inPermiteContribInconsistencia]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inPermiteContribInscricaoProvisoria]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inPermiteContribPessoaFisica]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inPermiteContribSemInscricao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inApresenteDoctoAdicional]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inAssinaFirma]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inComparecePrefeitura]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inNFMaisDeUmaAtividade]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGURACAONOTAFISCAL].[inNFMaisDeUmaAtividade]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[AGENDADORTAREFALOG]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AGENDADORTAREFALOG](
	[cdAgendadorTarefaLog] [int] IDENTITY(1,1) NOT NULL,
	[cdAgendadorTarefa] [int] NOT NULL,
	[dtInicio] [smalldatetime] NOT NULL,
	[dtTermino] [smalldatetime] NULL,
	[dcMensagem] [varchar](300) COLLATE Latin1_General_CI_AI NULL,
	[cdLogErro] [int] NULL,
 CONSTRAINT [pkAGENDADORTAREFALOG] PRIMARY KEY CLUSTERED 
(
	[cdAgendadorTarefaLog] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ENVIOEMAIL]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ENVIOEMAIL](
	[cdEnvioEmail] [int] IDENTITY(1,1) NOT NULL,
	[nrStatus] [tinyint] NOT NULL,
	[dtRegistro] [datetime] NOT NULL,
	[dcTitulo] [varchar](150) COLLATE Latin1_General_CI_AI NULL,
	[dcRemetente] [varchar](30) COLLATE Latin1_General_CI_AI NULL,
	[dcDestinatario] [varchar](150) COLLATE Latin1_General_CI_AI NULL,
	[dcCopiaOculta] [varchar](150) COLLATE Latin1_General_CI_AI NULL,
	[dcConteudo] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[cdEmailOrigem] [int] NULL,
 CONSTRAINT [pkENVIOEMAIL] PRIMARY KEY CLUSTERED 
(
	[cdEnvioEmail] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUmDois]', @objname=N'[dbo].[ENVIOEMAIL].[nrStatus]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUmDois]', @objname=N'[dbo].[ENVIOEMAIL].[nrStatus]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[TRANSACAO]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TRANSACAO](
	[cdTransacao] [smallint] NOT NULL,
	[dcNomeTransacao] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[inAuditavel] [char](1) COLLATE Latin1_General_CI_AI NULL,
	[cdTabelaAuditoria] [smallint] NOT NULL,
 CONSTRAINT [pkTRANSACAO] PRIMARY KEY CLUSTERED 
(
	[cdTransacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[TRANSACAO].[inAuditavel]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[TRANSACAO].[inAuditavel]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[SERIENOTAFISCAL]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SERIENOTAFISCAL](
	[dcSerie] [varchar](50) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcComplemento] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
	[nrSituacao] [smallint] NOT NULL,
	[cdSerieNotaFiscal] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [pkSERIENOTAFISCAL] PRIMARY KEY CLUSTERED 
(
	[cdSerieNotaFiscal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixSerieNotaFiscal] ON [dbo].[SERIENOTAFISCAL] 
(
	[dcSerie] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[SERIENOTAFISCAL].[nrSituacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[SERIENOTAFISCAL].[nrSituacao]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[TIPODOCUMENTO]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TIPODOCUMENTO](
	[cdTipoDocumento] [int] NOT NULL,
	[dcTipoDocumento] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[inImportacaoServico] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inObrigatoriedadeSerie] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkTIPODOCUMENTO] PRIMARY KEY CLUSTERED 
(
	[cdTipoDocumento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixTipoDocumento01] ON [dbo].[TIPODOCUMENTO] 
(
	[dcTipoDocumento] ASC
)
INCLUDE ( [cdTipoDocumento],
[inImportacaoServico],
[inObrigatoriedadeSerie]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [teste] ON [dbo].[TIPODOCUMENTO] 
(
	[dcTipoDocumento] ASC
)
INCLUDE ( [cdTipoDocumento],
[inImportacaoServico],
[inObrigatoriedadeSerie]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[TIPODOCUMENTO].[inImportacaoServico]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[TIPODOCUMENTO].[inObrigatoriedadeSerie]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[TIPODOCUMENTO].[inImportacaoServico]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[TIPODOCUMENTO].[inObrigatoriedadeSerie]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[PREFEITURA]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PREFEITURA](
	[cdPrefeitura] [int] NOT NULL,
	[nmPrefeitura] [varchar](150) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcEndereco] [varchar](150) COLLATE Latin1_General_CI_AI NULL,
	[nrNumero] [varchar](5) COLLATE Latin1_General_CI_AI NULL,
	[dcComplemento] [varchar](80) COLLATE Latin1_General_CI_AI NULL,
	[dcBairro] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[dcEstado] [char](2) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcCidade] [varchar](80) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcCep] [char](8) COLLATE Latin1_General_CI_AI NULL,
	[dcCNPJ] [char](14) COLLATE Latin1_General_CI_AI NULL,
	[nrTelefone] [varchar](9) COLLATE Latin1_General_CI_AI NULL,
	[nrTelefoneAlt1] [varchar](12) COLLATE Latin1_General_CI_AI NULL,
	[nrTelefoneAlt2] [varchar](9) COLLATE Latin1_General_CI_AI NULL,
	[nmContato] [varchar](80) COLLATE Latin1_General_CI_AI NOT NULL,
	[dtImplantacao] [datetime] NOT NULL,
	[nmPrefeito] [varchar](80) COLLATE Latin1_General_CI_AI NOT NULL,
	[nmResponsavel] [varchar](80) COLLATE Latin1_General_CI_AI NULL,
	[dtInicialGestao] [datetime] NOT NULL,
	[dtFinalGestao] [datetime] NULL,
	[qtNFBloco] [smallint] NULL,
	[nrDiaPadraoVencimentoGuias] [smallint] NOT NULL,
	[inAvulsoEscola] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inAvulsoFinanceira] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inBloqueiaAvulso] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inBrasaoRelatorio] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inCredenciaContador] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inCredenciaGrafica] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inEnderecoAlterar] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inGuiaAvulsa] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inMaisEndereco] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inDocumentoAutorizado] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inValidaDuplicidade] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inValidaOrdem] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inIndicaContador] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inEmiteSemImu] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrCodCidade] [int] NOT NULL,
	[nrDiasUltimaEmissaoAvulsa] [smallint] NULL,
	[inAutorizaNF] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrTelefoneSuporte] [varchar](9) COLLATE Latin1_General_CI_AI NULL,
	[nrDDD] [char](2) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrDDDAlt1] [char](2) COLLATE Latin1_General_CI_AI NULL,
	[nrDDDAlt2] [char](2) COLLATE Latin1_General_CI_AI NULL,
	[nrDDDSuporte] [char](2) COLLATE Latin1_General_CI_AI NULL,
	[nrDiaMaxExercicioAnterior] [smallint] NULL,
	[nrMesMaxExercicioAnterior] [smallint] NULL,
	[nrAnoRenovaCredenciaContador] [smallint] NOT NULL,
	[inExigeTomadorEmissao] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inExigePrestadorEmissao] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[vlMargemVinculacaoGuia] [decimal](18, 2) NOT NULL,
	[dcCaminhoExecutavelOffline] [varchar](250) COLLATE Latin1_General_CI_AI NULL,
	[dcVersaoExecutavelOffline] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[dcMecRegraCorrValorPag] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcMecRegraCorrDataVencPag] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrAnoInicialContrCivil] [smallint] NOT NULL,
	[nrDiaMaxEmiEstimExcedente] [smallint] NOT NULL,
	[nrMesMaxEmiEstimExcedente] [smallint] NOT NULL,
	[nrAnoInicialEstimado] [smallint] NOT NULL,
	[dcModeloLivro] [varchar](15) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrDiaBloqueioRecProv] [smallint] NULL,
	[inBloqueioMaisDeUmaGuiaDocsEmitidos] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcLinkPortalServicos] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
	[dtInicioBloqueioGuia] [datetime] NULL,
	[dtFimBloqueioGuia] [datetime] NULL,
	[dtInicioBloqueioEdicaoExclusaoDocumento] [smalldatetime] NULL,
	[dtFimBloqueioEdicaoExclusaoDocumento] [smalldatetime] NULL,
 CONSTRAINT [pkPREFEITURA] PRIMARY KEY CLUSTERED 
(
	[cdPrefeitura] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inAvulsoEscola]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inAvulsoFinanceira]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inBloqueiaAvulso]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inBrasaoRelatorio]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inCredenciaContador]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inCredenciaGrafica]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inEnderecoAlterar]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfUm]', @objname=N'[dbo].[PREFEITURA].[inGuiaAvulsa]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inMaisEndereco]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inDocumentoAutorizado]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inValidaDuplicidade]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inValidaOrdem]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inIndicaContador]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inEmiteSemImu]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inAutorizaNF]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[df1]', @objname=N'[dbo].[PREFEITURA].[nrAnoRenovaCredenciaContador]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inExigeTomadorEmissao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PREFEITURA].[inExigeTomadorEmissao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inExigePrestadorEmissao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PREFEITURA].[inExigePrestadorEmissao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[df2008]', @objname=N'[dbo].[PREFEITURA].[nrAnoInicialEstimado]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inBloqueioMaisDeUmaGuiaDocsEmitidos]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inAvulsoEscola]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inAvulsoFinanceira]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inBloqueiaAvulso]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inBrasaoRelatorio]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inCredenciaContador]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inCredenciaGrafica]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inEnderecoAlterar]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfUm]', @objname=N'[dbo].[PREFEITURA].[inGuiaAvulsa]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inMaisEndereco]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inDocumentoAutorizado]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inValidaDuplicidade]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inValidaOrdem]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inIndicaContador]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inEmiteSemImu]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inAutorizaNF]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[df1]', @objname=N'[dbo].[PREFEITURA].[nrAnoRenovaCredenciaContador]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inExigeTomadorEmissao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PREFEITURA].[inExigeTomadorEmissao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inExigePrestadorEmissao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PREFEITURA].[inExigePrestadorEmissao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[df2008]', @objname=N'[dbo].[PREFEITURA].[nrAnoInicialEstimado]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PREFEITURA].[inBloqueioMaisDeUmaGuiaDocsEmitidos]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[PERMISSAOACESSO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PERMISSAOACESSO](
	[cdPermissaoAcesso] [int] NOT NULL,
	[dcPermissaoAcesso] [varchar](180) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdSegmentoAtividade] [int] NULL,
	[inDisponivelSistema] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkPERMISSAOACESSO] PRIMARY KEY CLUSTERED 
(
	[cdPermissaoAcesso] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PERMISSAOACESSO].[inDisponivelSistema]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PERMISSAOACESSO].[inDisponivelSistema]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PERMISSAOACESSO].[inDisponivelSistema]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PERMISSAOACESSO].[inDisponivelSistema]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[USUARIO]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[USUARIO](
	[dcLogin] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AI NOT NULL,
	[dcSenha] [varchar](50) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcLembreteSenha] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[dtUltimoAcesso] [datetime] NULL,
	[nrSituacao] [smallint] NOT NULL,
	[cdPerfilAcesso] [int] NOT NULL,
	[cdUsuario] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [pkUSUARIO] PRIMARY KEY CLUSTERED 
(
	[cdUsuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixUsuario01] ON [dbo].[USUARIO] 
(
	[dcLogin] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[USUARIO].[nrSituacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[USUARIO].[nrSituacao]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[PERFILPERMISSAO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERFILPERMISSAO](
	[cdPerfilPermissao] [int] NOT NULL,
	[cdPermissaoAcesso] [int] NOT NULL,
	[cdPerfilAcesso] [int] NOT NULL,
 CONSTRAINT [pkPERFILPERMISSAO] PRIMARY KEY CLUSTERED 
(
	[cdPerfilPermissao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixPerfilPermissao01] ON [dbo].[PERFILPERMISSAO] 
(
	[cdPermissaoAcesso] ASC,
	[cdPerfilAcesso] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[TIPOCONTRIBUINTE]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TIPOCONTRIBUINTE](
	[cdTipoContribuinte] [smallint] NOT NULL,
	[dcTipoContribuinte] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdPerfilAcesso] [int] NOT NULL,
 CONSTRAINT [pkTIPOCONTRIBUINTE] PRIMARY KEY CLUSTERED 
(
	[cdTipoContribuinte] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VIGENCIAALIQUOTAITEMATI]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VIGENCIAALIQUOTAITEMATI](
	[cdVigenciaAliquotaItemAti] [int] IDENTITY(1,1) NOT NULL,
	[dtFimAliquotaItemAti] [datetime] NULL,
	[dtInicioAliquotaItemAti] [datetime] NULL,
	[cdAtividade] [int] NOT NULL,
	[cdItemAtividade] [int] NOT NULL,
	[cdAliquota] [int] NULL,
	[inExclusao] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkVIGENCIAALIQUOTAITEMATI] PRIMARY KEY CLUSTERED 
(
	[cdVigenciaAliquotaItemAti] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixinExclusao] ON [dbo].[VIGENCIAALIQUOTAITEMATI] 
(
	[inExclusao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[VIGENCIAALIQUOTAITEMATI].[inExclusao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[VIGENCIAALIQUOTAITEMATI].[inExclusao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[VIGENCIAALIQUOTAITEMATI].[inExclusao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[VIGENCIAALIQUOTAITEMATI].[inExclusao]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[VIGENCIAALIQUOTAATI]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VIGENCIAALIQUOTAATI](
	[cdVigenciaAliquotaAti] [int] IDENTITY(1,1) NOT NULL,
	[dtFimAliquotaAti] [datetime] NULL,
	[dtInicioAliquotaAti] [datetime] NOT NULL,
	[cdAtividade] [int] NOT NULL,
	[cdAliquota] [int] NOT NULL,
	[inExclusao] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkVIGENCIAALIQUOTAATI] PRIMARY KEY CLUSTERED 
(
	[cdVigenciaAliquotaAti] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixVigenciaAliquotaAti01] ON [dbo].[VIGENCIAALIQUOTAATI] 
(
	[dtFimAliquotaAti] ASC,
	[dtInicioAliquotaAti] ASC,
	[cdAtividade] ASC,
	[inExclusao] ASC
)
INCLUDE ( [cdAliquota]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[VIGENCIAALIQUOTAATI].[inExclusao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[VIGENCIAALIQUOTAATI].[inExclusao]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[EMAILENTIDADE]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EMAILENTIDADE](
	[cdEnvioEmail] [int] NOT NULL,
	[cdEntidade] [int] NOT NULL,
	[nrTipoEntidade] [tinyint] NOT NULL,
 CONSTRAINT [pkEMAILENTIDADE] PRIMARY KEY CLUSTERED 
(
	[cdEnvioEmail] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ixEmailEntidade01] ON [dbo].[EMAILENTIDADE] 
(
	[cdEnvioEmail] ASC,
	[cdEntidade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUmDois]', @objname=N'[dbo].[EMAILENTIDADE].[nrTipoEntidade]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUmDois]', @objname=N'[dbo].[EMAILENTIDADE].[nrTipoEntidade]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[CREDITOIPTU]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CREDITOIPTU](
	[cdCreditoIptu] [int] IDENTITY(1,1) NOT NULL,
	[vlNotaFiscal] [decimal](18, 2) NOT NULL,
	[vlIss] [decimal](18, 2) NOT NULL,
	[vlCreditoIss] [decimal](18, 2) NOT NULL,
	[tpCreditoIss] [varchar](20) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcEmissorNotaFiscal] [varchar](150) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcCpfEmissorNotaFiscal] [char](11) COLLATE Latin1_General_CI_AI NULL,
	[dcCnpjEmissorNotaFiscal] [char](14) COLLATE Latin1_General_CI_AI NULL,
	[nrNotaFiscal] [decimal](19, 0) NOT NULL,
	[dtEmissaoNotaFiscal] [datetime] NOT NULL,
	[dtRegistroCreditoIss] [datetime] NOT NULL,
	[cdCadastroTomadorCreditos] [int] NOT NULL,
 CONSTRAINT [pkCREDITOIPTU] PRIMARY KEY CLUSTERED 
(
	[cdCreditoIptu] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CONFIGURACAONOTAFISCALATIVIDADE]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONFIGURACAONOTAFISCALATIVIDADE](
	[cdConfiguracaoNotaFiscalAtividade] [int] IDENTITY(1,1) NOT NULL,
	[cdConfiguracaoNotaFiscal] [int] NOT NULL,
	[cdAtividade] [int] NOT NULL,
 CONSTRAINT [pkCONFIGURACAONOTAFISCALATIVIDADE] PRIMARY KEY CLUSTERED 
(
	[cdConfiguracaoNotaFiscalAtividade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOGEMAIL]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOGEMAIL](
	[cdLogEmail] [int] IDENTITY(1,1) NOT NULL,
	[cdEnvioEmail] [int] NOT NULL,
	[cdServidorEmail] [int] NOT NULL,
	[dtCiclo] [datetime] NOT NULL,
	[inErro] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcMensagem] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkLOGEMAIL] PRIMARY KEY CLUSTERED 
(
	[cdLogEmail] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixLogEmail01] ON [dbo].[LOGEMAIL] 
(
	[inErro] ASC
)
INCLUDE ( [cdEnvioEmail]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
/****** Object:  Table [dbo].[INCONSISTENCIAFISCALIZACAOHISTORICO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[INCONSISTENCIAFISCALIZACAOHISTORICO](
	[cdInconsistenciaFiscalizacaoHistorico] [int] IDENTITY(1,1) NOT NULL,
	[cdInconsistenciaFiscalizacao] [int] NOT NULL,
	[cdPessoaResponsavel] [int] NOT NULL,
	[dtHistorico] [datetime] NOT NULL,
	[dcAcompanhamento] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkINCONSISTENCIAFISCALIZACAOHISTORICO] PRIMARY KEY CLUSTERED 
(
	[cdInconsistenciaFiscalizacaoHistorico] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixInconsistenciaFiscalizacaoHistorico01] ON [dbo].[INCONSISTENCIAFISCALIZACAOHISTORICO] 
(
	[cdInconsistenciaFiscalizacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[HISTORICOMOVIMENTACAOCREDITO]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HISTORICOMOVIMENTACAOCREDITO](
	[cdHistoricoMovimentacaoCredito] [int] IDENTITY(1,1) NOT NULL,
	[cdHistoricoMovimentacaoCreditoDevolucao] [int] NULL,
	[cdTomadorOrigem] [int] NOT NULL,
	[cdTomadorDestino] [int] NULL,
	[vlCreditoIss] [decimal](18, 2) NOT NULL,
	[dtHistoricoMovimentacao] [datetime] NOT NULL,
	[tpCreditoIss] [smallint] NOT NULL,
	[cdCDCIPTU] [int] NULL,
	[nrExercicioIPTU] [smallint] NULL,
 CONSTRAINT [pkHISTORICOMOVIMENTACAOCREDITO] PRIMARY KEY CLUSTERED 
(
	[cdHistoricoMovimentacaoCredito] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MENUAREADETRABALHO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MENUAREADETRABALHO](
	[cdMenuAreaDeTrabalho] [int] NOT NULL,
	[dcTextoExibicao] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdMenuAreaDeTrabalhoPai] [int] NULL,
	[cdPermissaoAcesso] [int] NOT NULL,
	[dcImagem] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkMENUAREADETRABALHO] PRIMARY KEY CLUSTERED 
(
	[cdMenuAreaDeTrabalho] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MENU]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MENU](
	[cdMenu] [int] NOT NULL,
	[cdNivel] [int] NOT NULL,
	[dcTextoExibicao] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcUrl] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
	[cdMenuPai] [int] NULL,
	[cdPermissaoAcesso] [int] NOT NULL,
	[nrOrdem] [smallint] NOT NULL,
 CONSTRAINT [pkMENU] PRIMARY KEY CLUSTERED 
(
	[cdMenu] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixMenu01] ON [dbo].[MENU] 
(
	[cdPermissaoAcesso] ASC
)
INCLUDE ( [cdMenu],
[dcTextoExibicao],
[cdMenuPai],
[dcUrl]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[MOVIMENTACAOCREDITOIPTU]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVIMENTACAOCREDITOIPTU](
	[cdCadastroTomadorCreditos] [int] NOT NULL,
	[vlTotalCreditoIss] [decimal](18, 2) NOT NULL,
	[vlTransferidoCreditoIss] [decimal](18, 2) NOT NULL,
	[vlUtilizadoCreditoIss] [decimal](18, 2) NOT NULL,
	[vlRecebidoCreditoIss] [decimal](18, 2) NULL,
	[vlDevolvidoCreditoIss] [decimal](18, 2) NOT NULL,
 CONSTRAINT [pkMOVIMENTACAOCREDITOIPTU] PRIMARY KEY CLUSTERED 
(
	[cdCadastroTomadorCreditos] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LOGWEBSERVICES]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOGWEBSERVICES](
	[cdLogWebServices] [int] IDENTITY(1,1) NOT NULL,
	[nrOperacao] [smallint] NOT NULL,
	[dcXMLRecebido] [varchar](max) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdUsuario] [int] NULL,
	[dcIPConsumidor] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[dtLog] [datetime] NOT NULL,
	[cdLogErros] [int] NULL,
 CONSTRAINT [pkLOGWEBSERVICES] PRIMARY KEY CLUSTERED 
(
	[cdLogWebServices] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixLogWebServices01] ON [dbo].[LOGWEBSERVICES] 
(
	[cdUsuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmANove]', @objname=N'[dbo].[LOGWEBSERVICES].[nrOperacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmANove]', @objname=N'[dbo].[LOGWEBSERVICES].[nrOperacao]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[MENSAGEMMURALAVISO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MENSAGEMMURALAVISO](
	[cdMensagemMuralAviso] [int] IDENTITY(1,1) NOT NULL,
	[dtCriacao] [datetime] NOT NULL,
	[dtExpiracao] [datetime] NULL,
	[dcMensagem] [varchar](500) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcTitulo] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdUsuario] [int] NOT NULL,
 CONSTRAINT [pkMENSAGEMMURALAVISO] PRIMARY KEY CLUSTERED 
(
	[cdMensagemMuralAviso] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PESSOA]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PESSOA](
	[cdPessoa] [int] IDENTITY(1,1) NOT NULL,
	[dcPessoa] [varchar](150) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrTelefone] [varchar](9) COLLATE Latin1_General_CI_AI NULL,
	[nrDDD] [char](2) COLLATE Latin1_General_CI_AI NULL,
	[dcEmail] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
	[dtCadastro] [datetime] NULL,
	[dtUltimaAlteracao] [datetime] NULL,
	[nrSituacao] [smallint] NOT NULL,
	[cdTipoContribuinte] [smallint] NULL,
	[inContrucaoCivil] [char](1) COLLATE Latin1_General_CI_AI NULL,
	[dtSuperSimples] [datetime] NULL,
 CONSTRAINT [pkPESSOA] PRIMARY KEY CLUSTERED 
(
	[cdPessoa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixPessoa01] ON [dbo].[PESSOA] 
(
	[dtSuperSimples] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[PESSOA].[nrSituacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PESSOA].[inContrucaoCivil]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PESSOA].[inContrucaoCivil]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[PESSOA].[nrSituacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PESSOA].[inContrucaoCivil]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PESSOA].[inContrucaoCivil]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[DENUNCIA]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DENUNCIA](
	[cdDenuncia] [int] IDENTITY(1,1) NOT NULL,
	[nrTipo] [smallint] NOT NULL,
	[nrSituacao] [smallint] NOT NULL,
	[dtDenuncia] [datetime] NOT NULL,
	[dcNomeDenunciante] [varchar](150) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcCNPJDenunciante] [varchar](14) COLLATE Latin1_General_CI_AI NULL,
	[dcCPFDenunciante] [varchar](11) COLLATE Latin1_General_CI_AI NULL,
	[dcTelefoneDenunciante] [varchar](11) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcEmailDenunciante] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[dcCNPJTomador] [varchar](14) COLLATE Latin1_General_CI_AI NULL,
	[dcCPFTomador] [varchar](11) COLLATE Latin1_General_CI_AI NULL,
	[dtEmissaoNotaRecibo] [datetime] NOT NULL,
	[nrNumeroNotaRecibo] [decimal](19, 0) NULL,
	[vlValorNotaRecibo] [decimal](18, 2) NOT NULL,
	[dcSerieNotaRecibo] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[dcCodigoAutenticidadeNotaRecibo] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[cdUsuarioFinalizacao] [int] NULL,
	[dcCNPJPrestador] [char](14) COLLATE Latin1_General_CI_AI NULL,
	[dcCPFPrestador] [char](11) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkDENUNCIA] PRIMARY KEY CLUSTERED 
(
	[cdDenuncia] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixDenuncia01] ON [dbo].[DENUNCIA] 
(
	[cdUsuarioFinalizacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[DENUNCIA].[nrTipo]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[DENUNCIA].[nrSituacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[DENUNCIA].[nrTipo]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[DENUNCIA].[nrSituacao]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[GUIAPAGAMENTOANTIGA]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GUIAPAGAMENTOANTIGA](
	[cdGuiaPagamentoAntiga] [int] IDENTITY(1,1) NOT NULL,
	[nrMesReferencia] [tinyint] NOT NULL,
	[nrExercicio] [smallint] NOT NULL,
	[nrTipoComprovante] [tinyint] NOT NULL,
	[cdUsuarioInclusao] [int] NOT NULL,
	[vlDocumento] [decimal](18, 2) NOT NULL,
	[vlCobrado] [decimal](18, 2) NOT NULL,
	[dtPagamento] [smalldatetime] NOT NULL,
	[vlPagamento] [decimal](18, 2) NOT NULL,
	[dtInclusao] [smalldatetime] NOT NULL,
	[dtVencimento] [smalldatetime] NOT NULL,
	[nrNossoNumero] [varchar](25) COLLATE Latin1_General_CI_AI NOT NULL,
	[inExcluido] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdUsuarioEdicao] [int] NULL,
	[cdUsuarioExclusao] [int] NULL,
	[dtDocumento] [smalldatetime] NULL,
	[dtEdicao] [smalldatetime] NULL,
	[dtExclusao] [smalldatetime] NULL,
	[nrCodigoBanco] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[nrCodigoBarra] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[nrCodigoCedente] [varchar](25) COLLATE Latin1_General_CI_AI NULL,
	[nrDocumento] [varchar](25) COLLATE Latin1_General_CI_AI NULL,
	[inPagamentoIntegrado] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrInscricaoMunicipal] [varchar](15) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrDocumentoContribuinte] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[dcContribuinte] [varchar](150) COLLATE Latin1_General_CI_AI NULL,
	[inBaixa] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkGUIAPAGAMENTOANTIGA] PRIMARY KEY CLUSTERED 
(
	[cdGuiaPagamentoAntiga] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[GUIAPAGAMENTOANTIGA].[inBaixa]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[GUIAPAGAMENTOANTIGA].[inBaixa]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[GUIAPAGAMENTOANTIGA].[inBaixa]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[GUIAPAGAMENTOANTIGA].[inBaixa]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[FERIADOFIXO]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FERIADOFIXO](
	[cdFeriadoFixo] [int] IDENTITY(1,1) NOT NULL,
	[dcFeriadoFixo] [varchar](200) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrDiaFeriadoFixo] [smallint] NOT NULL,
	[nrMesFeriadoFixo] [smallint] NOT NULL,
	[cdUsuarioCadastramento] [int] NULL,
 CONSTRAINT [pkFERIADOFIXO] PRIMARY KEY CLUSTERED 
(
	[cdFeriadoFixo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FERIADO]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FERIADO](
	[dtFeriado] [datetime] NOT NULL,
	[dcFeriado] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdUsuario] [int] NULL,
	[inFeriadoFixo] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdFeriado] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [pkFERIADO] PRIMARY KEY CLUSTERED 
(
	[cdFeriado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixFeriado01] ON [dbo].[FERIADO] 
(
	[dtFeriado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[INDICEMUNICIPIO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INDICEMUNICIPIO](
	[vlIndice] [decimal](18, 6) NOT NULL,
	[cdUsuario] [int] NOT NULL,
	[nrMes] [smallint] NOT NULL,
	[nrExercicio] [smallint] NOT NULL,
	[cdIndiceMunicipio] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [pkINDICEMUNICIPIO] PRIMARY KEY CLUSTERED 
(
	[cdIndiceMunicipio] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixIndiceMunicipio01] ON [dbo].[INDICEMUNICIPIO] 
(
	[nrMes] ASC,
	[nrExercicio] ASC
)
INCLUDE ( [vlIndice]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[INDICECORRECAOMONETARIA]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INDICECORRECAOMONETARIA](
	[nrAnoCorrecao] [smallint] NOT NULL,
	[vlIndiceCorrecao] [decimal](18, 6) NOT NULL,
	[nrMesCorrecao] [smallint] NOT NULL,
	[cdUsuario] [int] NOT NULL,
	[cdIndiceCorrecaoMonetaria] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [pkINDICECORRECAOMONETARIA] PRIMARY KEY CLUSTERED 
(
	[cdIndiceCorrecaoMonetaria] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixIndiceCorrecaoMonetaria01] ON [dbo].[INDICECORRECAOMONETARIA] 
(
	[nrAnoCorrecao] ASC,
	[nrMesCorrecao] ASC
)
INCLUDE ( [vlIndiceCorrecao]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[LOGAUDITORIA]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOGAUDITORIA](
	[cdLogAuditoria] [int] IDENTITY(1,1) NOT NULL,
	[dcCodigoLogAuditoria] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[dtOcorrencia] [datetime] NOT NULL,
	[cdRegistroAuditado] [int] NOT NULL,
	[cdUsuario] [int] NOT NULL,
	[cdAcaoAuditoria] [smallint] NOT NULL,
	[cdTabelaAuditoria] [smallint] NOT NULL,
	[cdTransacao] [smallint] NOT NULL,
 CONSTRAINT [pkLOGAUDITORIA] PRIMARY KEY CLUSTERED 
(
	[cdLogAuditoria] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixLogAuditoria01] ON [dbo].[LOGAUDITORIA] 
(
	[cdUsuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatroCinco]', @objname=N'[dbo].[LOGAUDITORIA].[cdAcaoAuditoria]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatroCinco]', @objname=N'[dbo].[LOGAUDITORIA].[cdAcaoAuditoria]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[CONFIGBOLETOBANCARIO]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CONFIGBOLETOBANCARIO](
	[dcInstrucaoCedente] [varchar](200) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcLocalPagamento] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcNomeCedente] [varchar](50) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcNumeroInicial] [varchar](15) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcNumeroAgencia] [varchar](15) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcNumeroConta] [varchar](15) COLLATE Latin1_General_CI_AI NOT NULL,
	[inSituacao] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrSubstituicaoTributaria] [smallint] NOT NULL,
	[nrCodigoDocumento] [smallint] NOT NULL,
	[nrDataDocumento] [smallint] NOT NULL,
	[nrDataProcessamento] [smallint] NOT NULL,
	[cdUsuario] [int] NOT NULL,
	[cdBanco] [int] NOT NULL,
	[cdConfigBoletoBancario] [int] IDENTITY(1,1) NOT NULL,
	[qtNossoNumero] [smallint] NOT NULL,
	[dcManifestoBoleto] [varchar](300) COLLATE Latin1_General_CI_AI NULL,
	[dtDataBase] [datetime] NOT NULL,
	[cdConvenio] [varchar](10) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrSufixo] [varchar](2) COLLATE Latin1_General_CI_AI NULL,
	[dcCarteira] [varchar](2) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkCONFIGBOLETOBANCARIO] PRIMARY KEY CLUSTERED 
(
	[cdConfigBoletoBancario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixConfigBoletoBancario01] ON [dbo].[CONFIGBOLETOBANCARIO] 
(
	[cdUsuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGBOLETOBANCARIO].[inSituacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[CONFIGBOLETOBANCARIO].[nrSubstituicaoTributaria]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTres]', @objname=N'[dbo].[CONFIGBOLETOBANCARIO].[nrCodigoDocumento]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTres]', @objname=N'[dbo].[CONFIGBOLETOBANCARIO].[nrDataDocumento]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTres]', @objname=N'[dbo].[CONFIGBOLETOBANCARIO].[nrDataProcessamento]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[df17]', @objname=N'[dbo].[CONFIGBOLETOBANCARIO].[qtNossoNumero]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONFIGBOLETOBANCARIO].[inSituacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[CONFIGBOLETOBANCARIO].[nrSubstituicaoTributaria]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTres]', @objname=N'[dbo].[CONFIGBOLETOBANCARIO].[nrCodigoDocumento]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTres]', @objname=N'[dbo].[CONFIGBOLETOBANCARIO].[nrDataDocumento]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTres]', @objname=N'[dbo].[CONFIGBOLETOBANCARIO].[nrDataProcessamento]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[df17]', @objname=N'[dbo].[CONFIGBOLETOBANCARIO].[qtNossoNumero]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[CONFIGAIDF]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CONFIGAIDF](
	[cdConfigAidf] [int] IDENTITY(1,1) NOT NULL,
	[dcNomePrefeitura] [varchar](50) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcNomeSecretaria] [varchar](50) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrInicial] [int] NOT NULL,
	[nrValidade] [int] NOT NULL,
	[dcTextoAidf] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrTipoValidade] [smallint] NOT NULL,
	[inAtivo] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inFiscalAlteraValidade] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inIncluiTexto] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdUsuario] [int] NOT NULL,
 CONSTRAINT [pkCONFIGAIDF] PRIMARY KEY CLUSTERED 
(
	[cdConfigAidf] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixConfigAidf01] ON [dbo].[CONFIGAIDF] 
(
	[cdUsuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[CONFIGAIDF].[nrTipoValidade]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[CONFIGAIDF].[nrTipoValidade]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[CODIGOPAGAMENTO]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CODIGOPAGAMENTO](
	[cdPagamento] [int] IDENTITY(1,1) NOT NULL,
	[cdUsuarioDeclarante] [int] NOT NULL,
	[cdUsuarioReimpressao] [int] NULL,
	[dtEmissao] [datetime] NOT NULL,
	[dtReImpressao] [datetime] NULL,
 CONSTRAINT [pkCODIGOPAGAMENTO] PRIMARY KEY CLUSTERED 
(
	[cdPagamento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ixCodigoPagamento01] ON [dbo].[CODIGOPAGAMENTO] 
(
	[cdUsuarioDeclarante] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixCodigoPagamento02] ON [dbo].[CODIGOPAGAMENTO] 
(
	[cdUsuarioDeclarante] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[USUARIOAUTORIZADORELEASE]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[USUARIOAUTORIZADORELEASE](
	[cdUsuario] [int] NOT NULL,
 CONSTRAINT [pkUSUARIOAUTORIZADORELEASE] PRIMARY KEY CLUSTERED 
(
	[cdUsuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PESSOASIMPLESNACIONAL]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PESSOASIMPLESNACIONAL](
	[cdPessoaSimplesNacional] [int] IDENTITY(1,1) NOT NULL,
	[nrInscricaoMunicipal] [varchar](15) COLLATE Latin1_General_CI_AI NOT NULL,
	[dtInicio] [datetime] NOT NULL,
	[dtFim] [datetime] NULL,
	[cdPessoa] [int] NULL,
	[inMEI] [char](1) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkPESSOASIMPLESNACIONAL] PRIMARY KEY CLUSTERED 
(
	[cdPessoaSimplesNacional] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixPessoaSimplesNacional01] ON [dbo].[PESSOASIMPLESNACIONAL] 
(
	[nrInscricaoMunicipal] ASC,
	[dtFim] ASC
)
INCLUDE ( [dtInicio]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixPessoaSimplesNacional02] ON [dbo].[PESSOASIMPLESNACIONAL] 
(
	[cdPessoa] ASC
)
INCLUDE ( [cdPessoaSimplesNacional],
[dtInicio],
[dtFim],
[nrInscricaoMunicipal]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[PESSOAJURIDICA]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PESSOAJURIDICA](
	[dcCnpj] [char](14) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcCpfRespAdministrativo] [char](11) COLLATE Latin1_General_CI_AI NULL,
	[dcNomeFantasia] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[dcNomeRespAdministrativo] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[cdPessoa] [int] NOT NULL,
	[inImportadorServicos] [char](1) COLLATE Latin1_General_CI_AI NULL,
PRIMARY KEY CLUSTERED 
(
	[cdPessoa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixPessoaJuridica01] ON [dbo].[PESSOAJURIDICA] 
(
	[cdPessoa] ASC
)
INCLUDE ( [dcCnpj]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixPessoaJuridica02] ON [dbo].[PESSOAJURIDICA] 
(
	[dcCnpj] ASC
)
INCLUDE ( [cdPessoa]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PESSOAJURIDICA].[inImportadorServicos]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PESSOAJURIDICA].[inImportadorServicos]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PESSOAJURIDICA].[inImportadorServicos]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PESSOAJURIDICA].[inImportadorServicos]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[PESSOAFISICA]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PESSOAFISICA](
	[dcCpf] [char](11) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrSexo] [smallint] NULL,
	[cdPessoa] [int] NOT NULL,
	[inPessoaSimplificada] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkPESSOAFISICA] PRIMARY KEY CLUSTERED 
(
	[cdPessoa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixPessoaFisica01] ON [dbo].[PESSOAFISICA] 
(
	[cdPessoa] ASC
)
INCLUDE ( [dcCpf]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixPessoaFisica02] ON [dbo].[PESSOAFISICA] 
(
	[dcCpf] ASC
)
INCLUDE ( [cdPessoa]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PESSOAFISICA].[inPessoaSimplificada]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PESSOAFISICA].[inPessoaSimplificada]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[PESSOAESTRANGEIRA]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PESSOAESTRANGEIRA](
	[cdPessoa] [int] NOT NULL,
	[cdPessoaCadastramento] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[cdPessoa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PESSOAATIVIDADE]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PESSOAATIVIDADE](
	[cdPessoaAtividade] [int] IDENTITY(1,1) NOT NULL,
	[dtInclusao] [datetime] NOT NULL,
	[inPrincipal] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdAtividade] [int] NOT NULL,
	[cdPessoa] [int] NOT NULL,
	[dtExclusao] [datetime] NULL,
 CONSTRAINT [pkPESSOAATIVIDADE] PRIMARY KEY CLUSTERED 
(
	[cdPessoaAtividade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixPessoaAtividade01] ON [dbo].[PESSOAATIVIDADE] 
(
	[cdPessoa] ASC,
	[cdPessoaAtividade] ASC,
	[dtExclusao] ASC,
	[dtInclusao] ASC,
	[cdAtividade] ASC
)
INCLUDE ( [inPrincipal]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[RPSTRANSMISSAO]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RPSTRANSMISSAO](
	[cdRPSTransmissao] [int] IDENTITY(1,1) NOT NULL,
	[cdPessoaPrestador] [int] NOT NULL,
	[dtEnvio] [datetime] NOT NULL,
	[cdUsuarioTransmissor] [int] NOT NULL,
	[dcArquivo] [varchar](200) COLLATE Latin1_General_CI_AI NOT NULL,
	[inTeste] [char](1) COLLATE Latin1_General_CI_AI NULL,
	[dtInicioIndicado] [datetime] NULL,
	[dtFimIndicado] [datetime] NULL,
	[dcConteudoArquivo] [varchar](max) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrStatusProcessamento] [tinyint] NOT NULL,
	[nrTotalRecibosEnviados] [int] NULL,
	[nrTotalNotasGeradas] [int] NULL,
	[nrTotalNotasCanceladas] [int] NULL,
	[nrReciboInicial] [decimal](19, 0) NULL,
	[nrReciboFinal] [decimal](19, 0) NULL,
	[nrNotaInicial] [decimal](19, 0) NULL,
	[nrNotaFinal] [decimal](19, 0) NULL,
	[dtInicioProcessamento] [datetime] NULL,
	[dtFimProcessamento] [datetime] NULL,
	[nrTotalInconsistencias] [int] NULL,
	[cdLogErro] [int] NULL,
	[dtStatusProcessamento] [datetime] NULL,
 CONSTRAINT [pkRPSTRANSMISSAO] PRIMARY KEY CLUSTERED 
(
	[cdRPSTransmissao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixRpsTransmissao01] ON [dbo].[RPSTRANSMISSAO] 
(
	[cdPessoaPrestador] ASC,
	[dtEnvio] DESC
)
INCLUDE ( [cdRPSTransmissao]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixRpsTransmissao02] ON [dbo].[RPSTRANSMISSAO] 
(
	[cdUsuarioTransmissor] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
/****** Object:  Table [dbo].[RPSAUTORIZACAOFORAPRAZO]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RPSAUTORIZACAOFORAPRAZO](
	[cdAutorizacaoForaPrazo] [int] IDENTITY(1,1) NOT NULL,
	[cdPessoaContribuinte] [int] NOT NULL,
	[nrMesRecibo] [tinyint] NOT NULL,
	[nrAnoRecibo] [smallint] NOT NULL,
	[dtLiberacaoInicial] [smalldatetime] NOT NULL,
	[dtLiberacaoFinal] [smalldatetime] NOT NULL,
	[dcObservacao] [varchar](500) COLLATE Latin1_General_CI_AI NULL,
	[cdPessoaFiscal] [int] NOT NULL,
	[cdUsuarioFiscal] [int] NOT NULL,
	[dtAutorizacao] [smalldatetime] NOT NULL,
	[dcProcessoAno] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkRPSAUTORIZACAOFORAPRAZO] PRIMARY KEY CLUSTERED 
(
	[cdAutorizacaoForaPrazo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixRpsAutorizacaoForaPrazo01] ON [dbo].[RPSAUTORIZACAOFORAPRAZO] 
(
	[cdUsuarioFiscal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[TOMADORPREFERENCIAL]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TOMADORPREFERENCIAL](
	[cdTomadorPreferencial] [int] IDENTITY(1,1) NOT NULL,
	[cdPessoaTomador] [int] NOT NULL,
	[cdPessoaPrestador] [int] NOT NULL,
 CONSTRAINT [pkTOMADORPREFERENCIAL] PRIMARY KEY CLUSTERED 
(
	[cdTomadorPreferencial] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ixTomadorPreferencial01] ON [dbo].[TOMADORPREFERENCIAL] 
(
	[cdPessoaPrestador] ASC
)
INCLUDE ( [cdPessoaTomador]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[PROVIDENCIADENUNCIA]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PROVIDENCIADENUNCIA](
	[cdProvidenciaDenuncia] [int] IDENTITY(1,1) NOT NULL,
	[cdDenuncia] [int] NOT NULL,
	[cdUsuarioFiscal] [int] NOT NULL,
	[dcProvidencia] [varchar](1000) COLLATE Latin1_General_CI_AI NOT NULL,
	[dtProvidencia] [datetime] NOT NULL,
	[inEmail] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcEmail] [varchar](1000) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkPROVIDENCIADENUNCIA] PRIMARY KEY CLUSTERED 
(
	[cdProvidenciaDenuncia] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixProvidenciaDenuncia01] ON [dbo].[PROVIDENCIADENUNCIA] 
(
	[cdUsuarioFiscal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PROVIDENCIADENUNCIA].[inEmail]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PROVIDENCIADENUNCIA].[inEmail]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[DESCRICAOSERVICONFECONTRIBUINTE]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DESCRICAOSERVICONFECONTRIBUINTE](
	[cdPessoa] [int] NOT NULL,
	[dcDescricaoServico] [varchar](3000) COLLATE Latin1_General_CI_AI NULL,
PRIMARY KEY CLUSTERED 
(
	[cdPessoa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DESCONTORECOLHIMENTO]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DESCONTORECOLHIMENTO](
	[cdDescontoRecolhimento] [int] IDENTITY(1,1) NOT NULL,
	[dtValidade] [datetime] NOT NULL,
	[vlDesconto] [money] NOT NULL,
	[cdPessoa] [int] NOT NULL,
	[nrTipoValor] [smallint] NOT NULL,
 CONSTRAINT [pkDESCONTORECOLHIMENTO] PRIMARY KEY CLUSTERED 
(
	[cdDescontoRecolhimento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTres]', @objname=N'[dbo].[DESCONTORECOLHIMENTO].[nrTipoValor]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTres]', @objname=N'[dbo].[DESCONTORECOLHIMENTO].[nrTipoValor]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[ENDERECO]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ENDERECO](
	[cdEndereco] [int] IDENTITY(1,1) NOT NULL,
	[dcLogradouro] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
	[dcBairro] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[dcCep] [varchar](8) COLLATE Latin1_General_CI_AI NULL,
	[inPrincipal] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcTipoLogradouro] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[dcLocalidade] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[dcEstado] [varchar](2) COLLATE Latin1_General_CI_AI NULL,
	[cdCorreioLocalidade] [int] NULL,
	[cdPessoa] [int] NOT NULL,
	[nrNumero] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[dcComplemento] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[cdCorreioLogradouro] [int] NULL,
	[dcPais] [varchar](80) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkENDERECO] PRIMARY KEY CLUSTERED 
(
	[cdEndereco] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixEndereco01] ON [dbo].[ENDERECO] 
(
	[cdPessoa] ASC
)
INCLUDE ( [cdEndereco],
[dcLogradouro],
[dcBairro],
[dcCep],
[inPrincipal],
[dcTipoLogradouro],
[dcLocalidade],
[dcEstado],
[cdCorreioLocalidade],
[nrNumero],
[dcComplemento],
[cdCorreioLogradouro],
[dcPais]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
/****** Object:  Table [dbo].[DOWNLOADOFFLINE]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DOWNLOADOFFLINE](
	[cdDownloadOffline] [int] IDENTITY(1,1) NOT NULL,
	[dtDownloadOffline] [datetime] NOT NULL,
	[dcIp] [varchar](15) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcVersaoOffline] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdPessoa] [int] NOT NULL,
	[cdUsuario] [int] NOT NULL,
 CONSTRAINT [pkDOWNLOADOFFLINE] PRIMARY KEY CLUSTERED 
(
	[cdDownloadOffline] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixDownloadOffline01] ON [dbo].[DOWNLOADOFFLINE] 
(
	[cdUsuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
/****** Object:  Table [dbo].[CONFIGURACAODEDUCAONOTAFISCAL]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CONFIGURACAODEDUCAONOTAFISCAL](
	[cdConfiguracaoDeducaoNotaFiscal] [int] IDENTITY(1,1) NOT NULL,
	[cdPessoaContribuinte] [int] NOT NULL,
	[vlPercentualMaximo] [decimal](18, 2) NOT NULL,
	[dtInicio] [smalldatetime] NOT NULL,
	[dtTermino] [smalldatetime] NULL,
	[cdUsuarioInclusao] [int] NOT NULL,
	[dtInclusao] [smalldatetime] NOT NULL,
	[cdUsuarioEdicao] [int] NULL,
	[dtEdicao] [smalldatetime] NULL,
	[cdUsuarioExclusao] [int] NULL,
	[dtExclusao] [smalldatetime] NULL,
	[inExcluido] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkCONFIGURACAODEDUCAONOTAFISCAL] PRIMARY KEY CLUSTERED 
(
	[cdConfiguracaoDeducaoNotaFiscal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[CONFIGURACAODEDUCAONOTAFISCAL].[inExcluido]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[CONFIGURACAODEDUCAONOTAFISCAL].[inExcluido]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[CONTADOR]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CONTADOR](
	[dcCRC] [varchar](15) COLLATE Latin1_General_CI_AI NOT NULL,
	[inCredenciado] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdPessoa] [int] NOT NULL,
	[dcCRCResponsavelAdm] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkCONTADOR] PRIMARY KEY CLUSTERED 
(
	[cdPessoa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CONFIGURACAONOTAFISCALPESSOA]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONFIGURACAONOTAFISCALPESSOA](
	[cdConfiguracaoNotaFiscalPessoa] [int] IDENTITY(1,1) NOT NULL,
	[cdConfiguracaoNotaFiscal] [int] NOT NULL,
	[cdPessoa] [int] NOT NULL,
 CONSTRAINT [pkCONFIGURACAONOTAFISCALPESSOA] PRIMARY KEY CLUSTERED 
(
	[cdConfiguracaoNotaFiscalPessoa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CREDENCIAGRAFICA]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CREDENCIAGRAFICA](
	[cdCredenciaGrafica] [int] IDENTITY(1,1) NOT NULL,
	[dtCredenciamento] [datetime] NULL,
	[dtDesCredenciamento] [datetime] NULL,
	[dtSolicitacao] [datetime] NOT NULL,
	[dcObservacao] [varchar](256) COLLATE Latin1_General_CI_AI NULL,
	[inCredenciaAutomatico] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrCredenciaGrafica] [smallint] NOT NULL,
	[cdFiscalCredenciador] [int] NULL,
	[cdGrafica] [int] NOT NULL,
	[dcMotivoDescredenciamento] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
	[cdFiscalDescredenciador] [int] NULL,
 CONSTRAINT [pkCREDENCIAGRAFICA] PRIMARY KEY CLUSTERED 
(
	[cdCredenciaGrafica] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatro]', @objname=N'[dbo].[CREDENCIAGRAFICA].[nrCredenciaGrafica]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatro]', @objname=N'[dbo].[CREDENCIAGRAFICA].[nrCredenciaGrafica]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[CREDENCIACONTADOR]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CREDENCIACONTADOR](
	[cdCredenciaContador] [int] IDENTITY(1,1) NOT NULL,
	[dtCredenciamento] [datetime] NULL,
	[dtDesCredenciamento] [datetime] NULL,
	[dtInclusao] [datetime] NOT NULL,
	[nrCredenciaContador] [smallint] NOT NULL,
	[inRenovacaoAutomatica] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdPessoaContador] [int] NOT NULL,
	[cdPessoaCredenciamento] [int] NULL,
	[cdPessoaDescredenciamento] [int] NULL,
	[dcMotivoDescredencia] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
	[dcObservacao] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkCREDENCIACONATADOR] PRIMARY KEY CLUSTERED 
(
	[cdCredenciaContador] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatro]', @objname=N'[dbo].[CREDENCIACONTADOR].[nrCredenciaContador]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatro]', @objname=N'[dbo].[CREDENCIACONTADOR].[nrCredenciaContador]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[CONTROLECOMPENSACAO]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CONTROLECOMPENSACAO](
	[cdControleCompensacao] [int] IDENTITY(1,1) NOT NULL,
	[cdPessoaContribuinte] [int] NOT NULL,
	[vlTotalCompensacao] [decimal](18, 2) NULL,
	[vlTotalUtilizado] [decimal](18, 2) NULL,
	[cdUsuario] [int] NOT NULL,
	[dtInclusao] [datetime] NOT NULL,
 CONSTRAINT [pkCONTROLECOMPENSACAO] PRIMARY KEY CLUSTERED 
(
	[cdControleCompensacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixControleCompensacao01] ON [dbo].[CONTROLECOMPENSACAO] 
(
	[cdPessoaContribuinte] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[CONTRIBUINTEPESSOAUSUARIO]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CONTRIBUINTEPESSOAUSUARIO](
	[cdContribuintePessoaUsuario] [int] IDENTITY(1,1) NOT NULL,
	[cdPessoaContribuinte] [int] NULL,
	[cdUsuario] [int] NOT NULL,
	[cdPessoaResponsavel] [int] NOT NULL,
	[inPrincipal] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkCONTRIBUINTEPESSOAUSUARIO] PRIMARY KEY CLUSTERED 
(
	[cdContribuintePessoaUsuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixContribuintePessoaUsuario01] ON [dbo].[CONTRIBUINTEPESSOAUSUARIO] 
(
	[cdUsuario] ASC
)
INCLUDE ( [cdPessoaContribuinte],
[cdPessoaResponsavel],
[inPrincipal]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixContribuintePessoaUsuario02] ON [dbo].[CONTRIBUINTEPESSOAUSUARIO] 
(
	[cdPessoaContribuinte] ASC,
	[cdUsuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
/****** Object:  Table [dbo].[CONTRIBUINTEFISCALIZACAO]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CONTRIBUINTEFISCALIZACAO](
	[cdContribuinteFiscalizacao] [int] IDENTITY(1,1) NOT NULL,
	[dtInicio] [datetime] NOT NULL,
	[dtFim] [datetime] NULL,
	[cdPessoa] [int] NOT NULL,
	[cdPessoaFiscal] [int] NOT NULL,
	[dtFiscalizacao] [datetime] NOT NULL,
	[dcSituacao] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[dcCodigoAcaoFiscal] [varchar](20) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkCONTRIBUINTEFISCALIZACAO] PRIMARY KEY CLUSTERED 
(
	[cdContribuinteFiscalizacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixContribuinteFiscalizacao01] ON [dbo].[CONTRIBUINTEFISCALIZACAO] 
(
	[cdPessoa] ASC,
	[dtInicio] ASC
)
INCLUDE ( [cdContribuinteFiscalizacao],
[dtFim]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[AGRUPAMENTOCONTRATOESCOLAR]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AGRUPAMENTOCONTRATOESCOLAR](
	[cdAgrupamentoContratoEscolar] [int] IDENTITY(1,1) NOT NULL,
	[vlAliquota] [decimal](18, 2) NOT NULL,
	[dtDeclaracao] [datetime] NOT NULL,
	[nrExercicio] [smallint] NOT NULL,
	[nrMes] [smallint] NOT NULL,
	[dcMotivoCancelamento] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
	[qtBolsistas] [int] NOT NULL,
	[qtContratos] [int] NOT NULL,
	[vlISS] [decimal](18, 2) NOT NULL,
	[vlReceita] [decimal](18, 2) NOT NULL,
	[nrGrauEnsino] [smallint] NOT NULL,
	[cdPessoa] [int] NOT NULL,
	[cdAtividade] [int] NOT NULL,
	[inSituacaoInconsistencia] [char](1) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkAGRUPAMENTOCONTRATOESCOLAR] PRIMARY KEY CLUSTERED 
(
	[cdAgrupamentoContratoEscolar] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixAgrupamentoContratoEscolar01] ON [dbo].[AGRUPAMENTOCONTRATOESCOLAR] 
(
	[nrExercicio] ASC,
	[nrMes] ASC,
	[nrGrauEnsino] ASC,
	[cdPessoa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatro]', @objname=N'[dbo].[AGRUPAMENTOCONTRATOESCOLAR].[nrGrauEnsino]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatro]', @objname=N'[dbo].[AGRUPAMENTOCONTRATOESCOLAR].[nrGrauEnsino]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[COMPENSACAO]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[COMPENSACAO](
	[cdCompensacao] [int] IDENTITY(1,1) NOT NULL,
	[cdPessoaContribuinte] [int] NOT NULL,
	[dcProcessoAno] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[vlCompensacao] [decimal](18, 2) NULL,
	[dcObservacao] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
	[cdUsuario] [int] NOT NULL,
	[dtCriacao] [datetime] NOT NULL,
	[inSituacao] [smallint] NOT NULL,
	[dtCancelamento] [datetime] NULL,
	[cdUsuarioCancelamento] [int] NULL,
	[dcMotivo] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkCOMPENSACAO] PRIMARY KEY CLUSTERED 
(
	[cdCompensacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixCompensacao01] ON [dbo].[COMPENSACAO] 
(
	[dtCriacao] ASC,
	[inSituacao] ASC
)
INCLUDE ( [cdPessoaContribuinte],
[dcProcessoAno],
[vlCompensacao],
[cdUsuario]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[COMPENSACAO].[inSituacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[COMPENSACAO].[inSituacao]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[AUTORIZACAOFORAORDEM]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AUTORIZACAOFORAORDEM](
	[dtAutorizacaoForaOrdem] [datetime] NOT NULL,
	[dcMotivo] [varchar](400) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrFinal] [numeric](19, 0) NOT NULL,
	[nrInicial] [numeric](19, 0) NOT NULL,
	[nrSituacao] [smallint] NOT NULL,
	[cdPessoa] [int] NOT NULL,
	[cdSerieNotaFiscal] [int] NOT NULL,
	[dtSituacao] [datetime] NULL,
	[dcObservacao] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
	[cdPessoaFiscalSituacao] [int] NULL,
	[cdAutorizacaoForaOrdem] [int] IDENTITY(1,1) NOT NULL,
	[dcJustificativaRejeicao] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkAUTORIZACAOFORAORDEM] PRIMARY KEY CLUSTERED 
(
	[cdAutorizacaoForaOrdem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixAutorizacaoForaOrdem01] ON [dbo].[AUTORIZACAOFORAORDEM] 
(
	[cdPessoa] ASC,
	[cdSerieNotaFiscal] ASC,
	[nrFinal] ASC,
	[nrInicial] ASC,
	[nrSituacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatroCinco]', @objname=N'[dbo].[AUTORIZACAOFORAORDEM].[nrSituacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatroCinco]', @objname=N'[dbo].[AUTORIZACAOFORAORDEM].[nrSituacao]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[LOGALTERACAOSENHA]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOGALTERACAOSENHA](
	[cdLogAlteracaoSenha] [int] IDENTITY(1,1) NOT NULL,
	[cdPessoa] [int] NOT NULL,
	[cdUsuario] [int] NOT NULL,
	[cdUsuarioOperacao] [int] NOT NULL,
	[dtAlteracao] [datetime] NOT NULL,
	[dcLogin] [varchar](15) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcSenhaAntiga] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[dcNovaSenha] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkLOGALTERACAOSENHA] PRIMARY KEY CLUSTERED 
(
	[cdLogAlteracaoSenha] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[INSCRICAOMUNICIPAL]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[INSCRICAOMUNICIPAL](
	[cdInscricaoMunicipal] [int] IDENTITY(1,1) NOT NULL,
	[dtInicial] [datetime] NOT NULL,
	[dtDesativacao] [datetime] NULL,
	[nrInscricaoMunicipal] [varchar](15) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdPessoa] [int] NOT NULL,
	[inProvisorio] [bit] NOT NULL,
 CONSTRAINT [pkINSCRICAOMUNICIPAL] PRIMARY KEY CLUSTERED 
(
	[cdInscricaoMunicipal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixInscricaoMunicipal02] ON [dbo].[INSCRICAOMUNICIPAL] 
(
	[cdPessoa] ASC
)
INCLUDE ( [nrInscricaoMunicipal]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixInscricaoMunicipal03] ON [dbo].[INSCRICAOMUNICIPAL] 
(
	[nrInscricaoMunicipal] ASC,
	[cdInscricaoMunicipal] ASC
)
INCLUDE ( [dtDesativacao],
[dtInicial]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixInscricaoMunicipal04] ON [dbo].[INSCRICAOMUNICIPAL] 
(
	[cdPessoa] ASC,
	[nrInscricaoMunicipal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixInscricaoMunicipal06] ON [dbo].[INSCRICAOMUNICIPAL] 
(
	[cdPessoa] ASC,
	[dtDesativacao] ASC
)
INCLUDE ( [nrInscricaoMunicipal],
[cdInscricaoMunicipal]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[IMPORTACAOLANCAMENTO]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IMPORTACAOLANCAMENTO](
	[cdImportacaoLancamento] [int] IDENTITY(1,1) NOT NULL,
	[cdUsuario] [int] NOT NULL,
	[cdPessoa] [int] NOT NULL,
	[dtImportacao] [datetime] NOT NULL,
	[inTeste] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inExpurgo] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[dtExpurgo] [datetime] NULL,
	[dtNotificacao] [datetime] NULL,
 CONSTRAINT [pkTRANSMISSAOARQ] PRIMARY KEY CLUSTERED 
(
	[cdImportacaoLancamento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixImportacaoLancamento01] ON [dbo].[IMPORTACAOLANCAMENTO] 
(
	[cdUsuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixImportacaoLancamento02] ON [dbo].[IMPORTACAOLANCAMENTO] 
(
	[cdPessoa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[IMPORTACAOLANCAMENTO].[inExpurgo]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[IMPORTACAOLANCAMENTO].[inExpurgo]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[EXCECAOATIVIDADE]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EXCECAOATIVIDADE](
	[cdExcecaoAtividade] [int] IDENTITY(1,1) NOT NULL,
	[vlAliquota] [decimal](18, 2) NULL,
	[dtInicioExcecaoAtividade] [datetime] NOT NULL,
	[dtFimExcecaoAtividade] [datetime] NULL,
	[inSubstituicaoTributaria] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdAtividade] [int] NOT NULL,
	[cdPessoa] [int] NOT NULL,
 CONSTRAINT [pkEXCECAOATIVIDADE] PRIMARY KEY CLUSTERED 
(
	[cdExcecaoAtividade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[EXCECAOATIVIDADE].[inSubstituicaoTributaria]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[EXCECAOATIVIDADE].[inSubstituicaoTributaria]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[DADOSPROMOCIONAIS]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DADOSPROMOCIONAIS](
	[cdDadosPromocionais] [int] IDENTITY(1,1) NOT NULL,
	[cdPessoa] [int] NOT NULL,
	[cdUsuarioFiscal] [int] NULL,
	[dcNomeFantasia] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcSite] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[nrDDD] [char](2) COLLATE Latin1_General_CI_AI NULL,
	[nrTelefone] [varchar](9) COLLATE Latin1_General_CI_AI NULL,
	[nrSituacao] [smallint] NOT NULL,
	[dcEmail] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[dcDescricao] [varchar](300) COLLATE Latin1_General_CI_AI NULL,
	[dcMotivoRecusa] [varchar](300) COLLATE Latin1_General_CI_AI NULL,
	[dtCriacao] [datetime] NOT NULL,
	[dtAutorizacao] [datetime] NULL,
	[bbLogotipo] [varbinary](max) NULL,
	[inMostrarLogotipoNFe] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkDADOSPROMOCIONAIS] PRIMARY KEY CLUSTERED 
(
	[cdDadosPromocionais] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixDadosPromocionais01] ON [dbo].[DADOSPROMOCIONAIS] 
(
	[cdPessoa] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixDadosPromocionais02] ON [dbo].[DADOSPROMOCIONAIS] 
(
	[cdUsuarioFiscal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTres]', @objname=N'[dbo].[DADOSPROMOCIONAIS].[nrSituacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[DADOSPROMOCIONAIS].[inMostrarLogotipoNFe]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTres]', @objname=N'[dbo].[DADOSPROMOCIONAIS].[nrSituacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[DADOSPROMOCIONAIS].[inMostrarLogotipoNFe]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[GUIAREEMBOLSO]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GUIAREEMBOLSO](
	[cdGuiaReembolso] [int] IDENTITY(1,1) NOT NULL,
	[cdContribuinte] [int] NOT NULL,
	[cdUsuarioInclusao] [int] NOT NULL,
	[inExcluido] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[vlReembolso] [decimal](18, 2) NOT NULL,
	[dcNumeroProcesso] [varchar](25) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrMotivo] [tinyint] NOT NULL,
	[dtInclusao] [smalldatetime] NOT NULL,
	[cdUsuarioExclusao] [int] NULL,
	[cdUsuarioEdicao] [int] NULL,
	[dtEdicao] [smalldatetime] NULL,
	[dtExclusao] [smalldatetime] NULL,
	[dcObservacao] [varchar](500) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkGUIAREEMBOLSO] PRIMARY KEY CLUSTERED 
(
	[cdGuiaReembolso] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PERMISSAOUSUARIONFE]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PERMISSAOUSUARIONFE](
	[cdPermissaoUsuarioNFE] [int] IDENTITY(1,1) NOT NULL,
	[cdPessoaContribuinte] [int] NOT NULL,
	[cdUsuario] [int] NOT NULL,
	[inUsuarioDoContador] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inAdministracaoUsuarios] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inEmissao] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inPesquisa] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inCancelamento] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inGerarCartaCorrecao] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inGerarArquivoRetorno] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkPERMISSAOUSUARIONFE] PRIMARY KEY CLUSTERED 
(
	[cdPermissaoUsuarioNFE] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixPermissaoUsuarioNFE01] ON [dbo].[PERMISSAOUSUARIONFE] 
(
	[cdPessoaContribuinte] ASC,
	[cdUsuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixPermissaoUsuarioNFE02] ON [dbo].[PERMISSAOUSUARIONFE] 
(
	[cdUsuario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[NOTAFISCALHOMOLOGACAO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NOTAFISCALHOMOLOGACAO](
	[cdNotaFiscalHomologacao] [int] IDENTITY(1,1) NOT NULL,
	[cdPessoaPrestador] [int] NOT NULL,
	[dcXmlNota] [varchar](max) COLLATE Latin1_General_CI_AI NOT NULL,
	[dtInclusao] [smalldatetime] NOT NULL,
 CONSTRAINT [pkNOTAFISCALHOMOLOGACAO] PRIMARY KEY CLUSTERED 
(
	[cdNotaFiscalHomologacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MENSAGEMCOMUNICACAO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MENSAGEMCOMUNICACAO](
	[cdMensagemComunicacao] [int] IDENTITY(1,1) NOT NULL,
	[dcAssunto] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcConteudo] [varchar](max) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrSituacao] [smallint] NOT NULL,
	[cdUsuarioFinalizador] [int] NULL,
	[cdContribuinteDestino] [int] NULL,
	[cdUsuarioEmissor] [int] NULL,
	[cdContribuinteOrigem] [int] NULL,
	[cdMensagemOriginal] [int] NULL,
	[dtEnvio] [datetime] NOT NULL,
	[inMonitoramentoAlerta] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[dtConfLeitura] [datetime] NULL,
 CONSTRAINT [pkMENSAGEMCOMUNICACAO] PRIMARY KEY CLUSTERED 
(
	[cdMensagemComunicacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixMensagemComunicacao01] ON [dbo].[MENSAGEMCOMUNICACAO] 
(
	[cdMensagemOriginal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixMensagemComunicacao02] ON [dbo].[MENSAGEMCOMUNICACAO] 
(
	[nrSituacao] ASC,
	[cdContribuinteDestino] ASC,
	[inMonitoramentoAlerta] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixMensagemComunicacao03] ON [dbo].[MENSAGEMCOMUNICACAO] 
(
	[cdContribuinteDestino] ASC,
	[nrSituacao] ASC
)
INCLUDE ( [dcAssunto],
[dcConteudo],
[cdUsuarioEmissor],
[cdContribuinteOrigem],
[cdMensagemOriginal],
[dtEnvio]) 
WHERE ([nrSituacao]<>(4))
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatro]', @objname=N'[dbo].[MENSAGEMCOMUNICACAO].[nrSituacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[MENSAGEMCOMUNICACAO].[inMonitoramentoAlerta]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatro]', @objname=N'[dbo].[MENSAGEMCOMUNICACAO].[nrSituacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[MENSAGEMCOMUNICACAO].[inMonitoramentoAlerta]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[INCONSISTENCIAFISCALIZACAOLOG]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INCONSISTENCIAFISCALIZACAOLOG](
	[cdInconsistenciaFiscalizacaoLog] [int] IDENTITY(1,1) NOT NULL,
	[cdInconsistenciaFiscalizacao] [int] NOT NULL,
	[cdPessoaEncaminhamento] [int] NOT NULL,
	[cdPessoaResponsavel] [int] NULL,
	[dtEncaminhamento] [datetime] NOT NULL,
	[tpInconsistenciaFiscalizacaoLog] [smallint] NULL,
 CONSTRAINT [pkINCONSISTENCIAFISCALIZACAOLOG] PRIMARY KEY CLUSTERED 
(
	[cdInconsistenciaFiscalizacaoLog] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OCORRENCIACONTRIBUINTE]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OCORRENCIACONTRIBUINTE](
	[cdOcorrenciaContribuinte] [int] IDENTITY(1,1) NOT NULL,
	[cdContribuinte] [int] NOT NULL,
	[cdUsuario] [int] NOT NULL,
	[dtRegistro] [datetime] NOT NULL,
	[dcOcorrencia] [varchar](1000) COLLATE Latin1_General_CI_AI NOT NULL,
	[inHabilitado] [tinyint] NOT NULL,
	[cdUsuarioAlteracao] [int] NULL,
	[dtAlteracao] [datetime] NULL,
 CONSTRAINT [pkOCORRENCIACONTRIBUINTE] PRIMARY KEY CLUSTERED 
(
	[cdOcorrenciaContribuinte] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[df0]', @objname=N'[dbo].[OCORRENCIACONTRIBUINTE].[inHabilitado]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[df0]', @objname=N'[dbo].[OCORRENCIACONTRIBUINTE].[inHabilitado]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[MESSEMMOVIMENTO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MESSEMMOVIMENTO](
	[cdMesSemMovimento] [int] IDENTITY(1,1) NOT NULL,
	[nrExercicio] [smallint] NOT NULL,
	[nrMes] [smallint] NOT NULL,
	[dcMotivo] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrTipoDeclaracao] [smallint] NOT NULL,
	[cdPessoa] [int] NOT NULL,
 CONSTRAINT [pkMESSEMMOVIMENTO] PRIMARY KEY CLUSTERED 
(
	[cdMesSemMovimento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixMesSemMovimento01] ON [dbo].[MESSEMMOVIMENTO] 
(
	[cdPessoa] ASC,
	[nrExercicio] ASC,
	[nrMes] ASC,
	[nrTipoDeclaracao] ASC
)
INCLUDE ( [dcMotivo]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTres]', @objname=N'[dbo].[MESSEMMOVIMENTO].[nrTipoDeclaracao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTres]', @objname=N'[dbo].[MESSEMMOVIMENTO].[nrTipoDeclaracao]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[PAGAMENTO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PAGAMENTO](
	[inCancelado] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[dtPagamento] [datetime] NULL,
	[vlPagamento] [decimal](18, 2) NULL,
	[inPago] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdPagamento] [int] NOT NULL,
	[dtVencimento] [datetime] NULL,
	[nrExercicio] [smallint] NOT NULL,
	[nrMes] [smallint] NOT NULL,
	[cdTipoGuia] [smallint] NOT NULL,
	[vlAliquota] [decimal](18, 2) NULL,
	[vlDesconto] [decimal](18, 2) NULL,
	[vlFinal] [decimal](18, 2) NOT NULL,
	[vlISS] [decimal](18, 2) NOT NULL,
	[vlJuros] [decimal](18, 2) NULL,
	[vlMulta] [decimal](18, 2) NULL,
	[vlCorrecaoMonetaria] [decimal](18, 2) NULL,
	[vlReceita] [decimal](18, 2) NULL,
	[dcMotivoCancelamento] [varchar](250) COLLATE Latin1_General_CI_AI NULL,
	[cdAtividade] [int] NULL,
	[cdEndereco] [int] NOT NULL,
	[cdPessoa] [int] NOT NULL,
	[cdUsuarioCancelamento] [int] NULL,
	[dtCancelamento] [datetime] NULL,
	[vlVinculado] [decimal](18, 2) NULL,
	[nrCodigoBaixa] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[nrCodigoDocumento] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[nrNossoNumero] [decimal](17, 0) NOT NULL,
	[dcObservacao] [varchar](1000) COLLATE Latin1_General_CI_AI NULL,
	[vlTotal] [decimal](18, 2) NULL,
	[vlOutrasDeducoes] [decimal](18, 2) NULL,
	[cdBanco] [int] NOT NULL,
	[inStatus] [int] NOT NULL,
	[cdTomador] [int] NULL,
	[inSubstituicaoTributaria] [char](1) COLLATE Latin1_General_CI_AI NULL,
	[inPrestadorSimplesNacional] [char](1) COLLATE Latin1_General_CI_AI NULL,
	[inSacadoTomador] [char](1) COLLATE Latin1_General_CI_AI NULL,
	[cdEnderecoTomador] [int] NULL,
 CONSTRAINT [pkPAGAMENTO] PRIMARY KEY CLUSTERED 
(
	[cdPagamento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixPagamento01] ON [dbo].[PAGAMENTO] 
(
	[nrNossoNumero] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixPagamento03] ON [dbo].[PAGAMENTO] 
(
	[cdPessoa] ASC
)
INCLUDE ( [nrExercicio],
[dtPagamento],
[vlPagamento],
[cdPagamento],
[nrMes],
[cdTipoGuia],
[vlFinal],
[vlJuros],
[vlCorrecaoMonetaria],
[vlMulta],
[inPago]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixPagamento04] ON [dbo].[PAGAMENTO] 
(
	[nrExercicio] ASC,
	[nrMes] ASC,
	[cdTipoGuia] ASC
)
INCLUDE ( [vlPagamento],
[inPago]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PAGAMENTO].[inCancelado]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PAGAMENTO].[inPago]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PAGAMENTO].[inPago]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[df0]', @objname=N'[dbo].[PAGAMENTO].[inStatus]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PAGAMENTO].[inSubstituicaoTributaria]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PAGAMENTO].[inPrestadorSimplesNacional]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PAGAMENTO].[inSacadoTomador]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PAGAMENTO].[inCancelado]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PAGAMENTO].[inPago]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PAGAMENTO].[inPago]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[df0]', @objname=N'[dbo].[PAGAMENTO].[inStatus]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PAGAMENTO].[inSubstituicaoTributaria]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PAGAMENTO].[inPrestadorSimplesNacional]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PAGAMENTO].[inSacadoTomador]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[MONPESSOANAOPAGAMENTO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MONPESSOANAOPAGAMENTO](
	[cdMonPessoaNaoPagamento] [int] IDENTITY(1,1) NOT NULL,
	[cdInscricaoMunicipal] [int] NOT NULL,
	[dtExecucao] [datetime] NOT NULL,
	[inNotificacaoEmail] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkMONPESSOANAOPAGAMENTO] PRIMARY KEY CLUSTERED 
(
	[cdMonPessoaNaoPagamento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixMonPessoaNaoPagamento01] ON [dbo].[MONPESSOANAOPAGAMENTO] 
(
	[cdInscricaoMunicipal] ASC,
	[dtExecucao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[MONPESSOANAOPAGAMENTO].[inNotificacaoEmail]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[MONPESSOANAOPAGAMENTO].[inNotificacaoEmail]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[MONPESSOANAOPAGAMENTO].[inNotificacaoEmail]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[MONPESSOANAOPAGAMENTO].[inNotificacaoEmail]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[IMPORTACAOLANCAMENTOITENS]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IMPORTACAOLANCAMENTOITENS](
	[cdImportacaoLancamentoItens] [int] IDENTITY(1,1) NOT NULL,
	[cdImportacaoLancamento] [int] NOT NULL,
	[dcXmlPacote] [varchar](max) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrTipoDocumento] [smallint] NOT NULL,
	[dcTipoLancamento] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrSituacao] [smallint] NOT NULL,
	[dtProcessamento] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[cdImportacaoLancamentoItens] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixImportacaoLancamentoItens01] ON [dbo].[IMPORTACAOLANCAMENTOITENS] 
(
	[cdImportacaoLancamento] ASC,
	[nrSituacao] ASC
)
INCLUDE ( [cdImportacaoLancamentoItens]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixImportacaoLancamentoItens02] ON [dbo].[IMPORTACAOLANCAMENTOITENS] 
(
	[cdImportacaoLancamentoItens] ASC
)
INCLUDE ( [cdImportacaoLancamento],
[nrTipoDocumento],
[nrSituacao]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatroCinco]', @objname=N'[dbo].[IMPORTACAOLANCAMENTOITENS].[nrTipoDocumento]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroaSeis]', @objname=N'[dbo].[IMPORTACAOLANCAMENTOITENS].[nrSituacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatroCinco]', @objname=N'[dbo].[IMPORTACAOLANCAMENTOITENS].[nrTipoDocumento]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroaSeis]', @objname=N'[dbo].[IMPORTACAOLANCAMENTOITENS].[nrSituacao]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[AUTORIZACAODOCUMENTORECIBO]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AUTORIZACAODOCUMENTORECIBO](
	[cdAutorizacaoDocumentoRecibo] [int] IDENTITY(1,1) NOT NULL,
	[cdInscricaoMunicipal] [int] NOT NULL,
	[cdUsuarioInclusao] [int] NOT NULL,
	[dtInclusao] [smalldatetime] NOT NULL,
	[cdUsuarioExclusao] [int] NULL,
	[dtExclusao] [smalldatetime] NULL,
 CONSTRAINT [pkAUTORIZACAODOCUMENTORECIBO] PRIMARY KEY CLUSTERED 
(
	[cdAutorizacaoDocumentoRecibo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AUTORIZACAOAIDF]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AUTORIZACAOAIDF](
	[dtCancelamento] [datetime] NULL,
	[dtAutorizacao] [datetime] NULL,
	[dtSolicitacao] [datetime] NOT NULL,
	[dtValidade] [datetime] NULL,
	[inContinuo] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrAutorizacao] [int] NULL,
	[nrBlocos] [int] NOT NULL,
	[cdPessoaGrafica] [int] NOT NULL,
	[nrFinal] [numeric](19, 0) NOT NULL,
	[nrInicial] [numeric](19, 0) NOT NULL,
	[nrVias] [int] NOT NULL,
	[qtAutorizada] [int] NULL,
	[qtSolicitacao] [int] NOT NULL,
	[cdSerieAutorizada] [int] NULL,
	[cdSerieSolicitacao] [int] NOT NULL,
	[nrSituacao] [smallint] NOT NULL,
	[cdPessoa] [int] NOT NULL,
	[dcObservacao] [varchar](384) COLLATE Latin1_General_CI_AI NULL,
	[cdPessoaFiscal] [int] NULL,
	[cdPessoaCancelamento] [int] NULL,
	[cdAutorizacaoAidf] [int] IDENTITY(1,1) NOT NULL,
	[cdEndereco] [int] NOT NULL,
 CONSTRAINT [pkAUTORIZACAOAIDF] PRIMARY KEY CLUSTERED 
(
	[cdAutorizacaoAidf] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatro]', @objname=N'[dbo].[AUTORIZACAOAIDF].[nrSituacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatro]', @objname=N'[dbo].[AUTORIZACAOAIDF].[nrSituacao]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[VINCULOCONTADORCONTRIBUINTE]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VINCULOCONTADORCONTRIBUINTE](
	[dtInicio] [datetime] NOT NULL,
	[dtFim] [datetime] NULL,
	[cdPessoa] [int] NOT NULL,
	[cdPessoaContador] [int] NOT NULL,
	[cdVinculoContadorContribuinte] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [pkVINCULOCONTADORCONTRIBUINTE] PRIMARY KEY CLUSTERED 
(
	[cdVinculoContadorContribuinte] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SOCIOPESSOAJURIDICAITEM]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SOCIOPESSOAJURIDICAITEM](
	[cdSocioPessoaJuridicaItem] [int] IDENTITY(1,1) NOT NULL,
	[cdInscricaoMunicipal] [int] NOT NULL,
	[dcCpf] [varchar](20) COLLATE Latin1_General_CI_AI NULL,
	[dtInicio] [smalldatetime] NOT NULL,
	[dtFim] [smalldatetime] NULL,
	[inTributavel] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkSOCIOPESSOAJURIDICAITEM] PRIMARY KEY CLUSTERED 
(
	[cdSocioPessoaJuridicaItem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SOCIOPESSOAJURIDICA]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SOCIOPESSOAJURIDICA](
	[cdSocioPessoaJuridica] [int] IDENTITY(1,1) NOT NULL,
	[cdInscricaoMunicipal] [int] NOT NULL,
	[nrSocios] [int] NOT NULL,
	[dtInicio] [datetime] NOT NULL,
	[dtFim] [datetime] NULL,
 CONSTRAINT [pkSOCIOPESSOAJURIDICA] PRIMARY KEY CLUSTERED 
(
	[cdSocioPessoaJuridica] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[REQUISICAOAUTORIZACAONFE]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[REQUISICAOAUTORIZACAONFE](
	[cdRequisicaoAutorizacaoNfe] [int] IDENTITY(1,1) NOT NULL,
	[dtEnvio] [datetime] NOT NULL,
	[nrSituacao] [smallint] NOT NULL,
	[cdPessoaSolicitante] [int] NOT NULL,
	[cdEnderecoSolicitante] [int] NOT NULL,
	[dcEmail] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[dcMotivoCancelamento] [varchar](500) COLLATE Latin1_General_CI_AI NULL,
	[dtSituacao] [datetime] NOT NULL,
	[cdUsuarioSituacao] [int] NOT NULL,
	[cdUsuarioSolicitante] [int] NOT NULL,
	[cdUsuarioPrincipal] [int] NULL,
	[dcMotivoAprovacao] [varchar](500) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkREQUISICAOAUTORIZACAONFE] PRIMARY KEY CLUSTERED 
(
	[cdRequisicaoAutorizacaoNfe] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixRequisicaoAutorizacaoNfe01] ON [dbo].[REQUISICAOAUTORIZACAONFE] 
(
	[cdUsuarioSituacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatroCinco]', @objname=N'[dbo].[REQUISICAOAUTORIZACAONFE].[nrSituacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatroCinco]', @objname=N'[dbo].[REQUISICAOAUTORIZACAONFE].[nrSituacao]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[REGIMEESTIMADO]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REGIMEESTIMADO](
	[cdRegimeEstimado] [int] IDENTITY(1,1) NOT NULL,
	[dtExclusao] [datetime] NULL,
	[dtInclusao] [datetime] NOT NULL,
	[nrValor] [decimal](18, 2) NOT NULL,
	[cdPessoaAtividade] [int] NOT NULL,
 CONSTRAINT [pkREGIMEESTIMADO] PRIMARY KEY CLUSTERED 
(
	[cdRegimeEstimado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ixRegimeEstimado01] ON [dbo].[REGIMEESTIMADO] 
(
	[cdPessoaAtividade] ASC
)
INCLUDE ( [dtExclusao],
[dtInclusao],
[nrValor]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[RPSTRANSMISSAOITEM]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RPSTRANSMISSAOITEM](
	[cdRPSTransmissaoItem] [int] IDENTITY(1,1) NOT NULL,
	[cdRPSTransmissao] [int] NOT NULL,
	[nrSequencia] [int] NULL,
	[nrRecibo] [decimal](38, 0) NULL,
	[dtRecibo] [datetime] NULL,
	[inSituacaoRecibo] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[vlRecibo] [decimal](38, 2) NULL,
	[dcCodigoAtividade] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[inSubstTrib] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[dcCPFTomador] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[dcCNPJTomador] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[dcNomeTomador] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[dcTipoLogradouro] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[dcLogradouro] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[nrNumeroLogradouro] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[dcCompLogradouro] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[dcBairroLogradouro] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[dcCidadeLogradouro] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[dcUFLogradouro] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[dcCEPLogradouro] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[dcEmailTomador] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[dcAutenticadorRecibo] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[dcServico] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[vlDeducao] [decimal](38, 2) NULL,
	[vlAliquotaEspecial] [decimal](38, 2) NULL,
	[dcNomeTomEstrang] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[dcEndTomaEstrang] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[dcCidadeTomEstrang] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[dcPaisTomEstrang] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
	[nrNotaGerada] [decimal](38, 0) NULL,
	[inTransfImagem] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkRPSTRANSMISSAOITEM] PRIMARY KEY CLUSTERED 
(
	[cdRPSTransmissaoItem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixRpsTransmissaoItem01] ON [dbo].[RPSTRANSMISSAOITEM] 
(
	[cdRPSTransmissao] ASC
)
INCLUDE ( [dtRecibo],
[inSituacaoRecibo],
[vlRecibo],
[inSubstTrib],
[dcAutenticadorRecibo],
[dcServico],
[vlDeducao],
[nrRecibo]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[RPSTRANSMISSAOITEM].[inTransfImagem]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[RPSTRANSMISSAOITEM].[inTransfImagem]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[PESSOAATIITEMATI]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PESSOAATIITEMATI](
	[cdPessoaAtiItemAti] [int] IDENTITY(1,1) NOT NULL,
	[cdItemAtividade] [int] NOT NULL,
	[cdPessoaAtividade] [int] NOT NULL,
	[qtItem] [int] NOT NULL,
	[dtInclusao] [datetime] NOT NULL,
	[dtExclusao] [datetime] NULL,
 CONSTRAINT [pkPESSOAATIITEMATI] PRIMARY KEY CLUSTERED 
(
	[cdPessoaAtiItemAti] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ixPessoaAtiItemAti01] ON [dbo].[PESSOAATIITEMATI] 
(
	[cdPessoaAtividade] ASC
)
INCLUDE ( [cdItemAtividade],
[qtItem],
[dtInclusao],
[dtExclusao]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixPessoaAtiItemAti02] ON [dbo].[PESSOAATIITEMATI] 
(
	[cdItemAtividade] ASC
)
INCLUDE ( [cdPessoaAtividade],
[qtItem],
[dtInclusao],
[dtExclusao]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[PERIODOSEMPAGCONTRIBUINTE]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERIODOSEMPAGCONTRIBUINTE](
	[cdPeriodoSemPagContribuinte] [int] IDENTITY(1,1) NOT NULL,
	[cdMonPessoaNaoPagamento] [int] NOT NULL,
	[nrMes] [smallint] NOT NULL,
	[nrExercicio] [smallint] NOT NULL,
 CONSTRAINT [pkPERIODOSEMPAGCONTRIBUINTE] PRIMARY KEY CLUSTERED 
(
	[cdPeriodoSemPagContribuinte] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixPeriodoSemPagContribuinte01] ON [dbo].[PERIODOSEMPAGCONTRIBUINTE] 
(
	[cdMonPessoaNaoPagamento] ASC,
	[nrMes] ASC,
	[nrExercicio] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[PAGAMENTOITEMATIVIDADE]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PAGAMENTOITEMATIVIDADE](
	[cdPagamentoItemAtividade] [int] IDENTITY(1,1) NOT NULL,
	[inCancelado] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrQuantidade] [int] NOT NULL,
	[nrQuantidadeUFM] [int] NOT NULL,
	[vlISS] [decimal](18, 2) NOT NULL,
	[vlIndice] [decimal](18, 4) NOT NULL,
	[cdPagamento] [int] NOT NULL,
	[cdItemAtividade] [int] NOT NULL,
 CONSTRAINT [pkPAGAMENTOITEMATIVIDADE] PRIMARY KEY CLUSTERED 
(
	[cdPagamentoItemAtividade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PAGAMENTOITEMATIVIDADE].[inCancelado]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PAGAMENTOITEMATIVIDADE].[inCancelado]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[RPSRECIBO]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RPSRECIBO](
	[cdRpsTransmissaoItem] [int] NOT NULL,
	[cdPessoaTomador] [int] NULL,
	[nrTipoPessoa] [tinyint] NULL,
	[cdSerieNotaFiscal] [int] NOT NULL,
	[cdAtividade] [int] NOT NULL,
	[cdNotaFiscal] [int] NULL,
	[vlAliquota] [decimal](18, 2) NULL,
	[vlIss] [decimal](18, 2) NULL,
	[bbImagemNotaFiscal] [varbinary](max) NULL,
	[dcAutenticador] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[cdRequisicaoAutorizacaoNfe] [int] NULL,
	[dcXmlNotaFiscal] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkRPSRECIBO] PRIMARY KEY NONCLUSTERED 
(
	[cdRpsTransmissaoItem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 50) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixRpsRecibo01] ON [dbo].[RPSRECIBO] 
(
	[cdNotaFiscal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[REQUISICAOSERIENOTAFISCAL]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[REQUISICAOSERIENOTAFISCAL](
	[cdRequisicaoSerieNotaFiscal] [int] IDENTITY(1,1) NOT NULL,
	[cdRequisicaoAutorizacaoNfe] [int] NOT NULL,
	[cdSerieNotaFiscal] [int] NOT NULL,
	[qtAutorizada] [int] NULL,
	[inBloqueio] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrPrimeiraNota] [numeric](19, 0) NOT NULL,
	[nrUltimaNotaEmitida] [numeric](19, 0) NOT NULL,
 CONSTRAINT [pkREQUISICAOSERIENOTAFISCAL] PRIMARY KEY CLUSTERED 
(
	[cdRequisicaoSerieNotaFiscal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixRequisicaoSerieNotaFiscal01] ON [dbo].[REQUISICAOSERIENOTAFISCAL] 
(
	[cdRequisicaoAutorizacaoNfe] ASC
)
INCLUDE ( [cdRequisicaoSerieNotaFiscal],
[nrUltimaNotaEmitida],
[cdSerieNotaFiscal],
[qtAutorizada],
[inBloqueio],
[nrPrimeiraNota]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[REQUISICAOSERIENOTAFISCAL].[inBloqueio]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[REQUISICAOSERIENOTAFISCAL].[nrUltimaNotaEmitida]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[REQUISICAOSERIENOTAFISCAL].[inBloqueio]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[REQUISICAOSERIENOTAFISCAL].[nrUltimaNotaEmitida]' , @futureonly='futureonly'
GO


END
GO
/****** Object:  Table [dbo].[RPSINCONSISTENCIA]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RPSINCONSISTENCIA](
	[cdRPSInconsistencia] [decimal](18, 0) IDENTITY(1,1) NOT NULL,
	[cdRPSMensagemInconsistencia] [int] NOT NULL,
	[cdRPSTransmissaoItem] [int] NULL,
	[cdRpsTransmissao] [int] NULL,
 CONSTRAINT [pkRPSINCONSISTENCIA] PRIMARY KEY CLUSTERED 
(
	[cdRPSInconsistencia] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ixRpsInconsistencia01] ON [dbo].[RPSINCONSISTENCIA] 
(
	[cdRpsTransmissao] ASC
)
INCLUDE ( [cdRPSMensagemInconsistencia],
[cdRPSTransmissaoItem]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO

/****** Object:  Table [dbo].[CHAVEAUTENTICACAOREQUISICAO]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CHAVEAUTENTICACAOREQUISICAO](
	[cdChaveAutenticacaoAutorizacao] [int] IDENTITY(1,1) NOT NULL,
	[cdRequisicaoAutorizacaoNfe] [int] NOT NULL,
	[cdUsuarioInclusao] [int] NOT NULL,
	[dtInclusao] [smalldatetime] NOT NULL,
	[dcChaveAutenticacao] [varchar](100) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdUsuarioDesativacao] [int] NULL,
	[dtDesativacao] [smalldatetime] NULL,
	[inDesativada] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkCHAVEAUTENTICACAOREQUISICAO] PRIMARY KEY CLUSTERED 
(
	[cdChaveAutenticacaoAutorizacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixCHAVEAUTENTICACAOREQUISICAO01] ON [dbo].[CHAVEAUTENTICACAOREQUISICAO] 
(
	[dcChaveAutenticacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CDCPAGAMENTO]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CDCPAGAMENTO](
	[cdCdcPagamento] [int] IDENTITY(1,1) NOT NULL,
	[nrCdcPagamento] [varchar](16) COLLATE Latin1_General_CI_AI NULL,
	[dcEndereco] [varchar](500) COLLATE Latin1_General_CI_AI NULL,
	[cdPagamento] [int] NOT NULL,
	[nrTipoObra] [smallint] NOT NULL,
 CONSTRAINT [pkCDCPAGAMENTO] PRIMARY KEY CLUSTERED 
(
	[cdCdcPagamento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[CDCPAGAMENTO].[nrTipoObra]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDois]', @objname=N'[dbo].[CDCPAGAMENTO].[nrTipoObra]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[CONTRATOESCOLAR]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CONTRATOESCOLAR](
	[cdContratoEscolar] [int] IDENTITY(1,1) NOT NULL,
	[dtContrato] [datetime] NOT NULL,
	[dtCancelamento] [datetime] NULL,
	[dtDeclaracao] [datetime] NOT NULL,
	[nrExercicio] [smallint] NOT NULL,
	[nrMes] [smallint] NOT NULL,
	[dcMotivoCancelamento] [varchar](255) COLLATE Latin1_General_CI_AI NULL,
	[nrContrato] [int] NULL,
	[inTeste] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[vlReceita] [decimal](18, 2) NOT NULL,
	[nrGrauEnsino] [smallint] NOT NULL,
	[cdPessoa] [int] NOT NULL,
	[vlPagamento] [decimal](18, 2) NOT NULL,
	[cdImportacaoLancamentoItens] [int] NULL,
	[tpInconsistencia] [smallint] NOT NULL,
 CONSTRAINT [pkCONTRATOESCOLAR] PRIMARY KEY CLUSTERED 
(
	[cdContratoEscolar] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONTRATOESCOLAR].[inTeste]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatro]', @objname=N'[dbo].[CONTRATOESCOLAR].[nrGrauEnsino]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[CONTRATOESCOLAR].[tpInconsistencia]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[CONTRATOESCOLAR].[inTeste]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTresQuatro]', @objname=N'[dbo].[CONTRATOESCOLAR].[nrGrauEnsino]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[CONTRATOESCOLAR].[tpInconsistencia]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[DOCUMENTO]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DOCUMENTO](
	[cdDocumento] [int] IDENTITY(1,1) NOT NULL,
	[nrDocumento] [numeric](19, 0) NOT NULL,
	[vlIss] [decimal](18, 2) NOT NULL,
	[vlReceita] [decimal](18, 2) NOT NULL,
	[nrMes] [smallint] NOT NULL,
	[dtEmissao] [datetime] NOT NULL,
	[vlAliquota] [decimal](18, 2) NOT NULL,
	[nrExercicio] [smallint] NOT NULL,
	[inGeracaoPagamento] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[inSubstituicaoTributaria] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdAtividade] [int] NULL,
	[cdItemAtividade] [int] NULL,
	[cdPessoaPrestador] [int] NULL,
	[nrTipoDeclaracao] [smallint] NOT NULL,
	[cdPessoaTomador] [int] NULL,
	[cdSerieNotaFiscal] [int] NULL,
	[dcSerieNotaFiscal] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[cdTipoDocumento] [int] NOT NULL,
	[inTeste] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[dtDeclaracao] [datetime] NULL,
	[cdImportacaoLancamentoItens] [int] NULL,
	[tpInconsistencia] [smallint] NOT NULL,
	[inSituacaoInconsistencia] [char](1) COLLATE Latin1_General_CI_AI NULL,
	[inStatus] [int] NOT NULL,
 CONSTRAINT [pkDOCUMENTO] PRIMARY KEY CLUSTERED 
(
	[cdDocumento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixDocumento01] ON [dbo].[DOCUMENTO] 
(
	[nrDocumento] ASC,
	[cdPessoaPrestador] ASC,
	[cdPessoaTomador] ASC,
	[cdDocumento] ASC
)
INCLUDE ( [nrTipoDeclaracao]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixDocumento02] ON [dbo].[DOCUMENTO] 
(
	[nrExercicio] ASC,
	[nrMes] ASC,
	[nrTipoDeclaracao] ASC,
	[inSituacaoInconsistencia] ASC,
	[cdPessoaPrestador] ASC,
	[cdPessoaTomador] ASC,
	[inTeste] ASC
)
INCLUDE ( [cdDocumento],
[vlIss],
[vlReceita],
[dtEmissao],
[inSubstituicaoTributaria],
[cdTipoDocumento],
[nrDocumento],
[cdAtividade]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixDocumento03] ON [dbo].[DOCUMENTO] 
(
	[cdPessoaPrestador] ASC,
	[nrTipoDeclaracao] ASC,
	[cdPessoaTomador] ASC,
	[inTeste] ASC,
	[cdDocumento] ASC,
	[cdSerieNotaFiscal] ASC,
	[cdImportacaoLancamentoItens] ASC
)
INCLUDE ( [dcSerieNotaFiscal],
[dtEmissao],
[vlReceita],
[vlIss],
[nrMes],
[vlAliquota],
[nrExercicio],
[inGeracaoPagamento],
[inSubstituicaoTributaria],
[cdAtividade],
[cdItemAtividade],
[cdTipoDocumento],
[nrDocumento]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixDocumento04] ON [dbo].[DOCUMENTO] 
(
	[cdPessoaTomador] ASC,
	[cdPessoaPrestador] ASC,
	[inTeste] ASC,
	[nrTipoDeclaracao] ASC,
	[cdDocumento] ASC,
	[cdSerieNotaFiscal] ASC,
	[cdImportacaoLancamentoItens] ASC
)
INCLUDE ( [dcSerieNotaFiscal],
[nrDocumento],
[vlReceita],
[dtEmissao]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixDocumento05] ON [dbo].[DOCUMENTO] 
(
	[nrMes] ASC,
	[nrExercicio] ASC,
	[cdPessoaPrestador] ASC
)
INCLUDE ( [vlIss],
[vlReceita],
[inSubstituicaoTributaria],
[nrTipoDeclaracao]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTres]', @objname=N'[dbo].[DOCUMENTO].[nrTipoDeclaracao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[DOCUMENTO].[inTeste]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[DOCUMENTO].[inTeste]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[DOCUMENTO].[tpInconsistencia]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[df0]', @objname=N'[dbo].[DOCUMENTO].[inStatus]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTres]', @objname=N'[dbo].[DOCUMENTO].[nrTipoDeclaracao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[DOCUMENTO].[inTeste]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[DOCUMENTO].[inTeste]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[DOCUMENTO].[tpInconsistencia]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[df0]', @objname=N'[dbo].[DOCUMENTO].[inStatus]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[GUIAREEMBOLSOPAGAMENTO]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GUIAREEMBOLSOPAGAMENTO](
	[cdGuiaReembolso] [int] NOT NULL,
	[cdPagamento] [int] NOT NULL,
 CONSTRAINT [pkGUIAREEMBOLSOPAGAMENTO] PRIMARY KEY CLUSTERED 
(
	[cdGuiaReembolso] ASC,
	[cdPagamento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DEDUCAOCONSTRUCAOCIVIL]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[DEDUCAOCONSTRUCAOCIVIL](
	[cdDeducao] [int] IDENTITY(1,1) NOT NULL,
	[cdPagamento] [int] NOT NULL,
	[dcCnpj] [char](14) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrNotaFiscal] [decimal](19, 0) NOT NULL,
	[vlDeducao] [decimal](18, 2) NOT NULL,
 CONSTRAINT [pkDEDUCAOCONSTRUCAOCIVIL] PRIMARY KEY CLUSTERED 
(
	[cdDeducao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LANCAMENTOBANCARIO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LANCAMENTOBANCARIO](
	[cdLancamentoBancario] [int] IDENTITY(1,1) NOT NULL,
	[dcContaBanco] [varchar](20) COLLATE Latin1_General_CI_AI NOT NULL,
	[dtDeclaracao] [datetime] NOT NULL,
	[nrExercicio] [smallint] NOT NULL,
	[nrMes] [smallint] NOT NULL,
	[vlReceitaBase] [decimal](18, 2) NOT NULL,
	[vlAliquota] [decimal](18, 2) NOT NULL,
	[vlImposto] [decimal](18, 2) NOT NULL,
	[inTeste] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdAtividade] [int] NOT NULL,
	[cdPessoa] [int] NOT NULL,
	[cdCodigoCosif] [int] NOT NULL,
	[cdImportacaoLancamentoItens] [int] NULL,
 CONSTRAINT [pkLANCAMENTOBANCARIO] PRIMARY KEY CLUSTERED 
(
	[cdLancamentoBancario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixLancamentoBancario01] ON [dbo].[LANCAMENTOBANCARIO] 
(
	[nrExercicio] ASC,
	[nrMes] ASC,
	[cdPessoa] ASC
)
INCLUDE ( [vlImposto],
[inTeste]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[LANCAMENTOBANCARIO].[inTeste]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[LANCAMENTOBANCARIO].[inTeste]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[ITEMPAGAMENTO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ITEMPAGAMENTO](
	[cdItemPagamento] [int] IDENTITY(1,1) NOT NULL,
	[cdPagamento] [int] NOT NULL,
	[dtProcessamento] [smalldatetime] NOT NULL,
	[nrIdConvivencia] [int] NOT NULL,
	[nrSequenciaArquivo] [int] NOT NULL,
	[vlPagamento] [decimal](18, 2) NOT NULL,
	[dtPagamento] [smalldatetime] NOT NULL,
 CONSTRAINT [pkITEMPAGAMENTO] PRIMARY KEY CLUSTERED 
(
	[cdItemPagamento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[INCONSISTENCIAITENIMPORTACAO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[INCONSISTENCIAITENIMPORTACAO](
	[cdInconsistenciaItenImportacao] [int] IDENTITY(1,1) NOT NULL,
	[dtGeracao] [datetime] NOT NULL,
	[dcInconsistencia] [varchar](500) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrExercicio] [smallint] NULL,
	[nrMes] [smallint] NULL,
	[cdRegistroOffline] [int] NULL,
	[nrLancamento] [varchar](19) COLLATE Latin1_General_CI_AI NULL,
	[nrSituacao] [smallint] NOT NULL,
	[dcSerieNotaFiscal] [varchar](10) COLLATE Latin1_General_CI_AI NULL,
	[cdImportacaoLancamentoItens] [int] NOT NULL,
 CONSTRAINT [pkINCONSISTENCIAITENIMPORTACAO] PRIMARY KEY CLUSTERED 
(
	[cdInconsistenciaItenImportacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixInconsistenciaItenImportacao01] ON [dbo].[INCONSISTENCIAITENIMPORTACAO] 
(
	[cdImportacaoLancamentoItens] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixInconsistenciaItenImportacao02] ON [dbo].[INCONSISTENCIAITENIMPORTACAO] 
(
	[nrSituacao] ASC
)
INCLUDE ( [cdInconsistenciaItenImportacao],
[dtGeracao],
[dcInconsistencia],
[nrExercicio],
[nrMes],
[cdRegistroOffline],
[nrLancamento],
[dcSerieNotaFiscal],
[cdImportacaoLancamentoItens]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoze]', @objname=N'[dbo].[INCONSISTENCIAITENIMPORTACAO].[nrMes]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTres]', @objname=N'[dbo].[INCONSISTENCIAITENIMPORTACAO].[nrSituacao]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoze]', @objname=N'[dbo].[INCONSISTENCIAITENIMPORTACAO].[nrMes]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkUmDoisTres]', @objname=N'[dbo].[INCONSISTENCIAITENIMPORTACAO].[nrSituacao]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[NOTAFISCAL]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NOTAFISCAL](
	[cdNotaFiscal] [int] IDENTITY(1,1) NOT NULL,
	[dtEmissao] [datetime] NOT NULL,
	[dtCancelamento] [datetime] NULL,
	[cdPessoaPrestador] [int] NOT NULL,
	[cdPessoaTomador] [int] NULL,
	[dcInfoAdicional] [varchar](3000) COLLATE Latin1_General_CI_AI NULL,
	[vlNotaFiscal] [decimal](18, 2) NOT NULL,
	[cdUsuarioContribuinte] [int] NOT NULL,
	[nrNotaFiscal] [decimal](19, 0) NOT NULL,
	[cdSerieNotaFiscal] [int] NOT NULL,
	[dcAutenticador] [varchar](15) COLLATE Latin1_General_CI_AI NOT NULL,
	[inIntegradoIss] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcMotivoCancelamento] [varchar](500) COLLATE Latin1_General_CI_AI NULL,
	[cdUsuarioCancelamento] [int] NULL,
	[dcEmailTomador] [varchar](100) COLLATE Latin1_General_CI_AI NULL,
	[nrRecibo] [decimal](19, 0) NULL,
	[dcAutenticadorRecibo] [varchar](15) COLLATE Latin1_General_CI_AI NULL,
	[cdImportacaoLancamentoItens] [int] NULL,
	[dtRecibo] [datetime] NULL,
	[inGeraCredito] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[cdRpsTransmissaoItem] [int] NULL,
 CONSTRAINT [pkNOTAFISCAL] PRIMARY KEY CLUSTERED 
(
	[cdNotaFiscal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixNotaFiscal01] ON [dbo].[NOTAFISCAL] 
(
	[nrRecibo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixNotaFiscal02] ON [dbo].[NOTAFISCAL] 
(
	[cdRpsTransmissaoItem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixNotaFiscal03] ON [dbo].[NOTAFISCAL] 
(
	[nrNotaFiscal] ASC,
	[cdSerieNotaFiscal] ASC,
	[cdPessoaPrestador] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 70) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixNotaFiscal04] ON [dbo].[NOTAFISCAL] 
(
	[dtCancelamento] ASC,
	[cdPessoaTomador] ASC
)
INCLUDE ( [cdNotaFiscal],
[dtEmissao],
[cdPessoaPrestador],
[vlNotaFiscal],
[nrNotaFiscal],
[cdSerieNotaFiscal],
[nrRecibo],
[dtRecibo]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixNotaFiscal06] ON [dbo].[NOTAFISCAL] 
(
	[cdPessoaPrestador] ASC,
	[cdNotaFiscal] ASC
)
INCLUDE ( [dtEmissao],
[dtCancelamento],
[cdPessoaTomador],
[dcInfoAdicional],
[vlNotaFiscal],
[cdUsuarioContribuinte],
[nrNotaFiscal],
[cdSerieNotaFiscal],
[dcAutenticador],
[inIntegradoIss],
[dcMotivoCancelamento],
[cdUsuarioCancelamento],
[dcEmailTomador],
[nrRecibo],
[dcAutenticadorRecibo],
[dtRecibo]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[NOTAFISCAL].[inGeraCredito]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[NOTAFISCAL].[inGeraCredito]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[PAGAMENTOAGRUCONTRATOESCOLAR]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PAGAMENTOAGRUCONTRATOESCOLAR](
	[cdPagamentoAgruContratoEscolar] [int] IDENTITY(1,1) NOT NULL,
	[cdPagamento] [int] NOT NULL,
	[cdAgrupamentoContratoEscolar] [int] NOT NULL,
	[inCancelado] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkPAGAMENTOAGRUCONTRATOESCOLAR] PRIMARY KEY CLUSTERED 
(
	[cdPagamentoAgruContratoEscolar] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PAGAMENTOLANCBANCARIO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PAGAMENTOLANCBANCARIO](
	[cdPagamentoLancBancario] [int] IDENTITY(1,1) NOT NULL,
	[cdPagamento] [int] NOT NULL,
	[cdLancamentoBancario] [int] NOT NULL,
	[inCancelado] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkPAGAMENTOLANCBANCARIO] PRIMARY KEY CLUSTERED 
(
	[cdPagamentoLancBancario] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[NOTAFISCALITEM]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NOTAFISCALITEM](
	[cdNotaFiscalIem] [int] IDENTITY(1,1) NOT NULL,
	[cdNotaFiscal] [int] NOT NULL,
	[cdAtividade] [int] NOT NULL,
	[vlAliquota] [decimal](18, 2) NOT NULL,
	[vlReceita] [decimal](18, 2) NOT NULL,
	[vlIss] [decimal](18, 2) NOT NULL,
	[inIssTomador] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
	[vlDeducao] [decimal](18, 2) NOT NULL,
 CONSTRAINT [pkNOTAFISCALITEM] PRIMARY KEY CLUSTERED 
(
	[cdNotaFiscalIem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixNotaFiscalItem01] ON [dbo].[NOTAFISCALITEM] 
(
	[cdNotaFiscal] ASC
)
INCLUDE ( [cdAtividade],
[vlAliquota],
[vlReceita],
[vlIss],
[inIssTomador],
[vlDeducao]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = OFF, FILLFACTOR = 100) ON [INDEXES]
GO
/****** Object:  Table [dbo].[NOTAFISCALIMAGEM]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[NOTAFISCALIMAGEM](
	[cdNotaFiscalImagem] [int] IDENTITY(1,1) NOT NULL,
	[cdNotaFiscal] [int] NOT NULL,
	[bbImagemNota] [varbinary](max) NULL,
	[dcXmlNota] [varchar](max) COLLATE Latin1_General_CI_AI NULL,
 CONSTRAINT [pkNOTAFISCALIMAGEM] PRIMARY KEY CLUSTERED 
(
	[cdNotaFiscalImagem] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [NOTAFISCALIMAGEM]
) ON [NOTAFISCALIMAGEM]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixNotaFiscalmagem01] ON [dbo].[NOTAFISCALIMAGEM] 
(
	[cdNotaFiscal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[LOGALTERACAONOTAFISCAL]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LOGALTERACAONOTAFISCAL](
	[cdLogAlteracaoNotaFiscal] [int] IDENTITY(1,1) NOT NULL,
	[cdNotaFiscal] [int] NOT NULL,
	[cdUsuarioInclusao] [int] NOT NULL,
	[nrProcesso] [varchar](50) COLLATE Latin1_General_CI_AI NOT NULL,
	[dcObservacao] [varchar](300) COLLATE Latin1_General_CI_AI NOT NULL,
	[dtInclusao] [smalldatetime] NOT NULL,
 CONSTRAINT [pkLOGALTERACAONOTAFISCAL] PRIMARY KEY CLUSTERED 
(
	[cdLogAlteracaoNotaFiscal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HISTORICOIMPRESSAONOTAFISCAL]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HISTORICOIMPRESSAONOTAFISCAL](
	[cdHistoricoImpressaoNotaFiscal] [int] IDENTITY(1,1) NOT NULL,
	[dtImpressao] [datetime] NOT NULL,
	[dcIpUsuarioSolicitante] [varchar](50) COLLATE Latin1_General_CI_AI NULL,
	[dcEmailTomador] [varchar](150) COLLATE Latin1_General_CI_AI NULL,
	[inSegundaVia] [char](1) COLLATE Latin1_General_CI_AI NULL,
	[cdNotaFiscal] [int] NOT NULL,
	[cdUsuarioLogado] [int] NULL,
 CONSTRAINT [pkHISTORICOIMPRESSAONOTAFISCAL] PRIMARY KEY CLUSTERED 
(
	[cdHistoricoImpressaoNotaFiscal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixHistoricoImpressaoNotaFiscal01] ON [dbo].[HISTORICOIMPRESSAONOTAFISCAL] 
(
	[cdNotaFiscal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixHistoricoImpressaoNotaFiscal02] ON [dbo].[HISTORICOIMPRESSAONOTAFISCAL] 
(
	[cdUsuarioLogado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[HISTORICOIMPRESSAONOTAFISCAL].[inSegundaVia]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[HISTORICOIMPRESSAONOTAFISCAL].[inSegundaVia]' , @futureonly='futureonly'
GO
/****** Object:  Table [dbo].[DOCUMENTORETIFICADO]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOCUMENTORETIFICADO](
	[cdDocumentoRetificado] [int] IDENTITY(1,1) NOT NULL,
	[dtRetificacao] [datetime] NOT NULL,
	[vlRetificado] [decimal](18, 2) NOT NULL,
	[vlISS] [decimal](18, 2) NOT NULL,
	[cdUsuarioRetificacao] [int] NOT NULL,
	[cdDocumento] [int] NOT NULL,
	[vlDiferenca] [decimal](18, 2) NOT NULL,
	[vlAliquota] [decimal](18, 2) NOT NULL,
 CONSTRAINT [pkDOCUMENTORETIFICADO] PRIMARY KEY CLUSTERED 
(
	[cdDocumentoRetificado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [ixDocumentoRetificado01] ON [dbo].[DOCUMENTORETIFICADO] 
(
	[cdDocumento] ASC
)
INCLUDE ( [vlRetificado],
[vlISS]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixDocumentoRetificado02] ON [dbo].[DOCUMENTORETIFICADO] 
(
	[cdUsuarioRetificacao] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[DOCUMENTONOTAFISCAL]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DOCUMENTONOTAFISCAL](
	[cdDocumentoNotaFiscal] [int] IDENTITY(1,1) NOT NULL,
	[cdNotafiscal] [int] NOT NULL,
	[cdDocumento] [int] NOT NULL,
 CONSTRAINT [pkDOCUMENTONOTAFISCAL] PRIMARY KEY CLUSTERED 
(
	[cdDocumentoNotaFiscal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixDocumentoNotaFiscal02] ON [dbo].[DOCUMENTONOTAFISCAL] 
(
	[cdDocumento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixDocumentoNotaFiscal03] ON [dbo].[DOCUMENTONOTAFISCAL] 
(
	[cdNotafiscal] ASC,
	[cdDocumento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[DOCUMENTOANULADO]    Script Date: 04/02/2013 11:32:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DOCUMENTOANULADO](
	[cdDocumentoAnulado] [int] IDENTITY(1,1) NOT NULL,
	[nrExercicio] [smallint] NOT NULL,
	[nrMes] [smallint] NOT NULL,
	[dcMotivo] [varchar](255) COLLATE Latin1_General_CI_AI NOT NULL,
	[nrDocumentoAnulado] [numeric](19, 0) NOT NULL,
	[cdSerieNotaFiscal] [int] NOT NULL,
	[cdPessoa] [int] NOT NULL,
	[cdNotaFiscal] [int] NULL,
 CONSTRAINT [pkDOCUMENTOANULADO] PRIMARY KEY CLUSTERED 
(
	[cdDocumentoAnulado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixDocumentoAnulado01] ON [dbo].[DOCUMENTOANULADO] 
(
	[cdNotaFiscal] ASC,
	[cdPessoa] ASC,
	[nrDocumentoAnulado] ASC,
	[nrExercicio] ASC
)
INCLUDE ( [nrMes]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 100) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixDocumentoAnulado02] ON [dbo].[DOCUMENTOANULADO] 
(
	[nrDocumentoAnulado] ASC,
	[cdPessoa] ASC,
	[cdSerieNotaFiscal] ASC
)
INCLUDE ( [cdNotaFiscal]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixDocumentoAnulado03] ON [dbo].[DOCUMENTOANULADO] 
(
	[nrExercicio] ASC,
	[cdPessoa] ASC
)
INCLUDE ( [nrMes],
[nrDocumentoAnulado],
[cdNotaFiscal]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[CARTACORRECAO]    Script Date: 04/02/2013 11:32:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CARTACORRECAO](
	[cdNotaFiscal] [int] NOT NULL,
	[dtGeracao] [datetime] NOT NULL,
	[dcDescricao] [varchar](5000) COLLATE Latin1_General_CI_AI NOT NULL,
	[bbImagemCarta] [varbinary](max) NOT NULL,
 CONSTRAINT [pkCARTACORRECAO] PRIMARY KEY CLUSTERED 
(
	[cdNotaFiscal] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO



/****** Object:  Table [dbo].[REQUISICAOSERIENOTAFISCALATIVIDADE]    Script Date: 04/02/2013 11:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[REQUISICAOSERIENOTAFISCALATIVIDADE](
	[cdRequisicaoSerieNotaFiscalAtividade] [int] IDENTITY(1,1) NOT NULL,
	[cdRequisicaoSerieNotaFiscal] [int] NOT NULL,
	[cdAtividade] [int] NOT NULL,
 CONSTRAINT [pkREQUISICAOSERIENOTAFISCALATIVIDADE] PRIMARY KEY CLUSTERED 
(
	[cdRequisicaoSerieNotaFiscalAtividade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX [ixRequisicaoSerieNotaFiscalAtividade01] ON [dbo].[REQUISICAOSERIENOTAFISCALATIVIDADE] 
(
	[cdRequisicaoSerieNotaFiscal] ASC,
	[cdAtividade] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[PAGAMENTODOCUMENTO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PAGAMENTODOCUMENTO](
	[cdPagamentoDocumento] [int] IDENTITY(1,1) NOT NULL,
	[cdPagamento] [int] NOT NULL,
	[cdDocumento] [int] NOT NULL,
	[inCancelado] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkPAGAMENTODOCUMENTO] PRIMARY KEY CLUSTERED 
(
	[cdPagamentoDocumento] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
CREATE NONCLUSTERED INDEX [ixPagamentoDocumento01] ON [dbo].[PAGAMENTODOCUMENTO] 
(
	[cdDocumento] ASC,
	[inCancelado] ASC
)
INCLUDE ( [cdPagamento]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
CREATE NONCLUSTERED INDEX [ixPagamentoDocumento02] ON [dbo].[PAGAMENTODOCUMENTO] 
(
	[cdPagamento] ASC,
	[inCancelado] ASC
)
INCLUDE ( [cdDocumento]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [INDEXES]
GO
/****** Object:  Table [dbo].[PAGAMENTODOCUMENTORETIFICADO]    Script Date: 04/02/2013 11:32:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PAGAMENTODOCUMENTORETIFICADO](
	[cdPagamentoDocumentoRetificado] [int] IDENTITY(1,1) NOT NULL,
	[cdPagamento] [int] NOT NULL,
	[cdDocumentoRetificado] [int] NOT NULL,
	[inCancelado] [char](1) COLLATE Latin1_General_CI_AI NOT NULL,
 CONSTRAINT [pkPAGAMENTODOCUMENTORETIFICADO] PRIMARY KEY CLUSTERED 
(
	[cdPagamentoDocumentoRetificado] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PAGAMENTODOCUMENTORETIFICADO].[inCancelado]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PAGAMENTODOCUMENTORETIFICADO].[inCancelado]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindefault @defname=N'[dbo].[dfZero]', @objname=N'[dbo].[PAGAMENTODOCUMENTORETIFICADO].[inCancelado]' , @futureonly='futureonly'
GO
EXEC sys.sp_bindrule @rulename=N'[dbo].[chkZeroUm]', @objname=N'[dbo].[PAGAMENTODOCUMENTORETIFICADO].[inCancelado]' , @futureonly='futureonly'
GO