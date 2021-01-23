3)	Faça uma Função chamada fun_total_pedido, para que faça uma totalização (usando sum) dos pedidos a partir de um código de cliente informado por parâmetro. Crie os tratamentos de exceptions necessários. Cuidado não use RAISE_APPLICATION_ERROR.

create or replace function fun_total_pedido(p_cod_cliente in cliente.cod_cliente%type)
	return varchar2 is 
	x numeric(12,2);
begin
	select sum(VAL_TOTAL_PEDIDO) into x from pedido
		where cod_cliente=p_cod_cliente;
		
		
		 