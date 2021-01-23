1) Crie uma Função chamada FUN_VALIDA_PEDIDO que receba como parâmetro o código do pedido esta
função deverá consultar a tabela de Pedidos e verificar se o pedido existe, caso não exista deve retornar a 
mensagem PEDIDO NÃO CADASTRADO.  Caso exista faça uma consulta na tabela de ITENS DE PEDIDO 
 e deverá encontrar pelo menos 1 item ( USE COUNT(*) ) .  Caso encontre retorne a mensagem
PEDIDO OK, caso contrário retorne PEDIDO SEM ITENS.

create or replace function fun_valida_pedido (p_cod_pedido in pedido.cod_pedido%type)
return varchar2 is

	 x integer;
	 y integer;
	 
 begin 
  select nvl(count(cod_pedido),0) into x from pedido
     where cod_pedido=p_cod_pedido;
  if x  <= 0 then
    return 'pedido não cadastrado';
  elsif x > 0 then 
    select nvl(count(*),0) into y from item_pedido
	  where cod_pedido=p_cod_pedido;
	  	end if;
     if y >0 then
		return 'pedido ok';
	elsif y<= 0 then
		return 'pedido sem itens';
	end if;
	
 end fun_valida_pedido;
 /

var teste varchar2(900)

call FUN_VALIDA_PEDIDO(1) into :teste;










NO_DATA_FOUND: Caso não encontre nenhum registro
TOO_MANY_ROWS: Caso encontre mais de um registro
