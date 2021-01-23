5)	CRIE UMA TABELA CHAMADA LOC_HISTORICO_ALT_CLI COM OS CAMPOS CD_CLIENTE , NM_CLIENTE, DT_ALTERACAO, NM_USUARIO (VARCHAR2(30)), OS DEMAIS CAMPOS SEGUEM O MESMO TIPO E TAMANHO DAS COLUNAS NA TABELA LOC_CLIENTE.

 CRIE UM TRIGGER CHAMADO TRG_ATUALIZA_HIST_CLI QUE A CADA INSERT OU UPDATE DA TABELA DE CLIENTES REALIZE A INSERÇÃO NA TABELA QUE FOI CRIADA, CUIDE PARA QUE ISSO SÓ SEJA FEITO NO CASO DO NOME DO CLIENTE (NOVO-NEW) SER DIFERENTE DO NOME (VELHO-OLD). DETERMINE QUAL O ESCOPO DE TRIGGER A SER USADO (COMANDO OU DE LINHA E QUAL O MOMENTO EM QUE IRÁ DISPARAR (ANTES OU DEPOIS DOS EVENTOS))

CREATE TABLE LOC_HISTORICO_ALT_CLI(
	CD_CLIENTE integer,
	NM_CLIENTE VARCHAR2(30),
	DT_ALTERACAO DATE,
	NM_USUARIO VARCHAR2(30));

CREATE TABLE LOC_CLIENTE(
	CD_CLIENTE INTEGER,
	NM_CLIENTE VARCHAR2(30),
	DT_ALTERACAO DATE,
	NM_USUARIO VARCHAR2(30));
	
create or replace trigger TRG_ATUALIZA_HIST_CLI after insert or update on cliente
	for each row

begin
	if inserting then
		insert into LOC_CLIENTE 
		values (:new.cod_cliente,:new.nom_cliente,trunc(sysdate),user);
	end if;

	if updating then
		if :new.nom_cliente <> :old.nom_cliente then
			insert into LOC_HISTORICO_ALT_CLI 
			values (:new.cod_cliente,:new.nom_cliente,trunc(sysdate),user);
		end if;
	end if;
	
end;
/

insert into cliente (cod_cliente,nom_cliente) values (26,'johab benicio de oliveira');

update cliente set nom_cliente = 'odyllene' where cod_cliente=25;

delete cliente where cod_cliente=25;

select * from LOC_CLIENTE;

select * from LOC_HISTORICO_ALT_CLI;

