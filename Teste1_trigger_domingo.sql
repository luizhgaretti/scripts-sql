1)	CRIE UM TRIGGER CHAMADO TRG_IMPEDE_CLIENTE NA TABELA DE CLIENTE PARA QUE IMPEÇA A 
INSERÇÃO DE NOVOS CLIENTES AOS  DOMINGOS.  
DICA (CONVERTA A DATA DO SISTEMA PARA CHAR E DESCUBRA O DIA DA SEMANA)

create or replace trigger TRG_IMPEDE_CLIENTE before insert on cliente

begin

if to_char(sysdate,'D')=1 then
raise_application_error(-20001,'Não é permitido inserção aos domingos');
	return;
			end if;	
end;

_______________________________________________________________________________________________________

create or replace trigger TRG_IMPEDE_CLIENTE before insert on cliente

begin 

if to_char(sysdate 'D')=1 then
raise_application_error(-20001,'Proibido inserir dados aos domingos');
return;
end if;
end;
______________________________________________________________________________________________________

INSERT INTO CLIENTE (COD_CLIENTE,NOM_CLIENTE) VALUES (456,'Meirieli TESTE');