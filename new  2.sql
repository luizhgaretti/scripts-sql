create or replace function fun_consulta_pedido(
  p_cod_pedido in pedido.cod_pedido%type)
  return pedido.val_total_pedido%type is
begin
  for x in (select val_total_pedido from pedido
            where cod_pedido=p_cod_pedido)loop
            return x.val_total_pedido;
            end loop;
end fun_consulta_pedido;
/




1)	Faça uma procedure chamada prc_insere_nf para inserir dados na tabela de nota fiscal, inclua 2 parametros ao final da lista de parâmetros chamado P_RETORNO do tipo in out (varchar2) e P_SALVA do tipo booleano, após o insert verifique se p_salva é verdadeiro e nesse caso realize um commit.


create or replace procedure prc_insere_pedido(
	P_COD_PEDIDO in pedido.cod_pedido%type,
	P_COD_PEDIDO_RELACIONADO in pedido.cod_pedido_relacionado%type,
	P_COD_CLIENTE in pedido.cod_cliente%type,
	P_COD_USUARIO in pedido.cod_usuario%type,
	P_COD_VENDEDOR in pedido.cod_vendedor%type,
	P_DAT_PEDIDO in pedido.dat_pedido%type,
	P_DAT_CANCELAMENTO in pedido.dat_cancelamento%type,
	P_DAT_ENTREGA in pedido.dat_entrega%type,
	P_VAL_TOTAL_PEDIDO in pedido.val_total_pedido%type,
	P_VAL_DESCONTO in pedido.val_desconto%type,
	P_SEQ_ENDERECO_CLIENTE in pedido.seq_endereco_cliente%type,
	p_retorno in out varchar2,
	p_salva boolean ) is
	x varchar2(90);
begin
	
	p_retorno := NULL;
	
	if P_COD_PEDIDO < 0 then
		raise_application_error(-20001,'codigo invalido deve ser maior que zero');
	end if;
	
	select nvl(cod_pedido,0) into x from pedido where cod_pedido=P_COD_PEDIDO;
		if x > 0 then 
			raise_application_error(-20002,'pedido ja existe');
			return;
		end if;
	
	insert into pedido 
		values (P_COD_PEDIDO,P_COD_PEDIDO_RELACIONADO,P_COD_CLIENTE,
		P_COD_USUARIO,P_COD_VENDEDOR,P_DAT_PEDIDO,
		P_DAT_CANCELAMENTO,P_DAT_ENTREGA,P_VAL_TOTAL_PEDIDO,
		P_VAL_DESCONTO,P_SEQ_ENDERECO_CLIENTE);
	
	if p_salva = true then
		commit;
	end if;
end;
/


2)	Crie uma função chamada FUN_CONSULTA_CLIENTE que receba como parâmetro o código do cliente e retorne o nome do cliente. Caso o cliente não exista retorne nulo.

create or replace function FUN_CONSULTA_CLIENTE(
	p_cod_cliente in cliente.cod_cliente%type) return varchar2 is 

	v_pesquisa number;

begin

	select nvl(cod_cliente,0) into v_pesquisa from cliente
		where cod_cliente=p_cod_cliente;
	
		if v_pesquisa = 0 then
			return null;
		else
			for x in (select nom_cliente from cliente
				where cod_cliente=p_cod_cliente)
					loop
						return x.nom_cliente;
					end loop;
		end if;
	end;
/

3)	Altere a procedure do exercício 1 para chamar a função do exercício 2, caso o retorno da função seja nulo não realize o insert e retorne a string ‘cliente não cadastrado’ através do parâmetro p_retorno e não faça o insert da nota fiscal

create or replace procedure prc_insere_pedido(
	P_COD_PEDIDO in pedido.cod_pedido%type,
	P_COD_PEDIDO_RELACIONADO in pedido.cod_pedido_relacionado%type,
	P_COD_CLIENTE in pedido.cod_cliente%type,
	P_COD_USUARIO in pedido.cod_usuario%type,
	P_COD_VENDEDOR in pedido.cod_vendedor%type,
	P_DAT_PEDIDO in pedido.dat_pedido%type,
	P_DAT_CANCELAMENTO in pedido.dat_cancelamento%type,
	P_DAT_ENTREGA in pedido.dat_entrega%type,
	P_VAL_TOTAL_PEDIDO in pedido.val_total_pedido%type,
	P_VAL_DESCONTO in pedido.val_desconto%type,
	P_SEQ_ENDERECO_CLIENTE in pedido.seq_endereco_cliente%type,
	p_retorno in out varchar2,p_salva boolean ) is
	
	x varchar2(10);
	
begin
	
	p_retorno := NULL;
	
	if P_COD_PEDIDO < 0 then
		raise_application_error(-20001,'codigo invalido deve ser maior que zero');
	end if;
	
	x := FUN_CONSULTA_CLIENTE(P_COD_CLIENTE);
	
	if x = 'nulo' then 
	  raise_application_error(-20001,'cliente não cadastrado');
      return;
   end if;
	
	
	insert into pedido 
		values (P_COD_PEDIDO,P_COD_PEDIDO_RELACIONADO,P_COD_CLIENTE,
		P_COD_USUARIO,P_COD_VENDEDOR,P_DAT_PEDIDO,
		P_DAT_CANCELAMENTO,P_DAT_ENTREGA,P_VAL_TOTAL_PEDIDO,
		P_VAL_DESCONTO,P_SEQ_ENDERECO_CLIENTE);
	
	if p_salva = true then
		commit;
	end if;
end;
/






5)	Crie uma procedure chamada prc_insere_item_nf_RMnnnnn incluindo todos os parâmetros da tabela de nota fiscal e de itens (exceto a NF do item , pois já existe a coluna na tabela NF) , chame a procedure do exercício 1 para inserir as notas fiscais. Inclua 2 parametros ao final da lista de parâmetros chamado P_RETORNO do tipo in out (varchar2) e P_SALVA do tipo booleano, após o insert verifique se p_salva é verdadeiro e nesse caso realize um commit. Caso ocorra um retorno do procedimento do exercício 1 através do parâmetro p_retorno , não realize a inserção do item da nota fiscal.
….

6)	 Faça uma função chamada FUN_CONSULTA_PRODUTO que receba como parametro o código do produto e retorne o nome do produto. Caso não encontre retorne nulo.

create or replace function FUN_CONSULTA_PRODUTO(
	p_cod_produto in produto.cod_produto%type) return varchar2 is
	x number;
begin 
	select nvl(cod_produto,0) into x from produto 
		where cod_produto=p_cod_produto;
		
		if x = 0 then return null;
				
else 
			for y in (select nom_produto from produto 
		where cod_produto=p_cod_produto)
			loop return y.nom_produto; 
			end loop;
		end if;
end;
/


7)	Altere o procedimento do exercício 5 para executar a função do exercício 6 e caso retorne nulo não faça a inserção do item da nota fiscal e retorne através do parâmetro p_retorno a mensagem produto não cadastrado.



 
