1)	Fa�a uma procedure chamada prc_consulta_cliente_param que
 receba como parametro uma cl�usula where informada durante a 
 execu��o da mesma. 
 
Caso a execu��o de algum erro fa�a o tratamento da exce��o 
(OTHERS) e retorne um erro a partir do comando 
raise_application_error. Esta procedure 
dever� retornar o c�digo e o nome dos clientes que
 forem selecionados usando para exibi��o o 
 pacote DBMS_OUTPUT
 
 select * from cliente where
 isso � a clausula Where,  -> isso cod_cliente=8;

CREATE OR REPLACE PROCEDURE prc_consulta_cliente_param 
(coluna in varchar2, operador_logico in varchar2, resultado in varchar2)
	is
	
	x varchar2(100);
	y varchar2(100);

BEGIN

execute immediate 'select cod_cliente,nom_cliente from cliente where 
'||coluna||' '||operador_logico||' '||resultado into x,y;

	DBMS_OUTPUT.PUT_LINE ('cod_cliente = '||x||' nom_cliente = '||y);
	
EXCEPTION

	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20001, 'ALGUM REGISTRO INV�LIDO FOI INSERIDO');
	
	END;
	/