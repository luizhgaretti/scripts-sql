--CLIENTE
SELECT
isnull(tt_end_TMP.bairro, '')	AS	bairs	,
isnull(tt_end_TMP.codcep + tt_end_TMP.codlog, '') 	AS	ceps	,
isnull(tt_end_TMP.nomcid, '')	AS	cidas	,
isnull(tt_end_TMP.comple, '')	AS	compls	,
isnull(TW_CLI_TMP.conjug, '')	AS	conjuges	,
isnull(tt_cli.numdoc, '') 	AS	cpfs	,
isnull(tt_end_TMP.codddd, '')	AS	ddds	,
isnull(tw_cli_TMP.e_mail, '')	AS	emails	,
isnull(tt_end_TMP.endere, '')	AS	endes	,
isnull(tt_end_TMP.sigest, '')	AS	estas	,
isnull('CLIVAR', '') AS	grupos	,
isnull('FUNCIONARI', '') AS	grupovens	,
--'criar autonumerico'  AS	iclis	,
isnull(TW_CLI_TMP.datnas, '')	AS	nascs	,
isnull(TW_CLI_TMP.obsout, '')	AS	obs	,
isnull(tt_cli.nomcli, '')	AS	razaos	,
isnull(tt_cli.nomcli, '')	AS	rclis	,
isnull(tt_cli.numdoc	, '') AS	rgs	,
isnull(tt_end_TMP.numfon, '')	AS	tel1s	,
CASE WHEN tt_cli.tipdoc	= 'RG' THEN '1' ELSE '2' END AS	tpclis	,
isnull(tt_end_TMP.codcid, '')	AS	nmuncips	,
isnull(tt_cli.insest, '')	AS	IE
FROM TT_CLI
JOIN TT_END_TMP ON TT_CLI.CODCLI = TT_END_TMP.CODCLI AND TT_CLI.FILCLI = TT_END_TMP.FILCLI 
LEFT JOIN TW_CLI_TMP ON TT_CLI.NUMDOC = TW_CLI_TMP.NUMDOC  AND TT_CLI.FILCLI = TW_CLI_TMP.FILCLI 