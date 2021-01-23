6)	CRIE UM TRIGGER CHAMADO TRG_VALOR_PEDIDO_MINIMO QUE GARANTA QUE PARA INSERIR UM PEDIDO ESTE DEVERÁ TER O SEU VALOR TOTAL MAIOR OU IGUAL A 30, CASO SEJA VIOLADA A REGRA PROVOQUE FALHA DO TRIGGER INFORMANDO QUE A REGRA FOI VIOLADA.

create or replace trigger TRG_VALOR_PEDIDO_MINIMO before insert on pedido
	for each row
begin
	if :new.val_total_pedido < 30 then 
		raise_application_error(-20001,'Valor menor que 30 e invalido');
	end if;
end;