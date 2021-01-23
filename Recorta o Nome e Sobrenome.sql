-- Recorta o Nome e Sobrenome

--Declare @Nome varchar(1000)
--Set @Nome = 'Luiz Henrique Garetti Rosário'

Create Table #TempNome
(
	Nome varchar(100)
)

Insert #TempNome (Nome)
Values	('Luiz Henrique Garetti Rosário'), 
		('Daniel Gomes Zaitz'),
		('João Maria da Silva')


Select	Substring(Nome,1,CHARINDEX(' ',Nome)) as Nome,
		Reverse(substring(Reverse(Nome),1,charindex(' ',reverse(Nome)))) as Sobrenome,
		Rtrim(substring(Nome,1,CHARINDEX(' ',Nome))) + '.' + Ltrim(reverse(substring(reverse(Nome),1,charindex(' ',reverse(Nome)))))
From  #TempNome

Drop Table #TempNome