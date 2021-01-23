8)	Faça uma procedure chamada prc_deleta_tabela que delete dados de qualquer tabela passada como parâmetro, a clausula where também deverá ser passada. 
Caso o comando falhe trate a exceção mostrando que houve um erro de sintaxe, se quiser exiba o erro usando a função SQLERRM e SQLCODE

create or replace procedure prc_deleta_tabela (p_nome_tabela in varchar2,p_nome_coluna in varchar2,p_operador in varchar2,p_resultado in varchar2) is

w varchar2(1000):=p_nome_tabela;
x varchar2(1000):=p_nome_coluna;
y varchar2(1000):=p_operador;
z varchar2(1000):=p_resultado;

begin
execute immediate 'delete from '||w||' where '||x||' '||y||' '||z;

exception
when others then
	raise_application_error(-20001,'erro -'||sqlcode||' and '||sqlerrm);

end;
/

--criando cliente 100
insert into cliente (cod_cliente, nom_cliente, sta_ativo) values (100,'meirieli','s');

--executando procedure deleta cliente 100
exec prc_deleta_tabela('cliente','cod_cliente','=',100); 

