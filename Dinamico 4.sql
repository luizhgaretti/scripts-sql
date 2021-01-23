4)	Faça uma procedure chamada prc_elimina_tabela que receba como parâmetro o nome da tabela e a mesma realize o drop da tabela informada no parametro.
Caso o comando falhe trate a exceção mostrando que houve um erro de sintaxe, se quiser exiba o erro usando a função SQLERRM e SQLCODE

create or replace procedure prc_elimina_tabela (p_nome_tabela in varchar2) is

x varchar2(100):=p_nome_tabela;

begin

execute immediate 'drop table '||x;

Exception

	when others then	
		raise_application_error(-20001,'erro - '||sqlcode||' and '||sqlerrm);
		
end;
/

create table teste (cod_teste int);

exec prc_elimina_tabela('teste');