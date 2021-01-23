2)	Fa�a uma procedure chamada prc_cria_tabelas onde receba os par�metros para nome e colunas da tabela (todas as colunas em um �nico par�metro, j� separadas com virgula) ,
 utilize o execute immediate para criar estas tabelas. Caso o comando falhe trate a exce��o mostrando que houve um erro de sintaxe, se quiser exiba o erro 
 usando a fun��o SQLERRM e SQLCODE
Ex: exec prc_cria_tabelas (�TB_TESTE�,�(CODIGO NUMBER(5), NOME VARCHAR2(50))�)
SINTAXE CREATE TABLE:
CREATE TABLE nome da tabela (
Nome col          tipo[tam], ....)

create or replace procedure prc_cria_tabelas (p_nome_tabela varchar2, p_nome_coluna varchar2) is

x varchar2(1000):=p_nome_tabela;
y varchar2(1000):=p_nome_coluna;

begin
execute immediate 'create table '||x||' '||y||' ';

EXCEPTION
	when others then
		raise_application_error(-20010, 'Erro -' ||sqlcode|| ' and ' ||sqlerrm);
end;
/

exec prc_cria_tabelas('tb_teste','(cod_teste number, nom_teste varchar2(20))');
