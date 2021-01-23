INSERT INTO ROSARIO_erp..SLJCLI_RR (Tipo,    [CNPJ / CPF],     [Inscricao Est / RG],      [Razão Social],   Identificação,    Endereço,   Numero,     Complemento,      Cidade,      Estado,     Cep,  DDD,  Telefone,   Fax, email,      grupo,      bairro,     obs,  [cod capta iclis],     Pais_2,     [Data de Nascimento],   Segmento,   Vendedor,   [Data de Cadastro],  [Data Ult Alt Cadastro],     Classificação,    [Data Última Compra],   [Tabela de Desconto],  [Inscricao Suframa] ,   [telefone 2],     Municipio,  Pais, Situcao,    Inativo,      Validade,   Cargo,      Empresa,    ceptrabs ,  Conjuges ,  dtcasas ,   endtrabs,      estcivils , sexos,      cpfcs,      rgcs, emptrabs,   teltrabs,   bairtrabs,  cidatrabs ,      estatrabs,  profiss,    procons,    salarios,   dtadmis,    ccargos,    ctpdocs,      cndocs,     numtrabs,   compltrabs, cnpjtrabs,  rendafams,  cempcons,   ctelcons,      ccarcons,   pais_,      maes, nacionals,  sexcons,    class,      subclass,   codagrups,      mailnfes,   iclirdzs,   ccartoes,   dtncons,    Numero_,    ctelems,    fidelidade,      DtEmisDoc,  OrgaoEmis)
SELECT
'6' as Tipo ,
isnull(SUBSTRING(TT_CLI_NEW.NUMDOC, 1, 14), '')      AS    cpfs,
TT_CLI_NEW.INSEST AS    rgs,
/*CASE TT_CLI_NEW.FLGTIP 
	WHEN 0 THEN isnull(SUBSTRING(TT_CLI_NEW.NOMCLI+' '+TT_CLI_NEW.ULTNOM, 1, 40), '') 
      ELSE isnull(SUBSTRING(TT_CLI_NEW.NOMCLI, 1, 40), '') END   AS    razaos      ,
CASE TT_CLI_NEW.FLGTIP WHEN 0 THEN isnull(SUBSTRING(TT_CLI_NEW.NOMCLI+' '+TT_CLI_NEW.ULTNOM, 1, 40), '') 
      ELSE isnull(SUBSTRING(TT_CLI_NEW.ULTNOM, 1, 40), '') END   AS IDENTIFICACAO,*/
CASE TT_CLI_NEW.FLGTIP 
	WHEN 0 THEN ISNULL(SUBSTRING(TT_CLI_NEW.NOMCLI+' '+TT_CLI_NEW.ULTNOM, 1, 40), TT_CLI_NEW.NOMCLI)
	      ELSE SUBSTRING(TT_CLI_NEW.NOMCLI, 1, 40) END   AS    razaos      ,
CASE TT_CLI_NEW.FLGTIP 
	WHEN 0 THEN ISNULL(SUBSTRING(TT_CLI_NEW.NOMCLI+' '+TT_CLI_NEW.ULTNOM, 1, 40), TT_CLI_NEW.NOMCLI)
          ELSE isnull(SUBSTRING(TT_CLI_NEW.ULTNOM, 1, 40), '') END   AS IDENTIFICACAO,
isnull(SUBSTRING(TT_END.ENDERE, 1, 40), '')    AS    endes ,
isnull (SUBSTRING(TT_END.NUMERO, 1, 6), '') as numero,
isnull(SUBSTRING(TT_END.COMPLE,1, 20), '')     AS    compls      ,
isnull(SUBSTRING(TT_END.NOMCID, 1, 20), '')    AS    cidas ,
isnull(TT_END.SIGEST, '')    AS    estas ,
ISNULL(substring(TT_END.CODCEP + TT_END.CODLOG, 1,5) + '-' + substring(TT_END.CODCEP + TT_END.CODLOG, 6,3), '') AS CEP,
isnull(TT_END.CODDDD, '')    AS    ddds  ,
isnull(TT_END.NUMFON, '')    AS    tel1s ,
isnull(TT_END.NUMFAX,'') as fax,
isnull(TT_SPC.E_MAIL, '')    AS    emails      ,
--isnull(CASE TT_CLI_NEW.FLGTIP    WHEN 0 THEN 'CLIVAR'    WHEN 1 THEN  'FORNECEDOR' WHEN NULL THEN 'CLIVAR' END, '') AS     grupos      ,
CASE TT_CLI_NEW.FLGTIP WHEN 0 THEN 'CLIVAR'    WHEN 1 THEN  'FORNECEDOR' ELSE 'CLIVAR' END AS       grupos      ,
isnull(TT_END.BAIRRO, '')    AS    bairs ,
isnull(SUBSTRING(TT_CLI_NEW.OBSOUT, 1, 250), '')     AS    obs   ,
'' as iclis,
''  as pais_2,
isnull(TT_CLI_NEW.DATNAS, '') AS    nascs ,
'' as segmento,
'' as vendedor,
ISNULL(TT_CLI_NEW.DATOPE,'') as [Data de Cadastro],
'' as [Data Ult Alt Cadastro],
'' as Classificacao,
'' as [Data Última Compra],
'' as [Tabela de Desconto],
'' as [Inscricao Suframa],
'' as [telefone 2] ,
isnull(TT_END.CODCID, '')    AS    nmuncips    ,
isnull (convert(varchar,TT_END.CODPAI), '') as pais,
'' as situacao,
'0' as inativo,
'' as validade,
'' as cargo,
isnull(CASE TT_CLI_NEW.FILCLI  WHEN 'LCL' THEN 'LCH' WHEN '001' THEN 'LMT' ELSE  TT_CLI_NEW.FILCLI END,'') as empresa, 
'' as ceptrabs,
''    AS    conjuges    ,
'' as dtcasas,
'' as endtrabs,
isnull (CASE TT_CLI_NEW.ESTCIV    WHEN 1 THEN 'Solteiro' WHEN 2 THEN 'Casado' END, '') as estcivils,
isnull (CASE TT_CLI_NEW.CODSEX WHEN 1 THEN 'M'      WHEN 2 THEN 'F' ELSE 'N' END,'') as sexos,
--ISNULL(TT_CLI_NEW.CODSEX, '') AS SEXOS,
  '' as cpfcs,
'' as rgcs,
'' as emptrabs,
'' as teltrabs,
'' as      bairtrabs,
'' as cidatrabs ,
'' as estatrabs,
'' as profiss,
'' as procons,
'0' as      salarios,
'' as dtadmis,
'' as ccargos,
'' as ctpdocs,
'' as cndocs,
'' as numtrabs,
'' as compltrabs,
'' as cnpjtrabs,
'0' as      rendafams,
'' as cempcons,
'' as ctelcons,
'' as ccarcons,
'' as pais_,
'' as maes,
'' as nacionals,
'' as sexcons,
'' as class,
'' as subclass,
'' as codagrups,
'' as mailnfes,
'' as iclirdzs,
'' as ccartoes,
'' as dtncons,
'' as Numero_,
'' as ctelems,
'' as fidelidade,
'' as DtEmisDoc,
isnull(TT_CLI_NEW.ID_ORG, '') as id_org
FROM TT_CLI_NEW
LEFT JOIN TT_END ON TT_CLI_NEW.CODCLI = TT_END.CODCLI AND TT_CLI_NEW.FILCLI = TT_END.FILCLI 
LEFT JOIN TT_SPC ON TT_SPC.CODCLI = TT_CLI_NEW.CODCLI  AND TT_CLI_NEW.FILCLI = TT_SPC.FILCLI
WHERE TT_CLI_NEW.FILCLI = 'LSL' 
--WHERE TT_CLI_NEW.FILCLI = 'LCH' OR TT_CLI_NEW.FILCLI = 'LCL'
--WHERE TT_CLI_NEW.FILCLI = '001' OR TT_CLI_NEW.FILCLI = 'LMT'

--LRA, LCH, LSL, LTP, LSI, LHL e LMT

--isnull('FUNCIONARI', '') AS grupovens   ,

--isnull(tt_cli.nomcli, '')  AS    rclis ,



--isnull(tt_cli.insest, '')  AS    IE


--TRUNCATE TABLE ROSARIO_erp..SLJCLI_RR

--SELECT * FROM ROSARIO_erp..SLJCLI_RR where grupo IS NULL
