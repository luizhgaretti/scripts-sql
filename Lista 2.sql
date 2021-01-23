                                     
Exercícios 2 – 2º Semestre / 2011
Tecnologia em Banco de Dados – 1º ANO
Procedimentos- parte 1

Fundamentos e Programação de Banco de Dados
Prof. Marcio Henrique Guimaraes Barbosa

Johab Benicio de Oliveira	   RM
65757	Turma
1ºTBDR



If p_commit then
   Commit;
End if;


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
	p_retorno in out varchar2,p_salva boolean ) is
	
	x integer;
	e pedido.cod_pedido%type;
	 y pedido.cod_cliente%type;
	 z pedido.cod_usuario%type;
	 k pedido.cod_vendedor%type;
	
begin
	savepoint inicio;
	
	if P_COD_PEDIDO <= 0 then
		raise_application_error(-20001,'codigo do peido invalido, deve ser maior que zero');
	end if;
	if P_COD_PEDIDO_RELACIONADO <= 0 then
		raise_application_error(-20001,'codigo do peido relacionado invalido deve ser maior que zero');
	end if;
	if P_COD_CLIENTE <= 0 then
		raise_application_error(-20001,'codigo do cliente invalido, deve ser maior que zero');
	end if;
	if P_COD_USUARIO <= 0 then
		raise_application_error(-20001,'codigo do usuario invalido, deve ser maior que zero');
	end if;
	if P_COD_VENDEDOR <= 0 then
		raise_application_error(-20001,'codigo do vendedor invalido, deve ser maior que zero');
	end if;
	if P_VAL_DESCONTO >= P_VAL_TOTAL_PEDIDO then
		raise_application_error(-20002,'valor de desconto invalido, deve ser menor que valor total do pedido');
	end if;
	
	select count(cod_pedido) into x from pedido
		where cod_pedido=p_cod_pedido;
	
	if x > 0  then 
	  raise_application_error(-20003,'já cadastrado');
      return;
   end if;
		if p_cod_pedido	> 0 then
				select count(cod_pedido) into e from pedido where cod_pedido = p_cod_pedido;
			end if;
		if e > 0 then
			raise_application_error(-20002, 'Pedido já cadastrado');
		else
			select count(cod_cliente) into y from cliente where cod_cliente = p_cod_cliente;
		end if;
		if y = 0 then
			raise_application_error(-20003, 'Cliente não cadastrado');
		else
			select count(cod_usuario) into z from usuario where cod_usuario = p_cod_usuario;
		end if;
		if z = 0 then
			raise_application_error(-20004, 'Usuário não cadastrado');
		else
			select count(cod_vendedor) into k from vendedor where cod_vendedor = p_cod_vendedor;
		end if;
		if k = 0 then
			raise_application_error(-20005, 'Vendendor não cadastrado');
		end if;
	insert into pedido 
		values (P_COD_PEDIDO,P_COD_PEDIDO_RELACIONADO,P_COD_CLIENTE,
		P_COD_USUARIO,P_COD_VENDEDOR,P_DAT_PEDIDO,
		P_DAT_CANCELAMENTO,P_DAT_ENTREGA,P_VAL_TOTAL_PEDIDO,
		P_VAL_DESCONTO,P_SEQ_ENDERECO_CLIENTE);
		p_retorno := 'PEDIDO CADASTRADO';
	if p_salva = true then
		commit;
	else
		ROLLBACK TO INICIO;
		p_retorno := 'PEDIDO NAO CADASTRADO';
	end if;
end;
/

2)	Crie uma função chamada FUN_CONSULTA_CLIENTE que receba como parâmetro o código do cliente e retorne o nome do cliente. Caso o cliente não exista retorne nulo.

create or replace function FUN_CONSULTA_CLIENTE(
	p_cod_cliente in cliente.cod_cliente%type) return varchar2 is 

	v_pesquisa number;

begin

	select count(cod_cliente) into v_pesquisa from cliente
		where cod_cliente=p_cod_cliente;
	
		if v_pesquisa = 0 then
			return 'nulo';
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
	
	x integer;
	e pedido.cod_pedido%type;
	 y pedido.cod_cliente%type;
	 z pedido.cod_usuario%type;
	 k pedido.cod_vendedor%type;
	 g varchar2(90);
	
begin
	savepoint inicio;
	
	
	 g := FUN_CONSULTA_CLIENTE(P_COD_CLIENTE);
	
	if y = 'nulo' then 
	
	p_retorno := 'cliente não cadastrado';
	
	else
	
	if P_COD_PEDIDO <= 0 then
		raise_application_error(-20001,'codigo do peido invalido, deve ser maior que zero');
	end if;
	if P_COD_PEDIDO_RELACIONADO <= 0 then
		raise_application_error(-20001,'codigo do peido relacionado invalido deve ser maior que zero');
	end if;
	if P_COD_CLIENTE <= 0 then
		raise_application_error(-20001,'codigo do cliente invalido, deve ser maior que zero');
	end if;
	if P_COD_USUARIO <= 0 then
		raise_application_error(-20001,'codigo do usuario invalido, deve ser maior que zero');
	end if;
	if P_COD_VENDEDOR <= 0 then
		raise_application_error(-20001,'codigo do vendedor invalido, deve ser maior que zero');
	end if;
	if P_VAL_DESCONTO >= P_VAL_TOTAL_PEDIDO then
		raise_application_error(-20002,'valor de desconto invalido, deve ser menor que valor total do pedido');
	end if;
	
	select count(cod_pedido) into x from pedido
		where cod_pedido=p_cod_pedido;
	
	if x > 0  then 
	  raise_application_error(-20003,'já cadastrado');
      return;
   end if;
		if p_cod_pedido	> 0 then
				select count(cod_pedido) into e from pedido where cod_pedido = p_cod_pedido;
			end if;
		if e > 0 then
			raise_application_error(-20002, 'Pedido já cadastrado');
		else
			select count(cod_cliente) into y from cliente where cod_cliente = p_cod_cliente;
		end if;
		if y = 0 then
			raise_application_error(-20003, 'Cliente não cadastrado');
		else
			select count(cod_usuario) into z from usuario where cod_usuario = p_cod_usuario;
		end if;
		if z = 0 then
			raise_application_error(-20004, 'Usuário não cadastrado');
		else
			select count(cod_vendedor) into k from vendedor where cod_vendedor = p_cod_vendedor;
		end if;
		if k = 0 then
			raise_application_error(-20005, 'Vendendor não cadastrado');
		end if;
	insert into pedido 
		values (P_COD_PEDIDO,P_COD_PEDIDO_RELACIONADO,P_COD_CLIENTE,
		P_COD_USUARIO,P_COD_VENDEDOR,P_DAT_PEDIDO,
		P_DAT_CANCELAMENTO,P_DAT_ENTREGA,P_VAL_TOTAL_PEDIDO,
		P_VAL_DESCONTO,P_SEQ_ENDERECO_CLIENTE);
		p_retorno := 'PEDIDO CADASTRADO';
	end if;
	if p_salva = true then
		commit;
	else
		ROLLBACK TO INICIO;
		p_retorno := 'PEDIDO NAO CADASTRADO';
	end if;
end;
/

	



4)	Crie um procedimento chamado PRC_DELETA_PRODUTO que receba como parâmetro o código do produto, antes de deletar o produto verifique se existem itens de produto cadastrados que tenham o produto informado no parâmetro. Inclua 2 parametros ao final da lista de parâmetros chamado P_RETORNO do tipo in out (varchar2) e P_SALVA do tipo booleano, após o insert verifique se p_salva é verdadeiro e nesse caso realize um commit. Caso existam itens não faça a exclusão e retorne pelo parâmetro p_retorno a mensagem ‘produto não pode ser excluido’

create or replace procedure PRC_DELETA_PRODUTO(
	p_cod_produto in produto.cod_produto%type,
	p_nom_produto in produto.nom_produto%type,
	p_cod_barra in produto.cod_barra%type,
	p_sta_ativo in produto.sta_ativo%type,
	p_dat_cadastro in produto.dat_cadastro%type,
	p_dat_cancelamento in produto.dat_cancelamento%type,
	p_retorno in out varchar2,p_salva boolean ) is
	
	x number;
begin
	savepoint inicio;
	select count(cod_produto) into x from item_pedido 
		where cod_produto=p_cod_produto;
	if x = 0 then
		delete from produto where cod_produto=p_cod_produto;
		insert into produto values(p_cod_produto,p_nom_produto,p_cod_barra,p_sta_ativo,	p_dat_cadastro,
		p_dat_cancelamento);
		p_retorno := 'PRODUTO CADASTRADO';
		
	else
		ROLLBACK TO INICIO;
		p_retorno := 'PRODUTO NAO CADASTRADO';
	end if;
	
	if p_salva = true then
			commit;
		else
			ROLLBACK TO INICIO;
			p_retorno := 'PRODUTO NAO CADASTRADO';
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
	select COUNT(cod_produto) into x from produto 
		where cod_produto=p_cod_produto;
		
			if x = 0 then return 'NULO';
				
				else 
					for y in (select nom_produto from produto 
						where cod_produto=p_cod_produto)
							loop return y.nom_produto; 
							end loop;
			end if;
end;
/

7)	Altere o procedimento do exercício 5 para executar a função do exercício 6 e caso retorne nulo não faça a inserção do item da nota fiscal e retorne através do parâmetro p_retorno a mensagem produto não cadastrado.



 
Exemplos:

Procedure de insert com validação e chamada de outras rotinas dentro da mesma

Create or replace procedure prc_insere_fornecedor 
(p_cod          in fornecedor.codigo%type,
 p_nome         in fornecedor.nome%type,
 p_telefone     in fornecedor.telefone%type,
 p_ret          out varchar2,
 p_salva        in  Boolean default false) is


begin

--setando o parametro como nulo pois não se sabe o
--que a variável tem como valor vindo do programa 
--chamador

   p_ret := null;

--fazendo uma validação para que não se insira um 
--forncedor com código zero ou menor que zero

  if p_cod < 0 then 
     raise_application_error(-20001,'codigo invalido deve ser maior que zero');

  --comando return em uma procedure aborta a execução
  --sem 
  --provocar exceção
  end if;

--chamando uma function para verificar se o fornecedor 
--já existe
   If fun_fornecedor then
      raise_application_error(-20001,'Fonecedor já cadastrado');
      return;
   end if;
   

   insert into fornecedor (codigo, nome, telefone)
   values (p_cod,p_nome,p_telefone);

-- realiza commit da transação apenas se explicitamente -- quem chamou
-- a procedure coloca o parâmetro p_salva como true

   If p_salva then	
      Commit;
   End if;

End;


Create or replace fun_fornecedor (p_cod in fornecedor.codigo%type)
return boolean is 
   --declarando um cursor para ser utilizado
   v_forn     fornecedor%rowtype;
   begin
   -- abrindo o cursor , fazendo o fetch e fechando o cursor
Select * 
Into v_forn
from fornecedor 
where codigo = p_cod;
return true;

   --caso passe neste ponto do programa é porque nao encontrou
   --caso tivesse encontrado executaria o return e sairia
Exception
   When no_data_found then
       Return false;
end;

Instruções:



Procure usar o modelo para orientar na criação das rotinas pois, lá tem o nome das tabelas e colunas , assim como seus relacionamentos

Não crie diretamente as rotinas no SQL Plus pois o seu editor é limitado , use outro editor de  texto , ao final cole no SQL Plus e coloque / para executa-lo.

Apesar das rotinas estarem na base procure copia-las em arquivo, assim fica mais fácil fazer uma manutenção , bem como para consultar quando preciso.




