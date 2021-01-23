/*
==================================================
= Propriedades de Colunas e Compactação de Linha =
= Fazer por Pagina (Alter table Customer Pager)  =
= Data: 01/08/2012
= Autor: Luiz Henrique
==================================================
*/

Create Table Customer
(
	CustomerID	 Int		Identity(1,1),
	CrediLine    Money		Sparse null,
	SubTotal     Money      not null
	OrderTotal   as(CrediLine + SubTotal)
) With (Data_Compression = Row)