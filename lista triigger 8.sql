8)	CRIE UM TRIGGER CHAMADO TRG_ATUALIZA_COD_CLIENTE PARA A AÇÃO DE UPDATE NA TABELA DE CLIENTES , CASO O CODIGO DO CLIENTE (NEW E OLD) SEJAM DIFERENTES PARA QUE FAÇA A ATUALIZAÇÃO DO CODIGO DO CLIENTE NA TABELA DE PEDIDOS PARA QUE OS PEDIDOS FIQUEM COM O NOVO CÓDIGO. O QUE ACONTECEU QUANDO EXECUTOU ESSE TRIGGER? OCORRERAM FALHAS?  EXPLIQUE.

create or replace trigger TRG_ATUALIZA_COD_CLIENTE after update on cliente
	for each row
begin
	if :new.cod_cliente != :old.cod_cliente then
		update pedido set cod_cliente = :new.cod_cliente where cod_cliente = :old.cod_cliente;
	end if;
end;
/

update cliente set cod_cliente = '552' where cod_cliente = 111;
