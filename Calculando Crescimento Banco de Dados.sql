/*====================================================================================
					.:: Calculando Crescimento do Banco de Dados ::. 
======================================================================================*/

-- OBS: O Insert deve ser agendado para coletar informações de acordo com a necessidade. 
--	    Isso Pode ser Diariamente, Semanal ou mensal.



-- Cria Tabela para Armazenar informações de Tamanho e Data
Create Table EstimativaDB
(
	ID		INT	IDENTITY PRIMARY KEY,
	Size	Decimal(12,2),
	Data	Smalldatetime Default (GetDate())
)
GO



-- Insert para coletar informações de Tamanho do BD e Data
Insert EstimativaDB (Data, Size)
Select 
	CONVERT(varchar(12), GETDATE(),110) as Data,
	CONVERT(decimal(12,2), ROUND(size/128.000,2)) as SizeMB
From sys.sysfiles
Where Groupid <> 0
GO



-- Simulando o crescimento da base de dados (Neste caso fazendo insert nessa tabela para aumentar o tamanho do BD)
Create Table Teste
(
	Campo1 Varchar(5000),
	Campo2 Varchar(5000)
)
GO



Insert Teste (Campo1, Campo2)
Values ('jshjkahdjshjhsajkdhjkashdjkuyuyu239617263478647jshjkahdjshjhsajkdhjkashdjkuyuyu23961726347864782154178412969723689342364782346378267834268215jshjkahdjshjhsajkdhjkashdjkuyuyu239617263478647821541784129697236893423647823463782678342641jshjjshjkahdjshjhsajkdhjkashdjkuyuyu2396172634786478215417841296972368934236478234637826783426kahdjshjhsajshjkahdjshjhsajkdhjkashdjkuyuyu2396172634786478215417841296972368934236478234637826783426jkdhjkashdjkuyuyu23961726347864782154178412969723689342364782346378267834267841296972368934236478234637826783426',
	   'jshjkahdjshjhsajkdhjkashdjkuyuyu239617263478647jshjkahdjshjhsajkdhjkashdjkuyuyu23961726347864782154178412969723689342364782346378267834268215jshjkahdjshjhsajkdhjkashdjkuyuyu239617263478647821541784129697236893423647823463782678342641jshjjshjkahdjshjhsajkdhjkashdjkuyuyu2396172634786478215417841296972368934236478234637826783426kahdjshjhsajshjkahdjshjhsajkdhjkashdjkuyuyu2396172634786478215417841296972368934236478234637826783426jkdhjkashdjkuyuyu239617263478647821541784129697236893423647823463782jshjkahdjshjhsajkdhjkashdjkuyuyu239617263478647jshjkahdjshjhsajkdhjkashdjkuyuyu23961726347864782154178412969723689342364782346378267834268215jshjkahdjshjhsajkdhjkashdjkuyuyu239617263478647821541784129697236893423647823463782678342641jshjjshjkahdjshjhsajkdhjkashdjkuyuyu2396172634786478215417841296972368934236478234637826783426kahdjshjhsajshjkahdjshjhsajkdhjkashdjkuyuyu2396172634786478215417841296972368934236478234637826783426jkdhjkashdjkuyuyu2396172634786478215417841296972368934236478234637826783426784129697236893423647823463782678342667834267841296972368934236478234637826783426')
GO 1000



Select * from EstimativaDB
GO