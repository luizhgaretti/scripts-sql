/*
  Author: Fabiano Neves Amorim
  E-Mail: famorim@solidq.com
  Empresa: SolidQ
  http://blogs.solidq.com/fabianosqlserver/Home.aspx
  http://www.simple-talk.com/author/fabiano-amorim/
*/


DECLARE @Amostra Float, 
        @MaiorValor Float, 
        @Dados_Tanques_Capturados VarChar(Max)

-- Dados dos números de série capturados eram sequênciais ex:
-- 1,2,3,4... N


/*
  Suponha que o valor de tanques seja 15
  e que tenhamos as seguintes amostras coletadas em 
  campo de batalha
*/
SET @Dados_Tanques_Capturados = '2, 6, 7, 14'

SET @Amostra = LEN(@Dados_Tanques_Capturados) - LEN(REPLACE(@Dados_Tanques_Capturados, ',', '')) + 1
SET @MaiorValor = SUBSTRING(@Dados_Tanques_Capturados, LEN(@Dados_Tanques_Capturados) - CHARINDEX(',', REVERSE(@Dados_Tanques_Capturados)) + 2, CHARINDEX(',', REVERSE(@Dados_Tanques_Capturados)))

SELECT @Amostra AS Amostra, 
       @MaiorValor AS MaiorValor,
       ((@MaiorValor - 1) * (@Amostra + 1)) / @Amostra AS Resultado
       
-- Aumentar dois tanques na amostra ex, 1 e 13 -- '1, 2, 6, 7, 13, 14'