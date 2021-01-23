1)	Faça uma procedure chamada prc_insere_cliente para inserir dados na tabela de clientes, valide os campos para que caso eles estejam incompletos lance um raise_application_error mostrando os dados que não estejam de acordo com as regras:
Nome deve ter 3 ou mais caracteres
Código deve ser maior que zero
(nota:  cuidado com OTHERS pois caso um raise_application_error seja feito na seção de begin  isso fará com que seja acionado)


create or replace procedure prc_insere_cliente(
	p_cod_cliente in cliente.cod_cliente%type,
	p_nom_cliente in cliente.nom_cliente%type,
	p_des_razao_social in cliente.des_razao_social%type,
	p_tip_pessoa in cliente.tip_pessoa%type,
	p_num_cpf_cnpj in cliente.num_cpf_cnpj%type,
	p_dat_cadastro in cliente.dat_cadastro%type,
	p_dat_cancelamento in cliente.dat_cancelamento%type,
	p_sta_ativo in cliente.sta_ativo%type)is
	x integer;
begin
	
	if p_cod_cliente <= 0 then
		raise_application_error(-20001,'Codigo invalido');
	else
		select length(nom_cliente) into x from cliente where cod_cliente=p_cod_cliente;
			if x < 3 then
				raise_application_error(-20002,'Quantidade invalida de caracterer');
			else
			insert into cliente values(p_cod_cliente,p_nom_cliente,p_des_razao_social,p_tip_pessoa,p_num_cpf_cnpj,p_dat_cadastro,p_dat_cancelamento,p_sta_ativo);
			end if;
	end if;
end;
	
	
	
	
	
	