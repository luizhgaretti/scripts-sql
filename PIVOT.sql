/***************************************************************
 * Usando o comando PIVOT, converte valores(linhas) em colunas *
 ***************************************************************/

--Definição do PIVOT e UNPIVOT
--http://msdn2.microsoft.com/en-us/library/ms177410.aspx

--Criando a tabela para o exemplo
create table TbPontuacao (
	NmPess	varchar(30)
,	NmProd	varchar(30)
,	QtPont	int	
) 
--drop table TbPontuacao

-- Populando a tabela
insert into TbPontuacao values ('Alex', 'Camisa', 50)
insert into TbPontuacao values ('Antonio', 'Camisa', 50)
insert into TbPontuacao values ('Alex', 'Gravata', 20)
insert into TbPontuacao values ('Batoré', 'Gravata', 20)
insert into TbPontuacao values ('Tiririca', 'Calça', 100)
insert into TbPontuacao values ('Barnabé', 'Calça', 100)
insert into TbPontuacao values ('Batoré', 'Camisa', 50)
insert into TbPontuacao values ('Alex', 'Calça', 100)
insert into TbPontuacao values ('Tiririca', 'Gravata', 20)
insert into TbPontuacao values ('Alex', 'Gravata', 20)

-- O Exemplo
Select * From TbPontuacao
PIVOT	(Sum (QtPont) for NmProd IN ([Camisa],[Gravata],[Calça])) Pvt

--Autor: Antonio Alex
--Data.: 02/03/2008
--Email: pessoalex@hotmail.com
-----------------------------------------------------------


--#1 PIVOT 
use TSQL2012
go

WITH PivotData AS
(
SELECT
custid , -- grouping column
shipperid, -- spreading column
freight -- aggregation column
FROM Sales.Orders
)
SELECT custid, [1], [2], [3]
FROM PivotData
PIVOT(SUM(freight) FOR shipperid IN ([1], [2], [3])) AS P;



-- CUIDADO --------
--Quando usamos o PIVOT, o agrupamento dos dados é feito por eliminação,
-- devemos então, criar uma CTE trazer só as colunas que precisamos.
-- São 3 no total: Coluna que agrupa, espelho e agregação


SELECT custid, [1], [2], [3]
FROM Sales.Orders
PIVOT(SUM(freight) FOR shipperid IN ([1],[2],[3]) ) AS P;


--#2 PIVOT 2

WITH PivotData AS
(
SELECT YEAR(orderdate) AS orderyear, shipperid, shippeddate
FROM Sales.Orders
)
SELECT orderyear, [1], [2], [3]
FROM PivotData
PIVOT( MAX(shippeddate) FOR shipperid IN ([1],[2],[3]) ) AS P;


--#3 PIVOT 3 -- Não aceita COUNT(*)

-- ERROR
WITH PivotData AS
(
SELECT
custid , -- grouping column
shipperid -- spreading column
FROM Sales.Orders
)
SELECT custid, [1], [2], [3]
FROM PivotData
PIVOT( COUNT(*) FOR shipperid IN ([1],[2],[3]) ) AS P;


--#3.1 Arrumando o GAP

WITH PivotData AS
(
SELECT
custid , -- grouping column
shipperid, -- spreading column
1 AS aggcol -- aggregation column
FROM Sales.Orders
)
SELECT custid, [1], [2], [3]
FROM PivotData
PIVOT( COUNT(aggcol) FOR shipperid IN ([1],[2],[3]) ) AS P;