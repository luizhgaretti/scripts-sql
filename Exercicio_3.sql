3)	Faça uma Função chamada fun_total_pedido, para que faça uma totalização (usando sum) dos pedidos a partir de um código de cliente informado por parâmetro. Crie os tratamentos de exceptions necessários. Cuidado não use RAISE_APPLICATION_ERROR.

create or replace function fun_total_pedido (p_cod_pedido in pedido.cod_pedido%type) return number is

x number;

begin

select sum(val_total_pedido) into x from pedido
where cod_pedido=p_cod_pedido;

return x;

end fun_total_pedido;
/
