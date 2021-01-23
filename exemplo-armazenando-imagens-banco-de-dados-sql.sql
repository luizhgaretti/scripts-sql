--Criando a Table DBFiles
CREATE TABLE DBFiles (
  id int IDENTITY(1,1) NOT NULL,
  fname nvarchar(1000) NOT NULL,
  [file] varbinary(max)
)

--Inserindo os dados, fazendo a busca das imagens e carregando para o banco através do comando Bulk
INSERT INTO DBFiles(fname, [file])
SELECT 'Reporting-Services-2008-enriched-visualization-gadgets.jpg', * 
 FROM OPENROWSET(
  BULK N'C:\Conteúdo Técnico - Microsoft\Reporting-Services-2008-enriched-visualization-gadgets.jpg',
  SINGLE_BLOB
) rs;

INSERT INTO DBFiles(fname, [file]) 
SELECT 'what-is-new-with-SQL-Server-2008.jpg', * 
 FROM OPENROWSET(
  BULK N'C:\Conteúdo Técnico - Microsoft\what-is-new-with-SQL-Server-2008.jpg',
  SINGLE_BLOB
) rs;


Select * from DBFiles