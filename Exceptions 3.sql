3)	Fa�a uma Fun��o chamada fun_total_pedido, para que fa�a uma totaliza��o (usando sum) dos pedidos a partir de um c�digo de cliente informado por par�metro. Crie os tratamentos de exceptions necess�rios. Cuidado n�o use RAISE_APPLICATION_ERROR.

create or replace function fun_total_pedido(p_cod_cliente in cliente.cod_cliente%type)
	return varchar2 is 
	x numeric(12,2);
begin
	select sum(VAL_TOTAL_PEDIDO) into x from pedido
		where cod_cliente=p_cod_cliente;
		
		
		 