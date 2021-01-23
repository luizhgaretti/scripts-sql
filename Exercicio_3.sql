3)	Fa�a uma Fun��o chamada fun_total_pedido, para que fa�a uma totaliza��o (usando sum) dos pedidos a partir de um c�digo de cliente informado por par�metro. Crie os tratamentos de exceptions necess�rios. Cuidado n�o use RAISE_APPLICATION_ERROR.

create or replace function fun_total_pedido (p_cod_pedido in pedido.cod_pedido%type) return number is

x number;

begin

select sum(val_total_pedido) into x from pedido
where cod_pedido=p_cod_pedido;

return x;

end fun_total_pedido;
/
