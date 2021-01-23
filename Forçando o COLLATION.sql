-- Forçando o COLLATION no SELECT.


Select a.Cod_Prontuario AS Cd_Item,a.DESCRICAO_ITEM,b.COD_ALMOXARIFADO AS Cd_Item_Excel,b.DESCRICAO_ITEM AS DESCRICAO_ITEM_EXCEL  From Itens_Sybase_Producao a
INNER JOIN Itens_Excel b
on a.Cod_Prontuario = b.COD_ALMOXARIFADO
and rtrim(ltrim(a.DESCRICAO_ITEM)) COLLATE Latin1_General_CI_AI <> rtrim(ltrim(b.DESCRICAO_ITEM)) COLLATE Latin1_General_CI_AI
