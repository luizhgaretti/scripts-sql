--#####################
--# MANIPULANDO DATAS #
--#####################

Select 
	datepart(dd, getdate()) as Dia
,	datepart(mm, getdate()) as Mes
,	datepart(yy, getdate()) as Ano

declare @Data SmallDateTime
set @Data = '20080101'
Select 
	datediff (day, @Data, GetDate()) as dias --Diferença em Dias da data que colocou
,	datediff (month, @Data, GetDate()) + 1 as Mes --Diferença em Meses da data que colocou
,	datediff (year, @Data, GetDate()) as Ano --Diferença em Anos da data que colocou
,	datediff (hour, @Data, GetDate()) as Horas
,	datediff (minute, @Data, GetDate()) as Minutos
,	datediff (second, @Data, GetDate()) as Segundos

/* Validando Datas e Numeros */
select isdate (@Data) as DtValida -- Datas
select isnumeric (123) as NumValido-- Numero

/* Conversão de date em varchar */
SELECT 'A data de hoje é: ' + CAST(@Data as varchar(11))
SELECT 'A data de hoje é: ' + CONVERT(varchar(11),@Data)


-- Uma maneira mais precisa de calcular a idade de uma pessoa
Declare @DtNasc smalldatetime
Set @DtNasc = '19810810'

Select	Idade = (Year(getdate()) - year(@DtNasc)) + 
		Case 
			When month(getdate()) < month(@DtNasc) 
				Then -1 
		Else	Case 
					When month(getdate()) = month(@DtNasc) 
						 and day(getdate()) > day(@DtNasc) 
					Then - 1 
				Else 0 
				End 
		End
