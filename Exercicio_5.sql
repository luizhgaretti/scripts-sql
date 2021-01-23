5)	Crie uma procedure chamada PRC_INS_HISTORICO_PEDIDO, que receba como parâmetro o código do pedido e deverá 
realizar uma consulta na tabela de pedidos (utilize cursor para realizar esse exercício).

Caso não exista o pedido 
provoque uma exceção chamada PEDIDO_INEXISTENTE (Não esqueça de declarar esta exceção). 

Caso exista o pedido 
realize um insert na tabela de histórico de pedidos.
 
	create or replace procedure PRC_INS_HISTORICO_PEDIDO (p_
	cod_pedido in pedido.cod_pedido%type) is


	cursor consulta_pedido is select * from pedido
	where cod_pedido=p_cod_pedido;
	 pedido_inexistente exception 
	begin

	open consulta_pedido;

	fetch consulta_pedido into consulta_pedido.cod_pedido ;

	if consulta_pedido%notfound
	then raise pedido_inexistente;

	else
	insert into historico_pedido (cod_pedido, dat_pedido) values (585, null);
	end if;

	exception

	when pedido_inexistente then

	raise_application_error (-20002,'errou');

	end;






