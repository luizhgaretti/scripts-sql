3) Faça uma procedure chamada prc_altera_tabelas onde receba os parâmetros tipo alteração (‘A’  para Adicionar, ‘D’ para eliminar e ‘M’ para modificar), 
nome da tabela  e o parâmetro da alteração a ser feita. Caso o comando falhe trate a exceção mostrando que houve um erro de sintaxe, 
se quiser exiba o erro usando a função SQLERRM e SQLCODE

Ex: exec prc_altera_tabela (‘TB_TESTE’,’A’,’EMAIL VARCHAR2(50))
SINTAXE ALTER TABLE:
ALTER TABLE nome tabela [ADD/DROP/MODIFY] ALTERAÇÃO A SER REALIZADA

create or replace procedure prc_altera_tabela (p_nome_table in varchar2, p_nome_column in varchar2, p_tipo_alteracao in varchar2) is
begin
if p_tipo_alteracao='A' then
execute immediate 'alter table ' ||p_nome_table|| ' add ' ||p_nome_column;
end if;
if p_tipo_alteracao='D' then
execute immediate 'alter table ' ||p_nome_table|| ' drop column ' ||p_nome_column;
end if;
if p_tipo_alteracao='M' then
execute immediate ' alter table ' ||p_nome_table|| ' modify ' ||p_nome_column;
end if;
EXCEPTION
	when others then
raise_application_error(-20001, 'erro' ||SQLERRM||'erro '||SQLCODE);
end;
/


PRONTO..........................VAMOS EXECUTAR...........

exec prc_altera_tabela('teste1','A','nome1');
exec prc_altera_tabela('teste2','D','nome2');
exec prc_altera_tabela('teste3','M','nome3');
