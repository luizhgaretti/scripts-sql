-- Variaveis do Tipo Table
declare @tab TABLE (cod_cliente int, 
					qtde_pedidos varchar)

					
Select * From Produto join
	(Select * From Estoque) As Teste
On Produto.ProdCod = Teste.EstqProdCod
Where Produto.ProdCod > 0
 
 
--  Uma outra forma de inner join
Select * From Produto inner join Estoque 
On Produto.ProdCod = Estoque.EstqProdCod


Select * From Produto
Where ProdCod = (Select MAX(ProdCod) From Produto)

