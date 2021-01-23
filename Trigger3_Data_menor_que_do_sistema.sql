3)	CRIE UM TRIGGER CHAMADO TRG_VALIDA_PEDIDO, DE INSER��O  NA TABELA DE PEDIDOS,
 PARA VALIDAR SE A DATA DE PEDIDO � MENOR QUE A DATA DO SISTEMA, CASO ISSO N�O OCORRA PROVOQUE UMA FALHA AVISANDO QUE AS DATA DO PEDIDO � INVALIDA. 

create or replace trigger TRG_VALIDA_PEDIDO before insert on pedido
for each row

begin
	if :NEW.dat_pedido > trunc(sysdate) then
		raise_application_error(-20004,'Data do pedido invalido');
	end if;
end;


create or replace trigger TRG_teste before insert on cliente
for each row

begin
	if :NEW.DAT_CADASTRO > trunc(sysdate) then
		raise_application_error(-20004,'Data do pedido invalido');
	end if;
end;
/

insert into cliente (cod_cliente,nom_cliente,dat_cadastro) values (452,'johab','25/10/2012');