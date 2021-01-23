8)	CRIE UM TRIGGER CHAMADO TRG_ATUALIZA_COD_CLIENTE PARA A A��O DE UPDATE NA TABELA DE CLIENTES , CASO O CODIGO DO CLIENTE (NEW E OLD) SEJAM DIFERENTES PARA QUE FA�A A ATUALIZA��O DO CODIGO DO CLIENTE NA TABELA DE PEDIDOS PARA QUE OS PEDIDOS FIQUEM COM O NOVO C�DIGO. O QUE ACONTECEU QUANDO EXECUTOU ESSE TRIGGER? OCORRERAM FALHAS?  EXPLIQUE.

create or replace trigger TRG_ATUALIZA_COD_CLIENTE after update on cliente
	for each row
begin
	if :new.cod_cliente != :old.cod_cliente then
		update pedido set cod_cliente = :new.cod_cliente where cod_cliente = :old.cod_cliente;
	end if;
end;
/

update cliente set cod_cliente = '552' where cod_cliente = 111;
