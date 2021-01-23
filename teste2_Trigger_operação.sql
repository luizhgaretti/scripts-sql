2)	CRIE UM TRIGGER CHAMADO TRG_OPERACAO QUE REGISTRE NA TABELA LOC_HIST_TRANSACAO_PED 
AS INFORMACOES OCORRIDAS NA TABELA DE PEDIDOS, INFORMANDO O NOME DO USUARIO, 
A DATA , A OPERAÇÃO REALIZADA  (I=INSERT, U=UPDATE, D=DELETE). ESSE TRIGGER 
É DE DECLARAÇÃO E SÓ DEVE OCORRER 1 ÚNICA VEZ A CADA TRANSAÇÃO.
CREATE TABLE LOC_HIST_TRANSACAO_PED
(COD_PEDIDO         NUMBER(10),
 DAT_TRANSACAO  DATE,
NOM_USUARIO        VARCHAR2(30),
TIPO_OPERACAO    CHAR(1));


create or replace trigger TRG_OPERACAO after insert or update or delete on pedido
	for each row
begin
	if INSERTING  then 
		insert into LOC_HIST_TRANSACAO_PED values (:new.cod_pedido,to_date(sysdate),user,'I');
	end if;
	if updating then
		insert into LOC_HIST_TRANSACAO_PED values (:new.cod_pedido,to_date(sysdate),user,'U');
	end if;
	if deleting then 
		insert into LOC_HIST_TRANSACAO_PED values (:new.cod_pedido,to_date(sysdate),user,'D');
	end if;
end;
/