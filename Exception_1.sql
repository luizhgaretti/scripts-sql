1)	Faça uma procedure chamada prc_insere_cliente para inserir dados na tabela de clientes, 
valide os campos para que caso eles estejam incompletos lance um raise_application_error 
mostrando os dados que não estejam de acordo com as regras:

Nome deve ter 3 ou mais caracteres
Código deve ser maior que zero

nota: cuidado com OTHERS pois caso um raise_application_error seja feito na seção de begin isso fará com que seja acionado.

create or replace procedure prc_insere_cliente (p_cod_cliente in cliente.cod_cliente%type,p_nom_cliente in cliente.nom_cliente%type) is

begin

if length(p_nom_cliente) <3 then
	raise_application_error(-20001,'Nome deve conter 3 caracteres ou mais');
	end if;
	
if p_cod_cliente<=0 then
	raise_application_error(-20002,'Codigo deve ser maior que zero');
	end if;
	
insert into cliente (cod_cliente, nom_cliente) values (p_cod_cliente, p_nom_cliente);	
	
	dbms_output.put_line('Dados inseridos com sucesso');

	end;
	/
	
	set serveroutput on
	
	exec prc_insere_cliente (2328,'Gustavo');
	
	


