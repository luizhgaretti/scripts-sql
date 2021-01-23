--USE COLISEU CREATE TABLE TABELA_NEW (ID INT PRIMARY KEY, NOME VARCHAR(10)) 
--USE COLISEU2 CREATE TABLE TABELA_NEW (ID INT PRIMARY KEY, NOME VARCHAR(10))

--http://ansqldba.blogspot.com.br/2012/02/adding-new-article-to-existing.html

EXEC sp_addarticle 
	@publication = 'REP_TRAN', 
	@article = 'TABELA_NEW', 
	@source_object = 'TABELA_NEW',
	@destination_table = 'TABELA_NEW',
	@source_owner = 'DBO', 
	@schema_option = 0x80030F3,
	@vertical_partition = N'FALSE', 
	@type = 'logbased',
	@force_invalidate_snapshot = 1
GO

EXEC sp_addsubscription
@publication = 'REP_TRAN',
@subscriber = 'NBCAPTASUP11',
@destination_db = 'COLISEU2'
GO

/***************************************************************************/

EXEC sp_dropsubscription
  @publication = 'REP_TRAN',
  @article = 'TABELA_NEW',
  @subscriber = 'NBCAPTASUP11';
GO

EXEC sp_droparticle @publication = 'REP_TRAN'
    ,  @article = 'TABELA_NEW'
    ,  @force_invalidate_snapshot = 1


SELECT * FROM COLISEU..TABELA_NEW

SELECT * FROM COLISEU2..TABELA_NEW

INSERT INTO COLISEU..TABELA_NEW VALUES (2, 'B')