7)	CRIE UM TRIGGER CHAMADO TRG_DELETA_PEDIDO_ITENS PARA A AÇÃO DE DELETE NA TABELA DE PEDIDOS PARA QUE ESTE TRIGGER DELETE OS ITENS LIGADOS AO PEDIDOS QUE ESTÁ SENDO DELETADO. 

create or replace trigger TRG_DELETA_PEDIDO_ITENS before delete on pedido
	for each row
begin
	delete item_pedido where cod_pedido = :old.cod_pedido;
end;

