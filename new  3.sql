4)	Crie um procedimento chamado PRC_DELETA_PRODUTO que receba como parâmetro o código do produto,

 verifique se existem itens de produto cadastrados que tenham o produto informado no parâmetro

antes de deletar o produto.

Inclua 2 parametros ao final da lista de parâmetros chamado P_RETORNO do tipo in out (varchar2) e P_SALVA do tipo booleano, após o insert verifique se p_salva é verdadeiro e nesse caso realize um commit. Caso existam itens não faça a exclusão e retorne pelo parâmetro p_retorno a mensagem ‘produto não pode ser excluido’

create or replace procedure PRC_DELETA_PRODUTO(
	p_cod_produto in produto.cod_produto%type,
	p_retorno in out varchar2,	p_salva boolean ) is

	x number;
begin
	p_retorno:= null
	select nvl(cod_produto,0) into x from item_pedido
		where cod_produto=p_cod_produto;

		if x = 0 then
			delete * from produto where cod_produto=p_cod_produto;
