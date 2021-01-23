/***************************************************************
 * Usando o comando PIVOT, converte valores(linhas) em colunas *
 ***************************************************************/

--Defini��o do PIVOT e UNPIVOT
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
insert into TbPontuacao values ('Bator�', 'Gravata', 20)
insert into TbPontuacao values ('Tiririca', 'Cal�a', 100)
insert into TbPontuacao values ('Barnab�', 'Cal�a', 100)
insert into TbPontuacao values ('Bator�', 'Camisa', 50)
insert into TbPontuacao values ('Alex', 'Cal�a', 100)
insert into TbPontuacao values ('Tiririca', 'Gravata', 20)
insert into TbPontuacao values ('Alex', 'Gravata', 20)

-- O Exemplo
Select * From TbPontuacao
PIVOT	(Sum (QtPont) for NmProd IN ([Camisa],[Gravata],[Cal�a])) Pvt

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
--Quando usamos o PIVOT, o agrupamento dos dados � feito por elimina��o,
-- devemos ent�o, criar uma CTE trazer s� as colunas que precisamos.
-- S�o 3 no total: Coluna que agrupa, espelho e agrega��o


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


--#3 PIVOT 3 -- N�o aceita COUNT(*)

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