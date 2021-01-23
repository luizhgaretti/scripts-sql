4)	Altere a procedure do exercício 1 para que tenha um exception chamado INCONSISTENCIA_DADOS para que em caso de dados inconsistentes realize um raise usando esse exception. A procedure deverá tratar os problemas decorrentes de exception. Mude o nome da procedure para prc_insere_cliente 2


create or replace procedure prc_insere_cliente_2 (p_cod_cliente in cliente.cod_cliente%type,p_nom_cliente in cliente.nom_cliente%type)
is

begin

if length(p_nom_cliente) <3 then

raise_application_error (-20100, 'nome deve conter tres ou mais caracteres');

end if;

if p_cod_cliente <=0 then

raise_application_error (-20200, 'codigo deve ser maior que zero');

end if;

insert into cliente (cod_cliente, nom_cliente) values (P_cod_cliente, p_nom_cliente);

dbms_output.put_line ('insercao realizada com sucesso');

end prc_insere_cliente;
/